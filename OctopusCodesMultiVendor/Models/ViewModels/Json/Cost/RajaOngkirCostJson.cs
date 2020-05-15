using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Models.ViewModels.Json.Cost
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class RajaOngkirCostJson
    {
        [JsonProperty("rajaongkir")]
        public Rajaongkir Rajaongkir { get; set; }
    }

    public partial class Rajaongkir
    {
        [JsonProperty("query")]
        public Query Query { get; set; }

        [JsonProperty("status")]
        public Status Status { get; set; }

        [JsonProperty("origin_details")]
        public NDetails OriginDetails { get; set; }

        [JsonProperty("destination_details")]
        public NDetails DestinationDetails { get; set; }

        [JsonProperty("results")]
        public Result[] Results { get; set; }
    }

    public partial class NDetails
    {
        [JsonProperty("city_id")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long CityId { get; set; }

        [JsonProperty("province_id")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long ProvinceId { get; set; }

        [JsonProperty("province")]
        public string Province { get; set; }

        [JsonProperty("type")]
        public string Type { get; set; }

        [JsonProperty("city_name")]
        public string CityName { get; set; }

        [JsonProperty("postal_code")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long PostalCode { get; set; }
    }

    public partial class Query
    {
        [JsonProperty("origin")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long Origin { get; set; }

        [JsonProperty("destination")]
        [JsonConverter(typeof(ParseStringConverter))]
        public long Destination { get; set; }

        [JsonProperty("weight")]
        public long Weight { get; set; }

        [JsonProperty("courier")]
        public string Courier { get; set; }
    }

    public partial class Result
    {
        [JsonProperty("code")]
        public string Code { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("costs")]
        public ResultCost[] Costs { get; set; }
    }

    public partial class ResultCost
    {
        [JsonProperty("service")]
        public string Service { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("cost")]
        public CostCost[] Cost { get; set; }
    }

    public partial class CostCost
    {
        [JsonProperty("value")]
        public long Value { get; set; }

        [JsonProperty("etd")]
        public string Etd { get; set; }

        [JsonProperty("note")]
        public string Note { get; set; }
    }

    public partial class Status
    {
        [JsonProperty("code")]
        public long Code { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }
    }
}