import 'package:magento2_app/models/payment_method_request.dart';

import 'billing_address_request.dart';

class OrderRequest{
  String? cartId;
  BillingAddressRequest? billingAddress;
  PaymentMethodRequest? paymentMethod;
  String? email;
}