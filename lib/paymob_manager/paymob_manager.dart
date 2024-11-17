import 'package:dio/dio.dart';
import 'package:flutter_paymob_app/paymob_manager/constant.dart';
import 'package:flutter_paymob_app/paymob_manager/error_handlers.dart';

class PaymobManager {
  Future<String> getPaymentKey(int amount, String currency) async {
    try {
      String authenticationToken = await _getAuthenticationToken();

      int orderId = await _getOrderId(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
      );

      String paymentKey = await _getPaymentKey(
        authenticationToken: authenticationToken,
        amount: (100 * amount).toString(),
        currency: currency,
        orderId: orderId.toString(),
      );
      return paymentKey;
    } catch (e) {
      if (e is DioException) {
        // print(ErrorHandler.handleDioError(e));
        throw Exception(ErrorHandler.handleDioError(e));
      } else {
        // print(ErrorHandler.handleGeneralError(e));
        throw Exception(ErrorHandler.handleGeneralError(e));
      }
    }
  }

  Future<String> _getAuthenticationToken() async {
    try {
      final Response response = await Dio().post(
        "https://accept.paymob.com/api/auth/tokens",
        data: {
          "api_key": KConstants.apiKey,
        },
      );
      return response.data["token"];
    } on DioException catch (e) {
      throw Exception(ErrorHandler.handleDioError(e));
    } catch (e) {
      throw Exception(ErrorHandler.handleGeneralError(e));
    }
  }

  Future<int> _getOrderId({
    required String authenticationToken,
    required String amount,
    required String currency,
  }) async {
    try {
      final Response response = await Dio().post(
        "https://accept.paymob.com/api/ecommerce/orders",
        data: {
          "auth_token": authenticationToken,
          "amount_cents": amount,
          "currency": currency,
          "delivery_needed": "false",
          "items": [],
        },
      );
      return response.data["id"];
    } on DioException catch (e) {
      throw Exception(ErrorHandler.handleDioError(e));
    } catch (e) {
      throw Exception(ErrorHandler.handleGeneralError(e));
    }
  }

  Future<String> _getPaymentKey({
    required String authenticationToken,
    required String orderId,
    required String amount,
    required String currency,
  }) async {
    try {
      final Response response = await Dio().post(
        "https://accept.paymob.com/api/acceptance/payment_keys",
        data: {
          "expiration": 3600,
          "auth_token": authenticationToken,
          "order_id": orderId,
          "integration_id": KConstants.cardPaymentMethodIntegrationId,
          "amount_cents": amount,
          "currency": currency,
          "billing_data": {
            "first_name": "Clifford",
            "last_name": "Nicolas",
            "email": "claudette09@exa.com",
            "phone_number": "+86(8)9135210487",
            "apartment": "NA",
            "floor": "NA",
            "street": "NA",
            "building": "NA",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "state": "NA"
          },
        },
      );
      return response.data["token"];
    } on DioException catch (e) {
      throw Exception(ErrorHandler.handleDioError(e));
    } catch (e) {
      throw Exception(ErrorHandler.handleGeneralError(e));
    }
  }
}
