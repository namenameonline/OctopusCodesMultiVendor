using Newtonsoft.Json.Linq;
using OctopusCodesMultiVendor.Helpers;
using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace OctopusCodesMultiVendor.Controllers
{
    public class CartApiController : ApiController
    {
        private OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        [HttpPost]
        public string Update([FromBody]JObject data)
        {
            Product item= data["cartData"].ToObject<Product>();
            List<Item> cart=null;
            double weight = 0;
            try
            {
                var Session = HttpContext.Current.Session;
                cart = (List<Item>)Session["cart"];
                int index = Exists(item.Id, cart);
                cart[index].quantity = item.Quantity;
                Session["cart"] = cart;
                weight = ocmde.Products.Find(item.Id).WeightInGrams * item.Quantity;
            }
            catch (Exception e)
            {
                return "NOTOK;" + e.StackTrace;
            }
            decimal total = cart.Sum(i => i.product.Price * i.quantity);
            int totalItem = cart.Count;
            
            return "OK;" + @total.ToString("c") + ";" + totalItem +";" + weight;
            //return RedirectToAction("Index");
        }
        [HttpGet]
        public string Buy(int id)
        {
            try
            {
                var Session= HttpContext.Current.Session;
                var product = ocmde.Products.Find(id);
                if (!VendorHelper.checkExpires(product.VendorId))
                {
                    return "NOTOK;EXPIRED";
                }
                else
                {
                    List<Item> cart;
                    if (Session["cart"] == null)
                    {
                        cart = new List<Item>();
                        cart.Add(new Item()
                        {
                            product = product,
                            quantity = 1
                        });
                        Session["cart"] = cart;
                    }
                    else
                    {
                        cart = (List<Item>)Session["cart"];
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
                    decimal total = cart.Sum(i => i.product.Price * i.quantity);
                    int totalItem = cart.Count;
                    return "OK;" + @total.ToString("c") + ";"+totalItem;
                }
            }
            catch (Exception e)
            {
                return "NOTOK;"+e.StackTrace;
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
    }
}
