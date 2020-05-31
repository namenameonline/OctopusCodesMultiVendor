using MailKit;
using MailKit.Net.Imap;
using MailKit.Search;
using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Helpers.Interface;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models.ViewModels.Messages;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace OctopusCodesMultiVendor.Areas.Customer.Controllers
{
    [CustomAuthorize(Roles = "Customer")]
    public class MessageController : Controller, MessageEvents
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
                    msg.recipient = ocmde.Vendors.Find(msg.SendTo).Username;
                }
                else
                {
                    msg.SendTo = (int)messageHeader.AdminId;
                    msg.SenderType = (int)SenderType.Admin;
                    msg.recipient = ocmde.Accounts.Find(msg.SendTo).Username;
                }
                
                return View(msg);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Message", "Index"));
            }
        }
       

        public void OnNewMessageReceived(DateTime dateTime, string content, int sender)
        {
            //Clients.All.broadcastMessage(name, message);
        }
    }
}