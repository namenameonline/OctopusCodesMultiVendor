using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Areas.Vendor.Controllers
{
    [CustomAuthorize(Roles = "Vendor")]
    public class MessageController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.messages = ocmde.Messages.Where(m => m.VendorId == vendor.Id).OrderByDescending(m => m.Id).ToList();
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Message", "Index"));
            }
        }

        

    }
}