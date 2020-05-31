using OctopusCodesMultiVendor.Helpers;
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
        public bool CanAccess(int dbVendorID,int sessionVendorID)
        {
            return (dbVendorID == sessionVendorID);
        }
        public ActionResult ViewPaymentDetail(int orderID)
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                var order = ocmde.VendorPayments.FirstOrDefault(a => a.OrderId == orderID);
                if(!CanAccess(order.VendorId,vendor.Id))
                    return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Orders", "ViewPaymentDetail"));

                if (ViewBag.order != null)
                {
                    if (ViewBag.order.VendorId != vendor.Id)
                    {
                        return View("Error", new HandleErrorInfo(new Exception("Invalid access"), "Orders", "ViewPaymentDetail"));
                    }
                }
                return View("ViewPaymentDetail");
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Orders", "ViewPaymentDetail"));
            }
        }
        public ActionResult Detail(int id)
        {
            try
            {
                var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
                var order= ocmde.Orders.Find(id);
                var delivery = order.VendorPendingDeliveries.FirstOrDefault();
                ViewBag.order = order;
                ViewBag.orderId = id;
                ViewBag.trackingId = delivery.TrackingId;
                ViewBag.payments = ocmde.Payments.Where(p => p.Status).ToList();
                ViewBag.etd = delivery.EstimatedDeliveredDays;
                ViewBag.std = delivery.StartDeliveryDate;
                ViewBag.estdate = delivery.EstimatedDeliveredDate;
                ViewBag.deliveryfee = order.VendorPendingPayments.FirstOrDefault().DeliveryFee;
                ViewBag.orderStatus = ocmde.OrderStatus.Where(os => os.Status).ToList();
                if (ViewBag.order != null)
                {
                    if (!CanAccess(ViewBag.order.VendorId,vendor.Id))
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
            var vendor = (OctopusCodesMultiVendor.Models.Vendor)SessionPersister.account;
            var order = ocmde.Orders.Find(id);
            if (order.VendorId != vendor.Id)
                return View("Error");
            
            //int paymentId = int.Parse(fc["payment"]);
            int orderStatusId = int.Parse(fc["orderStatus"]);
            string trackingId = fc["trackingId"];
            
            var vendorPendingDelivery = order.VendorPendingDeliveries.FirstOrDefault();
            vendorPendingDelivery.StartDeliveryDate = DateTime.Now;
            vendorPendingDelivery.EstimatedDeliveredDate = DateTime.Now.AddDays(DeliveryHelper.GetLatestDays(vendorPendingDelivery.EstimatedDeliveredDays));
            vendorPendingDelivery.TrackingId = trackingId;
            //order.PaymentId = ocmde;
            order.OrderStatusId = orderStatusId;
            ocmde.SaveChanges();
            return RedirectToAction("Detail", new { id = order.Id });
        }

    }
}