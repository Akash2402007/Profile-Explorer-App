import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class RemoteDataSource {
  final String baseUrl = 'https://randomuser.me/api/';

  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(Uri.parse('${baseUrl}?results=20'));

      if (response.statusCode == 200) {
        return userFromJson(response.body);
      } else {
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }
}