

import 'dart:convert';

RegisterRequest registerRequestFromJson(String str) => RegisterRequest.fromJson(json.decode(str));

String registerRequestToJson(RegisterRequest data) => json.encode(data.toJson());

class RegisterRequest {
  String? username;
  String? email;
  String? password;

  RegisterRequest({
    this.username,
    this.email,
    this.password,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => RegisterRequest(
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "email": email,
    "password": password,
  };
}
