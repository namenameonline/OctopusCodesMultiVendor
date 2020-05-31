using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Models.ViewModels;
using OctopusCodesMultiVendor.Models.ViewModels.Json;
using OctopusCodesMultiVendor.Models.ViewModels.Json.Cost;
using OctopusCodesMultiVendor.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using RestSharp;
using Newtonsoft.Json;
using OctopusCodesMultiVendor.Paypal;
using System.Web.Configuration;
using System.Text;
using System.IO;
using System.Net;
using OctopusCodesMultiVendor.Models.ViewModels.Cart;

namespace OctopusCodesMultiVendor.Controllers
{
    public class CartController : Controller
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public ActionResult Index()
        {
            try
            {
                Account account = (Account)SessionPersister.account;
                
                CartViewModel model = new CartViewModel();
                if (account != null)
                {
                    AccountAddress address = account.AccountAddresses.FirstOrDefault();
                    if (address != null)
                    {

                        model.LineAddress1 = address.LineAddress1;
                        model.LineAddress2 = address.LineAddress2;
                        model.ZipCode = address.ZipCode;
                        model.City = address.City;

                    }
                }
                return View("Index",model);
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Home", "Index"));
            }
        }

        public ActionResult Remove(int id)
        {
            List<Item> cart = (List<Item>)Session["cart"];
            int index = Exists(id, cart);
            cart.RemoveAt(index);
            Session["cart"] = cart;
            return RedirectToAction("Index");
        }

        [HttpPost]       
        public async Task<string> CalculateDeliveryFee(FormCollection fc)
        {
            List<Item> cart = (List<Item>)Session["cart"];
            
            string cityName = fc["cityName"];
            decimal fee = 0;
            string etd = "";
            List<string> itemEtd = new List<string>();
            //cart=cart.OrderBy(a => a.product.Vendor.Id).ToList<Item>();
            IEnumerable<int> vendorList = cart.Select(a => a.product.VendorId).Distinct<int>();
            DeliveryOptionJson deliveryOptionJson = new DeliveryOptionJson();
            foreach (int vendorID in vendorList)
            {
                Vendor vendor = ocmde.Vendors.Find(vendorID);
                VendorAddress address = vendor.VendorAddresses.FirstOrDefault();
                string origin = ocmde.RajaOngkir_CityMapping.Where(a => a.city_name.Equals(address.City)).FirstOrDefault().city_id;
                string destination= ocmde.RajaOngkir_CityMapping.Where(a => a.city_name.Equals(cityName)).FirstOrDefault().city_id;
                IEnumerable<Item> items = cart.Where(a => a.product.VendorId.Equals(vendorID));
                double weight = 0;
                string itemID;
                foreach(Item item in items)
                {
                    weight+= Convert.ToDouble(item.quantity) * item.product.WeightInGrams;
                    
                }
                List<ResultCost> costs = await GetFeeAsync(origin, destination, weight.ToString());
                foreach (ResultCost cost in costs)
                {
                    string deliveryDesc = cost.Description;
                    if (!deliveryOptionJson.DeliveryOption.Exists(a => a.Name.Equals(deliveryDesc)))
                    {
                        DeliveryOption option = new DeliveryOption();
                        option.Name = deliveryDesc;
                        Detail detail = new Detail();
                        detail.Etd = cost.Cost[0].Etd;
                        detail.totalfee += cost.Cost[0].Value;
                        detail.Vendorid = vendorID.ToString();
                        option.Detail.Add(detail);
                        deliveryOptionJson.DeliveryOption.Add(option);
                        option.Totalfee += cost.Cost[0].Value;
                    }
                    else
                    {
                        DeliveryOption option = deliveryOptionJson.DeliveryOption.FirstOrDefault(a => a.Name.Equals(deliveryDesc));
                        option.Totalfee += cost.Cost[0].Value;
                        Detail detail = option.Detail.FirstOrDefault(a => a.Vendorid.Equals(vendorID));
                        if (detail == null)
                        {
                            detail = new Detail();
                            detail.Etd = cost.Cost[0].Etd;
                            detail.totalfee = cost.Cost[0].Value;
                            detail.Vendorid = vendorID.ToString();
                            option.Detail.Add(detail);
                        }
                        else
                        {
                            detail.Etd = cost.Cost[0].Etd;
                            detail.totalfee+= cost.Cost[0].Value;
                        }

                    }
                }
            }

            deliveryOptionJson.totalFee = fee;
            Session["DeliveryOptionJson"] = deliveryOptionJson;
            return JsonConvert.SerializeObject(deliveryOptionJson);
        }

        private async Task<List<ResultCost>> GetFeeAsync(string origin,string destination,string weight)
        {
           
            var client = new RestClient(ocmde.Settings.Find(20).Value+"/starter/cost");
            var request = new RestRequest(Method.POST);
            request.AddHeader("key", ocmde.Settings.Find(19).Value);
            request.AddHeader("content-type", "application/x-www-form-urlencoded");
            RajaOngkirCostJson product = null;
            request.AddParameter("application/x-www-form-urlencoded", "origin="+origin+"&destination="+destination+"&weight="+weight+"&courier=jne", ParameterType.RequestBody);
            IRestResponse response = client.Execute(request);

            product = JsonConvert.DeserializeObject<RajaOngkirCostJson>(response.Content);


            return product.Rajaongkir.Results[0].Costs.ToList<ResultCost>();
            
        }
        
        [HttpPost]
        public ActionResult Update(FormCollection fc)
        {
            int productId = Convert.ToInt32(fc["productId"]);
            try
            {
                List<Item> cart = (List<Item>)Session["cart"];
                int index = Exists(productId, cart);
                cart[index].quantity = Convert.ToInt32(fc["quantity"]);
                Session["cart"] = cart;
            }catch(Exception e)
            {
                return View("Error");
            }
            return View("Index");
            //return RedirectToAction("Index");
        }

        public ActionResult Buy(int id)
        {
            try
            {
                var product = ocmde.Products.Find(id);
                if (!VendorHelper.IsValid(product.VendorId))
                {
                    return RedirectToAction("Expires", "Product");
                }
                else
                {
                    if (Session["cart"] == null)
                    {
                        List<Item> cart = new List<Item>();
                        cart.Add(new Item()
                        {
                            product = product,
                            quantity = 1
                        });
                        Session["cart"] = cart;
                    }
                    else
                    {
                        List<Item> cart = (List<Item>)Session["cart"];
                        int index = Exists(id, cart);
                        if (index == -1)
                        {
                            cart.Add(new Item()
                            {
                                product = product,
                                quantity = 1
                            });
                        }
                        else
                        {
                            cart[index].quantity++;
                        }
                        Session["cart"] = cart;
                    }
                    return RedirectToAction("Index");
                }
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Home", "Index"));
            }
        }

        private int Exists(int productId, List<Item> cart)
        {
            for (int i = 0; i < cart.Count; i++)
            {
                if (cart[i].product.Id == productId)
                {
                    return i;
                }
            }
            return -1;
        }
        [HttpPost]
        public ActionResult MakePayment(CartViewModel model)
        {
            Account account = (Account)SessionPersister.account;
            List<Item> cart = (List<Item>)Session["cart"];
            DeliveryOptionJson deliveryOptionJson= (DeliveryOptionJson)Session["DeliveryOptionJson"];
            DeliveryOption deliverySelected = deliveryOptionJson.DeliveryOption.FirstOrDefault(a => a.Name.Equals(model.SelectedDeliveryOption));
            ViewBag.OrderName = Guid.NewGuid().ToString();
            ViewBag.TotalAmount= cart.Sum(i => i.product.Price * i.quantity) + deliverySelected.Totalfee;
            model.OrderID = ViewBag.OrderName;
            model.TotalAmount = decimal.Truncate(ViewBag.TotalAmount);
            AccountPaymentInfo accountPaymentInfo = account.AccountPaymentInfoes.FirstOrDefault();
            if(accountPaymentInfo!=null)
            {
                model.name = accountPaymentInfo.FullName;
                model.cardnumber = accountPaymentInfo.CreditCardNo;
                model.expirationdate = accountPaymentInfo.ExpiryDate;
            }
            //Session["CartViewModel"] = model;

            return View(model);
        }
        private bool ChargeToMidTransAsync(string OrderID,decimal amount,string tokenID)
        {
            string myJson = "{\"payment_type\": \"credit_card\"," +
                            "\"transaction_details\":" +
                            "{\"order_id\": \"" + OrderID + "\"," +
                            "\"gross_amount\": " + amount + 
                            "},"+
                            "\"credit_card\":" +
                            "{\"token_id\": \"" + tokenID+ "\"," +
                            "\"authentication\": true" +
                            "}}";
            
            byte[] bytes = System.Text.Encoding.ASCII.GetBytes("SB-Mid-server-2CNZoUsMukjgYzB2aRIxqfAX");
            //Console.WriteLine(bytes);   // System.Byte[]
            string btoas = Convert.ToBase64String(bytes, Base64FormattingOptions.InsertLineBreaks);
            var httpWebRequest = (HttpWebRequest)WebRequest.Create("https://cors-anywhere.herokuapp.com/https://api.sandbox.midtrans.com/v2/charge");
            httpWebRequest.ContentType = "application/json";
            httpWebRequest.Method = "POST";
            httpWebRequest.Headers.Add("Authorization", "Basic " + btoas);
            httpWebRequest.Headers.Add("Accept", "application/json");
            httpWebRequest.Headers.Add("Content-Type", "application/json");
            using (var streamWriter = new StreamWriter(httpWebRequest.GetRequestStream()))
            {

                streamWriter.Write(myJson);
            }

            var httpResponse = (HttpWebResponse)httpWebRequest.GetResponse();
            if (httpResponse.StatusCode != HttpStatusCode.OK)
                return false;
            using (var streamReader = new StreamReader(httpResponse.GetResponseStream()))
            {
                var result = streamReader.ReadToEnd();
                return true;
            }
            return false;
        }
            
            
     

        [HttpPost]        
        public async Task<ActionResult> Charge(CartViewModel model)
        {
            try
            {
                    //CartViewModel model = (CartViewModel)Session["CartViewModel"];
                    DeliveryOptionJson vendorDeliveryOption = (DeliveryOptionJson)Session["DeliveryOptionJson"];
                    DeliveryOption deliveryOption = vendorDeliveryOption.DeliveryOption.FirstOrDefault(a => a.Name.Equals(model.SelectedDeliveryOption));
                    if (SessionPersister.account == null)
                    {
                        return RedirectToAction("Index", "Login", new { Area = "Customer" });
                    }
                    else
                    {
                        var account = SessionPersister.account;
                        if (account is Account && !((OctopusCodesMultiVendor.Models.Account)account).IsAdmin)
                        {
                            var customer = (OctopusCodesMultiVendor.Models.Account)account;
                            List<Item> cart = (List<Item>)Session["cart"];
                            var vendorIds = cart.Select(i => i.product.VendorId).Distinct().ToList();
                            vendorIds.ForEach(id =>
                            {

                                var currentVendor = ocmde.Vendors.Find(id);

                                // Create new order
                                Order order = new Order()
                                {
                                    CustomerId = customer.Id,
                                    DateCreation = DateTime.Now,
                                    Name = Resources.Vendor.New_Order_for_Vendor + " " + currentVendor.Name,
                                    OrderStatusId = 1,
                                    VendorId = id,                                    
                                    PaymentReference=model.OrderID
                                    
                                };
                                if (order.OrderAddresses.Count <= 0)
                                {
                                    OrderAddress oAddr = new OrderAddress();
                                    oAddr.Id = Guid.NewGuid();
                                    oAddr.LineAddress1 = model.LineAddress1;
                                    oAddr.LineAddress2 = model.LineAddress2;
                                    oAddr.City = model.City;
                                    oAddr.ZipCode = model.ZipCode;
                                    order.OrderAddresses.Add(oAddr);
                                }
                                
                                ocmde.Orders.Add(order);
                                //ocmde.SaveChanges();
                                decimal merchandiseAmtSum = 0;
                                // Create order details
                                cart.Where(i => i.product.VendorId == id).ToList().ForEach(i =>
                                {
                                    OrdersDetail ordersDetail = new OrdersDetail()
                                    {
                                        OrderId = order.Id,
                                        Price = i.product.Price,
                                        Quantity = i.quantity,
                                        ProductId = i.product.Id
                                    };
                                    decimal merchandiseAmt = i.product.Price * i.quantity;
                                    merchandiseAmtSum += merchandiseAmt;
                                    ocmde.OrdersDetails.Add(ordersDetail);
                                    //ocmde.SaveChanges();
                                    
                                });
                                //VendorPayment
                                VendorPendingPayment vendorPayment = new VendorPendingPayment();
                                vendorPayment.Order = order;
                                vendorPayment.OrderId = order.Id;
                                vendorPayment.PaymentOrderID = Guid.NewGuid();
                                vendorPayment.Vendor = currentVendor;
                                vendorPayment.VendorId = currentVendor.Id;
                                vendorPayment.MerchandiseAmount = merchandiseAmtSum;
                                vendorPayment.DeliveryFee = deliveryOption.Detail.FirstOrDefault(a => a.Vendorid == currentVendor.Id.ToString()).totalfee;
                                ocmde.VendorPendingPayments.Add(vendorPayment);

                                //VendorDelivery
                                VendorPendingDelivery vendorPendingDelivery = new VendorPendingDelivery();
                                vendorPendingDelivery.Order = order;
                                vendorPendingDelivery.DeliveryOrderId = Guid.NewGuid();
                                vendorPendingDelivery.Vendor = currentVendor;
                                vendorPendingDelivery.VendorId = currentVendor.Id;
                                vendorPendingDelivery.EstimatedDeliveredDays = deliveryOption.Detail.FirstOrDefault(a=>a.Vendorid==currentVendor.Id.ToString()).Etd;
                                //vendorPendingDelivery.EstimatedDeliveredDate = DateTime.Now.AddDays(DeliveryHelper.GetLatestDays(vendorPendingDelivery.EstimatedDeliveredDays));
                                ocmde.VendorPendingDeliveries.Add(vendorPendingDelivery);
                                string body = string.Format(Resources.Email.NewOrder_Content, customer.FullName, SettingsHelper.BASE_URL + "/Vendor/Login");

                                //Send Email to vendor for each order
                                EmailHelper.SendEmail(SettingsHelper.Email_Sender, currentVendor.Email, Resources.Email.NewOrder_Subject, body, null);
                                ocmde.SaveChanges();
                            });
                            //Make Payment to Vendor
                            //Save Payment info
                            Account dbAccount = (Account)account;
                            if (dbAccount.AccountPaymentInfoes.Count <= 0)
                            {
                                AccountPaymentInfo paymentInfo = new AccountPaymentInfo();
                                paymentInfo.CreditCardNo = model.cardnumber;
                                paymentInfo.ExpiryDate = model.expirationdate;
                                paymentInfo.FullName = model.name;
                                //paymentInfo.Id = Guid.NewGuid();
                                dbAccount.AccountPaymentInfoes.Add(paymentInfo);
                            }
                            else
                            {
                                AccountPaymentInfo acctPaymentOriginal = dbAccount.AccountPaymentInfoes.FirstOrDefault();
                                acctPaymentOriginal.CreditCardNo = model.cardnumber;
                                acctPaymentOriginal.ExpiryDate = model.expirationdate;
                                acctPaymentOriginal.FullName = model.name;
                            }
                           
                            ocmde.SaveChanges();
                            // Remove Cart
                            Session.Remove("Cart");
                            Session.Remove("DeliveryOptionJson");
                            return RedirectToAction("Index", "Orders", new { Area = "Customer" });
                        }
                        
                    }
                //}
            }
            catch (Exception e)
            {
                return View("Error", new HandleErrorInfo(e, "Home", "Index"));
            }
            return RedirectToAction("Index", "Login", new { Area = "Customer" });
        }
       
    }
}