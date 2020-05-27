using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Models.ViewModels.Json
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class DeliveryOptionJson
    {
        public decimal totalFee;
        [JsonProperty("DeliveryOption")]
        public List<DeliveryOption> DeliveryOption { get; set; }
        public DeliveryOptionJson()
        {
            DeliveryOption = new List<DeliveryOption>();
        }
    }

    public partial class DeliveryOption
    {
        public DeliveryOption()
        {
            Detail = new List<Detail>();
        }
        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("totalfee")]
        public long Totalfee { get; set; }

        [JsonProperty("detail")]
        public List<Detail> Detail { get; set; }
    }

    public partial class Detail
    {
        [JsonProperty("vendorid")]        
        public string Vendorid { get; set; }
        [JsonProperty("totalfee")]
        public long totalfee { get; set; }

        [JsonProperty("etd")]
        public string Etd { get; set; }
    }
}