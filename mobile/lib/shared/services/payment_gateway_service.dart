import 'package:flutter_stripe/flutter_stripe.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class PaymentGatewayService {
  final DioClient _dioClient;
  final Logger _logger = Logger();

  PaymentGatewayService(this._dioClient) {
    // Stripe.publishableKey = 'YOUR_STRIPE_PUBLISHABLE_KEY';
  }

  Future<void> initPaymentSheet(String amount, String currency) async {
    try {
      // 1. Create a PaymentIntent on the server
      final response = await _dioClient.post(
        '${ApiEndpoints.payments}/create-payment-intent',
        data: {
          'amount': amount,
          'currency': currency,
        },
      );

      final paymentIntentData = response.data['data'];

      // 2. Initialize the PaymentSheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['clientSecret'],
          merchantDisplayName: 'Reservatior',
          customerId: paymentIntentData['customerId'],
          customerEphemeralKeySecret: paymentIntentData['ephemeralKey'],
        ),
      );

      // 3. Present the PaymentSheet
      await Stripe.instance.presentPaymentSheet();
      _logger.i('mobile.leftovers.payment_successful'.tr());
    } catch (e) {
      if (e is StripeException) {
        _logger.e('Stripe error: ${e.error.localizedMessage}');
      } else {
        _logger.e('Error during payment processing: $e');
      }
      rethrow;
    }
  }

  Future<bool> verifyPayment(String paymentIntentId) async {
    final response = await _dioClient.get('${ApiEndpoints.payments}/verify/$paymentIntentId');
    return response.data['data']['status'] == 'succeeded';
  }

  Future<void> processRefund(String paymentId, String reason) async {
     await _dioClient.post('${ApiEndpoints.payments}/refund', data: {
       'paymentId': paymentId,
       'reason': reason,
     });
  }
}
