// To parse this JSON data, do
//
//     final prices = pricesFromJson(jsonString);

import 'dart:convert';

Prices pricesFromJson(String str) => Prices.fromJson(json.decode(str));

String pricesToJson(Prices data) => json.encode(data.toJson());

class Prices {
  Prices({
    this.km,
    this.min,
    this.minValue,
  });

  double km;
  double min;
  double minValue;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
    km: json["km"]?.toDouble() ?? 0,
    min:  json["min"]?.toDouble() ?? 0,
    minValue: json["minValue"]?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "km": km,
    "min": min,
    "minValue": minValue,
  };
}
