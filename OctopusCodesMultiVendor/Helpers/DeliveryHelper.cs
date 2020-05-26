using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class DeliveryHelper
    {
        public static int GetLatestDays(string etd)
        {
            string result = etd;
            if (result.IndexOf("-") != -1)
            {
                string[] results = result.Split('-');
                result = results[results.Length - 1];

            }
            return int.Parse(result);
        }
    }
}