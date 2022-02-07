import 'package:flutter_test_work/models/address_model.dart';
import 'package:flutter_test_work/models/company_model.dart';

class UserModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        username = json['username'],
        email = json['email'],
        address = AddressModel.fromJson(json['address']),
        phone = json['phone'],
        website = json['website'],
        company = CompanyModel.fromJson(json['company']);
}
