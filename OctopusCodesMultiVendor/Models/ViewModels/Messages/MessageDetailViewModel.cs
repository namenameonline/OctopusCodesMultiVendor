using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Models.ViewModels.Messages
{
    public class MessageDetailViewModel
    {
        public int SendTo { get; set; }

        public int SenderType { get; set; }
        public string Body { get; set; }
       
    }
}