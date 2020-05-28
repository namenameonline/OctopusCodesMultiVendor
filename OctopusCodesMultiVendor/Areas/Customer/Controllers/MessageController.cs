using MailKit;
using MailKit.Net.Imap;
using MailKit.Search;
using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models.ViewModels.Messages;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Areas.Customer.Controllers
{
    [CustomAuthorize(Roles = "Customer")]
    public class MessageController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                //RetrieveEmailListAsync(vendor.Id,vendor.Email);
                //                var messages = ocmde.Messages.Where(m => m.VendorId == vendor.Id).OrderByDescending(m => m.Id).ToList();
                var messages = ocmde.MessageHeaders.Where(m => m.CustomerId == customer.Id).OrderByDescending(m => m.MsgId).ToList();
                ViewBag.messages = messages;
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Message", "Index"));
            }
        }

        public ActionResult Detail(Guid Id)
        {
            try
            {
                var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                //RetrieveEmailListAsync(vendor.Id,vendor.Email);
                //                var messages = ocmde.Messages.Where(m => m.VendorId == vendor.Id).OrderByDescending(m => m.Id).ToList();
                var messageHeader = ocmde.MessageHeaders.Where(m => m.MsgId == Id).FirstOrDefault();
                if(messageHeader.CustomerId!= customer.Id)
                    return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Message", "Index"));

                ViewBag.messages = messageHeader.MessageDetails.OrderBy(a => a.DateCreation);
                ViewBag.senderphoto = "no-logo.jpg";
                ViewBag.myphoto = "no-logo.jpg";
                MessageDetailViewModel msg = new MessageDetailViewModel();
                if (messageHeader.VendorId.HasValue)
                {
                    msg.SendTo = (int)messageHeader.VendorId;
                    msg.SenderType = (int)SenderType.Vendor;
                }
                else
                {
                    msg.SendTo = (int)messageHeader.AdminId;
                    msg.SenderType = (int)SenderType.Admin;

                }
               
                return View(msg);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Message", "Index"));
            }
        }
        [HttpPost]
        public ActionResult SendMessage(MessageDetailViewModel message)
        {
            try
            {
                var account = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                
                MessageHeader mh = ocmde.MessageHeaders.FirstOrDefault(a => a.CustomerId == account.Id&&a.VendorId==message.SendTo);
                string recipientEmail = "";
                if (message.SenderType == (int)SenderType.Vendor)
                {
                    mh = ocmde.MessageHeaders.FirstOrDefault(a => a.CustomerId == account.Id && a.VendorId == message.SendTo);
                    recipientEmail = ocmde.Vendors.Find(mh.VendorId).Email;
                }
                else if (message.SenderType == (int)SenderType.Admin)
                {
                    mh = ocmde.MessageHeaders.FirstOrDefault(a => a.CustomerId == account.Id && a.AdminId == message.SendTo);
                    recipientEmail = ocmde.Accounts.Find(mh.AdminId).Email;
                }
                bool newconversation = false;
                if (mh == null)
                {
                    return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Message", "Index"));
                }
                mh.LastMessage = message.Body;
                mh.LastUpdated = DateTime.Now;
                MessageDetail messageDetail = new MessageDetail();
                messageDetail.Id = Guid.NewGuid();
                messageDetail.DateCreation = DateTime.Now;
                messageDetail.Body = message.Body;
                messageDetail.Status = true;
                messageDetail.Sender = (int)SenderType.Customer;
                mh.MessageDetails.Add(messageDetail);
                if (newconversation)
                    ocmde.MessageHeaders.Add(mh);
                ocmde.SaveChanges();
                string body = string.Format(SettingsHelper.Cust_SendMsg_Content, account.FullName, message.Body,
                    EncryptHelper.EncryptString(SettingsHelper.Encryption_Key, mh.VendorId.ToString())

                    );
                
                EmailHelper.SendEmail(SettingsHelper.Email_Sender, recipientEmail, SettingsHelper.Cust_SendMsg_Subject, body, null);
                TempData["message"] = Resources.Vendor.messages_sent_success;
                //return View("Detail",new { Id= mh.MsgId });
                return RedirectToAction("Detail", new { Id = mh.MsgId });
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Vendors", "SendMessage"));
            }
        }

    }
}