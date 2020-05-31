using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class RewardsPointCalculator
    {
        public static decimal CalculatePoint(decimal amount)
        {
            return amount / SettingsHelper.BasePointCalculation;
        }
    }
}