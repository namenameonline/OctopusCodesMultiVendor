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
    public class MemberShipController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.memberShipVendors = vendor.MemberShipVendors.OrderByDescending(m => m.Id);
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "MemberShip", "Index"));
            }
        }

    }
}