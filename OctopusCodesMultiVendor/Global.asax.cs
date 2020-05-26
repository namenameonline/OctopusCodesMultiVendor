using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Configuration;
using Stripe;
using System.Web.Http;
using System.Web.Routing;
using System.Web.SessionState;
using OctopusCodesMultiVendor.Helpers;

namespace OctopusCodesMultiVendor
{
    public class MvcApplication : System.Web.HttpApplication
    {
        public override void Init()
        {
            this.PostAuthenticateRequest += MvcApplication_PostAuthenticateRequest;
            base.Init();
        }
        void MvcApplication_PostAuthenticateRequest(object sender, EventArgs e)
        {
            System.Web.HttpContext.Current.SetSessionStateBehavior(
                SessionStateBehavior.Required);
        }
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            var secretKey = WebConfigurationManager.AppSettings["StripeSecretKey"];
            StripeConfiguration.ApiKey = secretKey;
            SettingsHelper.Initialize(new Models.OctopusCodesMultiVendorsEntities());
            

        }
        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            var context = HttpContext.Current;
            var response = context.Response;

            // enable CORS  
            response.AddHeader("Access-Control-Allow-Origin", "*");

            if (context.Request.HttpMethod == "OPTIONS")
            {
                response.AddHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
                response.AddHeader("Access-Control-Allow-Headers", "Content-Type, Accept");
                response.End();
            }
        }
        protected void Application_AcquireRequestState(object sender, EventArgs e)
        {
            var language = "id-ID";
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(language);
            Thread.CurrentThread.CurrentCulture = new CultureInfo(language);
        }
    }
}
