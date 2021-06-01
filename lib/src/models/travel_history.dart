// To parse this JSON data, do
//
//     final travelHistory = travelHistoryFromJson(jsonString);

import 'dart:convert';

TravelHistory travelHistoryFromJson(String str) => TravelHistory.fromJson(json.decode(str));

String travelHistoryToJson(TravelHistory data) => json.encode(data.toJson());

class TravelHistory {
  TravelHistory({
    this.id,
    this.idClient,
    this.idDriver,
    this.from,
    this.to,
    this.timestamp,
    this.price,
    this.calificationClient,
    this.calificationDriver,
  });

  String id;
  String idClient;
  String idDriver;
  String from;
  String to;
  int timestamp;
  double price;
  double calificationClient;
  double calificationDriver;

  factory TravelHistory.fromJson(Map<String, dynamic> json) => TravelHistory(
    id: json["id"],
    idClient: json["idClient"],
    idDriver: json["idDriver"],
    from: json["from"],
    to: json["to"],
    timestamp: json["timestamp"],
    price: json["price"]?.toDouble() ?? 0,
    calificationClient: json["calificationClient"]?.toDouble() ?? 0,
    calificationDriver: json["calificationDriver"]?.toDouble() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idClient": idClient,
    "idDriver": idDriver,
    "from": from,
    "to": to,
    "timestamp": timestamp,
    "price": price,
    "calificationClient": calificationClient,
    "calificationDriver": calificationDriver,
  };
}
