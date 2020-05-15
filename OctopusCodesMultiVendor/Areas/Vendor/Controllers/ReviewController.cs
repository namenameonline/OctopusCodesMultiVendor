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
    public class ReviewController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.reviews = ocmde.Reviews.Where(r => r.VendorId == vendor.Id).OrderByDescending(r => r.Id).ToList();
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Review", "Index"));
            }
        }

        public ActionResult Customer(int id)
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.reviews = ocmde.Reviews.Where(r => r.VendorId == vendor.Id && r.CustomerId == id).OrderByDescending(r => r.Id).ToList();
                return View("Index");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Review", "Index"));
            }
        }

    }
}