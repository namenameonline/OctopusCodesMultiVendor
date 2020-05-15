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
    public class CustomerController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                var customerIds = ocmde.Vendors.Find(vendor.Id).Orders.Select(o => o.CustomerId).Distinct().ToList();
                var customers = new List<Account>();
                customerIds.ForEach(id => {
                    customers.Add(ocmde.Accounts.Find(id));
                });
                ViewBag.customers = customers;
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Customer", "Index"));
            }
        }

        

    }
}