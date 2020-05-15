using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OctopusCodesMultiVendor.Security;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models;

namespace OctopusCodesMultiVendor.Areas.Admin.Controllers
{
    [CustomAuthorize(Roles = "Admin")]
    public class AccountController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Customer()
        {
            try
            {
                ViewBag.customers = ocmde.Accounts.Where(a => a.IsAdmin == false).OrderByDescending(o => o.Id).ToList();
                return View("Customer");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Account", "Customer"));
            }
        }

        public ActionResult Vendor()
        {
            try
            {
                ViewBag.vendors = ocmde.Vendors.OrderByDescending(o => o.Id).ToList();
                return View("Vendor");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Account", "Vendor"));
            }
        }

        public ActionResult MemberShip(int id)
        {
            try
            {
                ViewBag.memberShipVendors = ocmde.MemberShipVendors.Where(o => o.VendorId == id).OrderByDescending(m => m.Id);
                return View("MemberShip");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Account", "MemberShip"));
            }
        }

        public ActionResult Status(int id)
        {
            try
            {
                var customer = ocmde.Accounts.SingleOrDefault(a => a.Id == id);
                customer.Status = !customer.Status;
                ocmde.SaveChanges();
                return RedirectToAction("Customer", "Account");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Account", "Status"));
            }
        }

        public ActionResult StatusVendor(int id)
        {
            try
            {
                var vendor = ocmde.Vendors.SingleOrDefault(a => a.Id == id);
                vendor.Status = !vendor.Status;
                ocmde.SaveChanges();
                return RedirectToAction("Vendor", "Account");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Account", "StatusVendor"));
            }
        }

    }
}