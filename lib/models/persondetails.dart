import 'package:flutter/material.dart';

class PersonDetails {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;

  PersonDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) => PersonDetails(
    id: json['id'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    gender: json['gender'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'gender': gender,
  };
}
