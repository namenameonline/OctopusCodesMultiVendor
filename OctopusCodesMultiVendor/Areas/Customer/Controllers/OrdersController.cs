using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Areas.Customer.Controllers
{
    [CustomAuthorize(Roles = "Customer")]
    public class OrdersController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;
                ViewBag.orders = ocmde.Orders.Where(o => o.CustomerId == customer.Id).OrderByDescending(o => o.Id).ToList();
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
                var customer = (OctopusCodesMultiVendor.Models.Account)SessionPersister.account;

                var order = ocmde.Orders.Find(id);
                var delivery = order.VendorPendingDeliveries.FirstOrDefault();
                ViewBag.order = order;
                ViewBag.deliveryfee = order.VendorPendingPayments.FirstOrDefault().DeliveryFee;
                ViewBag.trackingId = delivery.TrackingId;
                ViewBag.etd = delivery.EstimatedDeliveredDays;
                ViewBag.std = delivery.StartDeliveryDate;
                ViewBag.estdate = delivery.EstimatedDeliveredDate;
                ViewBag.deliveryfee = order.VendorPendingPayments.FirstOrDefault().DeliveryFee;
                ViewBag.orderStatus = ocmde.OrderStatus.Where(os => os.Status).ToList();
                if (ViewBag.order!=null)
                {
                    if(ViewBag.order.CustomerId!= customer.Id)
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

    }
}