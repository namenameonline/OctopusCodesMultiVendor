using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Security
{
    public static class SessionPersister
    {
        public static object account
        {
            get
            {
                if (HttpContext.Current == null)
                    return null;
                var sessionVar = HttpContext.Current.Session["account"];
                if (sessionVar != null)
                    return sessionVar as object;
                return null;
            }
            set
            {
                HttpContext.Current.Session["account"] = value;
            }
        }
        public static decimal Points
        {
            get
            {
                if (HttpContext.Current == null)
                    return 0;
                var sessionVar = HttpContext.Current.Session["account"];
                if (sessionVar != null)
                {
                    if (sessionVar is Account)
                    {
                        var rewardsPoint= ((Account)sessionVar).RewardsPoints.FirstOrDefault();
                        if (rewardsPoint == null)
                            return 0;
                        return rewardsPoint.AccumulatedPoints;
                    }
                    if (sessionVar is Vendor)
                    {
                        var rewardsPoint = ((Vendor)sessionVar).RewardsPoints.FirstOrDefault();
                        if (rewardsPoint == null)
                            return 0;
                        return rewardsPoint.AccumulatedPoints;
                    }
                }
                return 0;
            }
            
        }
        public static string CurrentUserName
        {
            get
            {
                if (HttpContext.Current == null)
                    return null;
                var sessionVar = HttpContext.Current.Session["account"];
                if (sessionVar != null)
                {
                    if(sessionVar is Account)
                        return ((Account)sessionVar).Username;
                    if (sessionVar is Vendor)
                        return ((Vendor)sessionVar).Username;
                }
                return null;
            }
           
        }
    }
}