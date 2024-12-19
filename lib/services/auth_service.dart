import 'dart:convert';
import 'dart:io';

import 'package:ewallet_app/models/sign_in_form_model.dart';
import 'package:ewallet_app/models/sign_up_form_model.dart';
import 'package:ewallet_app/models/user_model.dart';
import 'package:ewallet_app/shared/shared_values.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> checkEmail(String email) async {
    try {
      final res = await http
          .post(Uri.parse('$baseUrl/is-email-exist'), body: {'email': email});

      if (res.statusCode == 200) {
        return jsonDecode(res.body)['is_email_exist'];
      } else {
        throw jsonDecode(res.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register(SignUpFormModel data) async {
    try {
      final res =
          await http.post(Uri.parse('$baseUrl/register'), body: data.toJson());

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> login(SignInFormModel data) async {
    try {
      final res =
          await http.post(Uri.parse('$baseUrl/login'), body: data.toJson());

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(jsonDecode(res.body));

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw jsonDecode(res.body)['errors'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      final res = await http.post(Uri.parse('$baseUrl/logout'), headers: {
        'Authorization': token,
      });

      if (res.statusCode == 200) {
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  // Menyimpan data bahwa sebelumnya telah login dan belum logout
  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'email', value: user.email);
      await storage.write(key: 'password', value: user.password);
    } catch (e) {
      rethrow;
    }
  }

  // Cek apakah ada credential atau telah login sebelumnya
  Future<SignInFormModel> getCredentialFormLocal() async {
    try {
      const storage = FlutterSecureStorage();
      Map<String, String> values = await storage.readAll();

      if (values['email'] == null || values['password'] == null) {
        throw 'authenticated';
      } else {
        final SignInFormModel data = SignInFormModel(
            email: values['email'], password: values['password']);
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Mendapatkan token
  Future<String> getToken() async {
    String token = '';
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'token');

    if (value != null) {
      // Tambahkan 'Bearer ' karena menyesuaikan API'
      token = 'Bearer $value';
    }

    return token;
  }

  // Hapus credential saat Log Out
  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}

String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}
