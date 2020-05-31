using Newtonsoft.Json.Linq;
using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels.Messages;
using OctopusCodesMultiVendor.Security;
using Stripe.BillingPortal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace OctopusCodesMultiVendor.Controllers.Message
{
    public class MessageApiController : ApiController
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();
        [HttpPost]
        public string AddMessage([FromBody] JObject data)
        {
            MessageDetailViewModel message = data["msgData"].ToObject<MessageDetailViewModel>();
            try
            {

                int id;
                string email,userName;
                bool isAdmin;
                SenderType currentUserType;
                GetCurrentUserIdEmail(out id, out email, out isAdmin,out currentUserType,out userName);
                MessageHeader mh = null;
                string recipientEmail = "";

                if (currentUserType == SenderType.Admin)
                {
                    
                        mh = ocmde.MessageHeaders.FirstOrDefault(a => a.AdminId == id && a.CustomerId == message.SendTo&&a.VendorId==null);
                        if (mh != null)
                        {
                            recipientEmail = ocmde.Accounts.Find(mh.CustomerId).Email;
                        }
                        else
                        {
                            mh = ocmde.MessageHeaders.FirstOrDefault(a => a.AdminId == id && a.VendorId == message.SendTo);
                            recipientEmail = ocmde.Vendors.Find(mh.VendorId).Email;
                        }
                   
                }
                if (currentUserType == SenderType.Vendor)
                {
                    mh = ocmde.MessageHeaders.FirstOrDefault(a => a.VendorId == id && a.AdminId == message.SendTo && a.CustomerId == null);
                    if (mh != null)
                    {
                        recipientEmail = ocmde.Accounts.Find(mh.AdminId).Email;
                    }
                    else
                    {
                        mh = ocmde.MessageHeaders.FirstOrDefault(a => a.VendorId == id && a.CustomerId == message.SendTo && a.AdminId == null);
                        recipientEmail = ocmde.Accounts.Find(mh.CustomerId).Email;
                    }

                }
                if (currentUserType == SenderType.Customer)
                {
                    mh = ocmde.MessageHeaders.FirstOrDefault(a => a.CustomerId == id && a.AdminId == message.SendTo && a.VendorId==null);
                    if (mh != null)
                    {
                        recipientEmail = ocmde.Accounts.Find(mh.CustomerId).Email;
                    }
                    else
                    {
                        mh = ocmde.MessageHeaders.FirstOrDefault(a => a.CustomerId == id && a.VendorId == message.SendTo && a.AdminId == null);
                        recipientEmail = ocmde.Vendors.Find(mh.VendorId).Email;
                    }
                }


                bool newconversation = false;
                if (mh == null)
                {
                    return "NOTOK";
                }
                mh.LastMessage = message.Body;
                mh.LastUpdated = DateTime.Now;
                MessageDetail messageDetail = new MessageDetail();
                messageDetail.Id = Guid.NewGuid();
                messageDetail.DateCreation = DateTime.Now;
                messageDetail.Body = message.Body;
                messageDetail.Status = true;
                messageDetail.Sender = (int)SenderType.Admin;
                mh.MessageDetails.Add(messageDetail);
                if (newconversation)
                    ocmde.MessageHeaders.Add(mh);
                ocmde.SaveChanges();
                string body = string.Format(Resources.Email.Cust_SendMsg_Content, userName, message.Body,
                    EncryptHelper.EncryptString(SettingsHelper.Encryption_Key, mh.AdminId.ToString())
                    );
                EmailHelper.SendEmail(SettingsHelper.Email_Sender, recipientEmail, string.Format(Resources.Email.Cust_SendMsg_Subject,userName), body, null);

                //return View("Detail",new { Id= mh.MsgId });
                return "OK";
            }
            catch (Exception e)
            {
                return "NOTOK;" + e.StackTrace;
            }
        }
        public void GetCurrentUserIdEmail(out int Id, out string email,out bool isAdmin, out SenderType currentUserType,out string userName)
        {
            Id = -1;
            email = "";
            isAdmin = false;
            currentUserType = SenderType.Customer;
            userName = "";
            if (SessionPersister.account is Account)
            {   
                var account = (Account)SessionPersister.account;
                Id = account.Id;
                email = account.Email;
                isAdmin = account.IsAdmin;
                if (isAdmin)
                    currentUserType = SenderType.Admin;
                else
                    currentUserType = SenderType.Customer;
                userName = account.FullName;
            }
            if (SessionPersister.account is Vendor)
            {
                var account = (Vendor)SessionPersister.account;
                Id = account.Id;
                userName = account.Name;
                email = account.Email;
                isAdmin = false;
                currentUserType = SenderType.Vendor;
            } 
            
        }
    }

}
