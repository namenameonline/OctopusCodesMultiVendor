using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class VendorHelper
    {
        private static OctopusCodesMultiVendorsEntities ocmde = new OctopusCodesMultiVendorsEntities();

        public static bool IsValid(int vendorId)
        {
            try
            {
                return ocmde.Vendors.Count(m => m.Id == vendorId && m.Status && m.BankStatus) >0;
                
            }
            catch
            {
                return false;
            }
            return false;
        }
    }
}