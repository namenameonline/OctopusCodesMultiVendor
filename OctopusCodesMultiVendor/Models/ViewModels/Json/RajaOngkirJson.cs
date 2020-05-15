using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace OctopusCodesMultiVendor.Models.ViewModels.Json
{
    public partial class RajaOngkirCityListJson
    {
        [JsonProperty("rajaongkir")]
        public Rajaongkir Rajaongkir { get; set; }
    }

    public partial class Rajaongkir
    {
        [JsonProperty("query")]
        public object[] Query { get; set; }

        [JsonProperty("status")]
        public Status Status { get; set; }

        [JsonProperty("results")]
        public Result[] Results { get; set; }
    }

    public partial class Result
    {
        [JsonProperty("city_id")]
        public string CityId { get; set; }

        [JsonProperty("province_id")]
        public string ProvinceId { get; set; }

        [JsonProperty("province")]
        public string Province { get; set; }

        [JsonProperty("type")]
        public RajaOngkirCityTypeEnum Type { get; set; }

        [JsonProperty("city_name")]
        public string CityName { get; set; }

        [JsonProperty("postal_code")]
        public string PostalCode { get; set; }
    }

    public partial class Status
    {
        [JsonProperty("code")]
        public long Code { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }
    }

    public enum RajaOngkirCityTypeEnum { Kabupaten, Kota };

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters =
            {
                TypeEnumConverter.Singleton,
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }

    internal class ParseStringConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(long) || t == typeof(long?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            long l;
            if (Int64.TryParse(value, out l))
            {
                return l;
            }
            throw new Exception("Cannot unmarshal type long");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (long)untypedValue;
            serializer.Serialize(writer, value.ToString());
            return;
        }

        public static readonly ParseStringConverter Singleton = new ParseStringConverter();
    }

    internal class TypeEnumConverter : JsonConverter
    {
        public override bool CanConvert(Type t) => t == typeof(RajaOngkirCityTypeEnum) || t == typeof(RajaOngkirCityTypeEnum?);

        public override object ReadJson(JsonReader reader, Type t, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;
            var value = serializer.Deserialize<string>(reader);
            switch (value)
            {
                case "Kabupaten":
                    return RajaOngkirCityTypeEnum.Kabupaten;
                case "Kota":
                    return RajaOngkirCityTypeEnum.Kota;
            }
            throw new Exception("Cannot unmarshal type TypeEnum");
        }

        public override void WriteJson(JsonWriter writer, object untypedValue, JsonSerializer serializer)
        {
            if (untypedValue == null)
            {
                serializer.Serialize(writer, null);
                return;
            }
            var value = (RajaOngkirCityTypeEnum)untypedValue;
            switch (value)
            {
                case RajaOngkirCityTypeEnum.Kabupaten:
                    serializer.Serialize(writer, "Kabupaten");
                    return;
                case RajaOngkirCityTypeEnum.Kota:
                    serializer.Serialize(writer, "Kota");
                    return;
            }
            throw new Exception("Cannot marshal type TypeEnum");
        }

        public static readonly TypeEnumConverter Singleton = new TypeEnumConverter();
    }
}