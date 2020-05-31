using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels.Messages;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Controllers
{
    
    public class ContactUsController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();
        // GET: ContactUs
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult SendMessage()
        {
            try
            {
                var account = SessionPersister.account;
                

                    if (SessionPersister.account == null)
                    {

                        return RedirectToAction("Login", "Customer", new { redirectUrl = "/Vendors/SendMessage/" });
                    }
                    else
                    {
                        var admin = ocmde.Accounts.Find(SettingsHelper.ContactUsId);
                        ViewBag.admin = admin;
                        //var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                        MessageHeader messageHeader=null;
                        if (account is Account)
                        {
                            messageHeader = ocmde.MessageHeaders.Where(m => m.AdminId == admin.Id && m.CustomerId == ((Account)account).Id).FirstOrDefault();
                        }
                        else
                        {
                            messageHeader = ocmde.MessageHeaders.Where(m => m.AdminId == admin.Id && m.VendorId == ((Vendor)account).Id).FirstOrDefault();
                        }
                       
                        if (messageHeader != null)
                            {                                

                                ViewBag.messages = messageHeader.MessageDetails.OrderBy(a => a.DateCreation);
                            }
                        ViewBag.senderphoto = "no-logo.jpg";
                        ViewBag.myphoto = "no-logo.jpg";
                        return View("SendMessage", new MessageDetailViewModel() { SendTo = SettingsHelper.ContactUsId });
                    }
                
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "ContactUs", "SendMessage"));
            }
        }
        [HttpPost]
        public ActionResult SendMessage(MessageDetailViewModel message)
        {
            try
            {
                var account = SessionPersister.account;
                //var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                MessageHeader mh;
                bool isCustomer = false;
                if (account is Account)
                {
                    mh = ocmde.MessageHeaders.Where(m =>  m.CustomerId == ((Account)account).Id&&m.AdminId==SettingsHelper.ContactUsId).FirstOrDefault();
                    isCustomer = true;
                }
                else
                {
                    mh = ocmde.MessageHeaders.Where(m =>  m.VendorId == ((Vendor)account).Id && m.AdminId == SettingsHelper.ContactUsId).FirstOrDefault();
                }
                bool newconversation = false;
                string sender = "";
                int senderType=0;
                if (mh == null)
                {
                    mh = new MessageHeader();
                    newconversation = true;
                    mh.MsgId = Guid.NewGuid();
                    
                    mh.AdminId = SettingsHelper.ContactUsId;

                }
                if (isCustomer)
                {
                    mh.CustomerId = ((Account)account).Id;
                    sender = ((Account)account).FullName;
                    senderType = (int)SenderType.Customer;
                }
                else
                {
                    mh.VendorId = ((Vendor)account).Id;
                    sender = ((Vendor)account).Name;
                    senderType = (int)SenderType.Vendor;
                }
                mh.SenderType = senderType;
                mh.LastUpdated = DateTime.Now;
                mh.LastMessage = message.Body;
               
                MessageDetail messageDetail = new MessageDetail();
                messageDetail.Id = Guid.NewGuid();
                messageDetail.DateCreation = DateTime.Now;
                messageDetail.Body = message.Body;
                messageDetail.Status = true;
                messageDetail.Sender = senderType;
                mh.MessageDetails.Add(messageDetail);
                if (newconversation)
                    ocmde.MessageHeaders.Add(mh);
                ocmde.SaveChanges();
                string body = string.Format(Resources.Email.Cust_SendMsg_Content, sender, message.Body,
                    EncryptHelper.EncryptString(SettingsHelper.Encryption_Key, mh.AdminId.ToString())

                    );
                string adminEmail = ocmde.Accounts.Find(SettingsHelper.ContactUsId).Email;
                EmailHelper.SendEmail(SettingsHelper.Email_Sender, adminEmail, string.Format(Resources.Email.Cust_SendMsg_Subject,sender), body, null);
                TempData["message"] = Resources.Vendor.messages_sent_success;
                return RedirectToAction("SendMessage");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "ContactUs", "SendMessage"));
            }
        }
    }
}