using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OctopusCodesMultiVendor.Helpers.Interface
{
    public interface MessageEvents
    {
        void OnNewMessageReceived(DateTime dateTime, string content, int sender);

    }
}
