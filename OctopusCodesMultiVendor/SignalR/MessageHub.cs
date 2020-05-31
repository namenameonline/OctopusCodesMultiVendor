using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using OctopusCodesMultiVendor.Models;
using OctopusCodesMultiVendor.Security;

namespace OctopusCodesMultiVendor.SignalR
{
    [HubName("MessageHub")]
    public class MessageHub : Hub
    {
        public static ConcurrentDictionary<string, string> Connections = new ConcurrentDictionary<string, string>();

        public void SendMessage(string who, string date, string message,string msgSender)
        {
            string connectionID;
            Connections.TryGetValue(who, out connectionID);
            if (!string.IsNullOrEmpty(connectionID))
            //foreach (var connectionId in Connections.Values)
            {
                Clients.Client(connectionID).sendMessage(who, date, message, msgSender);
            }
        }
        
        public override Task OnConnected()
        {
            if (!Connections.ContainsKey(Context.QueryString["UserName"]))
            {
                Connections.TryAdd(Context.QueryString["UserName"], Context.ConnectionId);
            }
            else
            {
                string temp;
                Connections.TryRemove(Context.QueryString["UserName"], out temp);
                Connections.TryAdd(Context.QueryString["UserName"], Context.ConnectionId);
            }
            Clients.All.broadcastConnect(Context.ConnectionId, Context.QueryString["UserName"]);
            return base.OnConnected();
        }
        public override Task OnReconnected()
        {
            if (!Connections.ContainsKey(Context.QueryString["UserName"]))
            {
                Connections.TryAdd(Context.QueryString["UserName"], Context.ConnectionId);
            }
            else
            {
                string temp;
                Connections.TryRemove(Context.QueryString["UserName"], out temp);
                Connections.TryAdd(Context.QueryString["UserName"], Context.ConnectionId);
            }
            Clients.All.broadcastConnect(Context.ConnectionId, Context.QueryString["UserName"]);
            return base.OnReconnected();
        }
        
        public override Task OnDisconnected(bool stopCalled)
        {
            string temp;
            Connections.TryRemove(Context.QueryString["UserName"], out temp);
            Clients.All.broadcastDisconnect(Context.ConnectionId, Context.QueryString["UserName"]);
            return base.OnDisconnected(stopCalled);
        }

    }
}