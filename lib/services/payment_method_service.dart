import 'dart:convert';
import 'package:ewallet_app/models/payment_method_model.dart';
import 'package:ewallet_app/services/auth_service.dart';
import 'package:ewallet_app/shared/shared_values.dart';
import 'package:http/http.dart' as http;

class PaymentMethodService {
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final token = await AuthService().getToken();
      final res = await http.get(
        Uri.parse('$baseUrl/payment_methods'),
        headers: {
          'Authorization': token,
        },
      );

      if (res.statusCode == 200) {
        return List<PaymentMethodModel>.from(jsonDecode(res.body)
            .map((paymentMethod) => PaymentMethodModel.fromJson(paymentMethod))
            .toList());
      } else {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
