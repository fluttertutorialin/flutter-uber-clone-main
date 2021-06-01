// To parse this JSON data, do
//
//     final driver = driverFromJson(jsonString);

import 'dart:convert';

Driver driverFromJson(String str) => Driver.fromJson(json.decode(str));

String driverToJson(Driver data) => json.encode(data.toJson());

class Driver {
  Driver({
    this.id,
    this.username,
    this.email,
    this.password,
    this.plate,
    this.token
  });

  String id;
  String username;
  String email;
  String password;
  String plate;
  String token;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    plate: json["plate"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "plate": plate,
    "token": token,
  };
}
