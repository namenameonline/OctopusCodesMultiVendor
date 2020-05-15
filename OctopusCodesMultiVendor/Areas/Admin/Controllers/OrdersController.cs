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
    public class OrdersController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                ViewBag.orders = ocmde.Orders.OrderByDescending(o => o.Id).ToList();
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Orders", "Index"));
            }
        }


    }
}