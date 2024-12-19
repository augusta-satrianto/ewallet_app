import 'dart:convert';

import 'package:ewallet_app/models/tip_model.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class TipService {
  Future<List<TipModel>> getTips() async {
    try {
      final token = await AuthService().getToken();

      final res = await http
          .get(Uri.parse('$baseUrl/tips'), headers: {'Authorization': token});

      if (res.statusCode == 200) {
        return List<TipModel>.from(
          jsonDecode(res.body)['data'].map(
            (tip) => TipModel.fromJson(tip),
          ),
        ).toList();
      }
      throw jsonDecode(res.body)['message'];
    } catch (e) {
      rethrow;
    }
  }
}
