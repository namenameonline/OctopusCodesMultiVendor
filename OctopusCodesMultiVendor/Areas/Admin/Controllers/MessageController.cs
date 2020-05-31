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

namespace OctopusCodesMultiVendor.Areas.Admin.Controllers
{
    [CustomAuthorize(Roles = "Admin")]
    public class MessageController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var account = (Account)SessionPersister.account;
                //RetrieveEmailListAsync(vendor.Id,vendor.Email);
                //                var messages = ocmde.Messages.Where(m => m.VendorId == vendor.Id).OrderByDescending(m => m.Id).ToList();
                var messages = ocmde.MessageHeaders.Where(m => m.AdminId == account.Id).OrderByDescending(m => m.MsgId).ToList();
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
                var account = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                
                //RetrieveEmailListAsync(vendor.Id,vendor.Email);
                //                var messages = ocmde.Messages.Where(m => m.VendorId == vendor.Id).OrderByDescending(m => m.Id).ToList();
                var messageHeader = ocmde.MessageHeaders.Where(m => m.MsgId == Id).FirstOrDefault();
                if(messageHeader.AdminId!= account.Id)
                    return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Message", "Index"));

                ViewBag.messages = messageHeader.MessageDetails.OrderBy(a => a.DateCreation);
                ViewBag.senderphoto = "no-logo.jpg";
                ViewBag.myphoto = "no-logo.jpg";
                MessageDetailViewModel msg = new MessageDetailViewModel();
                
                if(messageHeader.CustomerId.HasValue)
                {
                    msg.SendTo = (int)messageHeader.CustomerId;
                    msg.recipient = ocmde.Accounts.Find(msg.SendTo).Username;
                }
                else
                {
                    msg.SendTo = (int)messageHeader.VendorId;
                    msg.recipient = ocmde.Vendors.Find(msg.SendTo).Username;
                }
                msg.SenderType = (int)messageHeader.SenderType;
                ViewBag.currentUser = account.Email;
                return View(msg);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Message", "Index"));
            }
        }
       

    }
}