using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OctopusCodesMultiVendor.Helpers;

namespace OctopusCodesMultiVendor.Controllers
{
    public class HomeController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                //var key = "12345678901234567890123456789012";
                string encrypted = EncryptHelper.EncryptString(ocmde.Settings.Find(29).Value,"123");
                string decrypted = EncryptHelper.DecryptString(ocmde.Settings.Find(29).Value, encrypted);

                var products = new List<Product>();
                ocmde.Vendors.ToList().ForEach(v => {
                    if (VendorHelper.checkExpires(v.Id))
                    {
                        products.AddRange(v.Products);
                    }
                });
                var latestProducts = int.Parse(ocmde.Settings.Find(6).Value);
                ViewBag.latestProducts = products.Where(p => p.Status).OrderByDescending(p => p.Id).Take(latestProducts).ToList();

                var mostedViewed = int.Parse(ocmde.Settings.Find(7).Value);
                ViewBag.mostedViewedProducts = products.Where(p => p.Status).OrderByDescending(p => p.Views).Take(mostedViewed).ToList();

                var ordersDetails = new List<OrdersDetail>();
                ocmde.OrdersDetails.ToList().ForEach(od => {
                    if (VendorHelper.checkExpires(od.Product.VendorId))
                    {
                        ordersDetails.Add(od);
                    }
                });
                var bestSellers = int.Parse(ocmde.Settings.Find(8).Value);
                var group = ordersDetails.GroupBy(od => od.ProductId).Select(g => new { g.Key, Sum = g.Sum(od => od.Quantity) }).OrderByDescending(g => g.Sum).ToList();
                var bestSellersProducts = new List<Product>();
                group.ForEach(g =>
                {
                    bestSellersProducts.Add(ocmde.Products.Find(g.Key));
                });
                ViewBag.bestSellersProducts = bestSellersProducts.Where(p => p.Status).Take(bestSellers).ToList();
                return View();
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Home", "Index"));
            }
        }
    }
}