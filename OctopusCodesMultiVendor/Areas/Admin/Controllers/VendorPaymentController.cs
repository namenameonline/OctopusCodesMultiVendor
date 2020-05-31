using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OctopusCodesMultiVendor.Areas.Admin.Controllers
{
    public class VendorPaymentController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();
        // GET: Admin/VendorPayment
        public ActionResult Index()
        {
            ViewBag.payments = ocmde.VendorPayments.OrderByDescending(o => o.Id).ToList();
            
            return View();
        }
        public ActionResult UpdatePaid(Guid Id)
        {
            VendorPayment payment = ocmde.VendorPayments.FirstOrDefault(a => a.Id == Id);
            if (payment != null)
            {
                string body = string.Format(Resources.Email.UpdatePaymentPaid_Content,payment.AccountNo.Substring(payment.AccountNo.Length-4), payment.Amount);

                EmailHelper.SendEmail(SettingsHelper.Email_Sender, payment.Vendor.Email, Resources.Email.UpdatePaymentPaid_Subject, body, null);
                Order order = ocmde.Orders.FirstOrDefault(a => a.Id == payment.OrderId);
                UpdateVendorCustomerPoint(payment.VendorId,order.CustomerId, payment.Amount);
                order.OrderStatusId = OrderStatusHelper.PaymentDisbursed;
                return RedirectToAction("Index");
            }
            //Update rewards point for 
            TempData["error"] = "Update status failed";
            return View();
        }
        public void UpdateVendorCustomerPoint(int vendorId,int customerId,decimal amount)
        {
            decimal point = RewardsPointCalculator.CalculatePoint(amount);
            RewardsPoint vendorPoint = ocmde.RewardsPoints.FirstOrDefault(a => a.VendorId == vendorId && a.AccountId == null);
            RewardsPoint customerPoint = ocmde.RewardsPoints.FirstOrDefault(a => a.VendorId == null && a.AccountId == customerId);
            vendorPoint.AccumulatedPoints += point;
            vendorPoint.AccumulatedPoints += point;
            ocmde.SaveChanges();
        }
        
    }
}