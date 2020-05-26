using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Models.ViewModels.Cart
{
    public class CartViewModel
    {
        public CartViewModel()
        {
            VendorFees = new List<CartDeliveryFee>();
            cartItem = new List<Item>();
        }
        public string OrderID { get; set; }
        public string SelectedDeliveryOption { get; set; }
        public string LineAddress1 { get; set; }
        public string LineAddress2 { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }
        public string CardToken { get; set; }
        public decimal TotalAmount { get; set; }
        public List<CartDeliveryFee> VendorFees { get; set; }
        List<Item> cartItem { get; set; }
        //Payment info
        public string cardnumber { get; set; }
        public string expirationdate { get; set; }
        public string name { get; set; }
        public string transactionId { get; set; }
    }
    public class CartDeliveryFee
    {
        public string VendorId { get; set; }
        public decimal DeliveryFee { get; set; }
    }
}