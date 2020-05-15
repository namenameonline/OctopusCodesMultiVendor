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
    public class OrdersController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.orders = ocmde.Orders.Where(o => o.VendorId == vendor.Id).OrderByDescending(o => o.Id).ToList();
                
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Orders", "Index"));
            }
        }

        public ActionResult Detail(int id)
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.order = ocmde.Orders.Find(id);
                ViewBag.orderId = id;
                ViewBag.payments = ocmde.Payments.Where(p => p.Status).ToList();
                ViewBag.orderStatus = ocmde.OrderStatus.Where(os => os.Status).ToList();
                if (ViewBag.order != null)
                {
                    if (ViewBag.order.VendorId != vendor.Id)
                    {
                        return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Orders", "Detail"));
                    }
                }
                return View("Detail");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Orders", "Detail"));
            }
        }

        public ActionResult Customer(int id)
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                ViewBag.orders = ocmde.Orders.Where(o => o.VendorId == vendor.Id && o.CustomerId == id).OrderByDescending(o => o.Id).ToList();
                return View("Index");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Orders", "Customer"));
            }
        }

        [HttpPost]
        public ActionResult Update(FormCollection fc)
        {
            int id = int.Parse(fc["id"]);
            int paymentId = int.Parse(fc["payment"]);
            int orderStatusId = int.Parse(fc["orderStatus"]);
            var order = ocmde.Orders.Find(id);
            order.PaymentId = paymentId;
            order.OrderStatusId = orderStatusId;
            ocmde.SaveChanges();
            return RedirectToAction("Index");
        }

    }
}