using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace OctopusCodesMultiVendor.Models
{
    //define attribute 
    public class VendorMetaData
    {
        
        [Required]
        public string Username { get; set; }

        [Required]
        public string Name { get; set; }

        

        [Required]
        [EmailAddress]
        public string Email { get; set; }
        
    }


    //Define additional field not used in db
    [MetadataType(typeof(VendorMetaData))]
    public partial class Vendor
    {
        public VendorAddress defaultAddress { get; set; }
        public VendorPaymentInfo vendorPaymentInfo { get; set; }
    }

}