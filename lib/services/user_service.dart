import 'dart:convert';

import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class UserService {
  // Mendapatkan List user yang sebelumnya di transfer
  Future<List<UserModel>> getUsers() async {
    try {
      final token = await AuthService().getToken();

      final res = await http
          .get(Uri.parse('$baseUrl/users'), headers: {'Authorization': token});

      if (res.statusCode == 200) {
        return List<UserModel>.from(
          jsonDecode(res.body).map(
            (user) => UserModel.fromJson(user),
          ),
        );
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUser() async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(Uri.parse('$baseUrl/userlogin'),
          headers: {'Authorization': token});

      if (res.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(res.body)['user']);
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUsersByUsername(String username) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.get(Uri.parse('$baseUrl/users/$username'),
          headers: {'Authorization': token});

      if (res.statusCode == 200) {
        return List<UserModel>.from(
          jsonDecode(res.body).map(
            (user) => UserModel.fromJson(user),
          ),
        );
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
