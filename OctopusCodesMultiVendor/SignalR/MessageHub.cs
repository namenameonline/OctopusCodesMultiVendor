using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace OctopusCodesMultiVendor.SignalR
{
    [HubName("MessageHub")]
    public class MessageHub : Hub
    {
        public void newMessage(string message)

        {

            Clients.All.addMessage(message);

        }
    }
}