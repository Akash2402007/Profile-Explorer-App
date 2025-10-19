import 'dart:convert';
import '../../domain/entities/user.dart';

List<User> userFromJson(String str) => List<User>.from(json.decode(str)['results'].map((x) => UserModel.fromJson(x)));

class UserModel extends User {
  UserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String picture,
    required int age,
    required String city,
    required String country,
    bool isLiked = false,
  }) : super(
    id: id,
    firstName: firstName,
    lastName: lastName,
    email: email,
    picture: picture,
    age: age,
    city: city,
    country: country,
    isLiked: isLiked,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['login']['uuid'],
      firstName: json['name']['first'],
      lastName: json['name']['last'],
      email: json['email'],
      picture: json['picture']['large'],
      age: json['dob']['age'],
      city: json['location']['city'],
      country: json['location']['country'],
    );
  }
}