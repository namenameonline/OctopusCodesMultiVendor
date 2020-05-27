using Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR();
        }
    }
}