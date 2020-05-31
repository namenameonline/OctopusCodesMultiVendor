using OctopusCodesMultiVendor.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Helpers
{
    public class SettingsHelper
    {
        public static string SMTP_HOST = "";
        public static string SMTP_USER = "";
        public static string SMTP_PASSWORD = "";
        public static string SMTP_PORT = "";
        public static string RajaOngkir_Api_Key = "";
        public static string RajaOngkir_Url = "";
       
        public static string Email_Sender = "";
        public static string SMTP_ENABLE_SSL = "";
        public static string BASE_URL = "";
        
  
        public static string Admin_Email = "";
        public static string Encryption_Key = "";
        
        public static string IMAP_HOST = "";
        public static string IMAP_PORT = "";
        

        public static int ContactUsId = 1;

        public static decimal BasePointCalculation = 10000;
        public static void Initialize(OctopusCodesMultiVendorsEntities ocmde)
        {
            SMTP_HOST = ocmde.Settings.Find(15).Value;
            SMTP_USER = ocmde.Settings.Find(16).Value;
            SMTP_PASSWORD = ocmde.Settings.Find(17).Value;
            SMTP_PORT = ocmde.Settings.Find(18).Value;
            RajaOngkir_Api_Key = ocmde.Settings.Find(19).Value;
            RajaOngkir_Url = ocmde.Settings.Find(20).Value;            
            Email_Sender = ocmde.Settings.Find(23).Value;
            SMTP_ENABLE_SSL = ocmde.Settings.Find(24).Value;
            BASE_URL = ocmde.Settings.Find(25).Value;
            
            Admin_Email = ocmde.Settings.Find(28).Value;
            Encryption_Key = ocmde.Settings.Find(29).Value;
            
            IMAP_HOST = ocmde.Settings.Find(32).Value;
            IMAP_PORT = ocmde.Settings.Find(33).Value;
            BasePointCalculation = decimal.Parse(ocmde.Settings.Find(1037).Value);


        }
    }
}