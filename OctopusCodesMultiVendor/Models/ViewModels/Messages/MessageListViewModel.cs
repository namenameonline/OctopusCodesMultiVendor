using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Models.ViewModels.Messages
{
    public class MessageListViewModel
    {
        public string SenderID { get; set; }
        public string LastMessage { get; set; }
        public DateTime LastMessageDateTime { get; set; }
        public string SenderPhoto { get; set; }
    }
}