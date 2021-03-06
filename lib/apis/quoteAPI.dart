import 'package:magento2_app/DataStorage/KeyValueStorage.dart';
import 'package:magento2_app/configurations/clientConfig.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:magento2_app/models/order_calculated.dart';
import 'package:magento2_app/models/order_request.dart';

class QuoteAPI {
  Future<bool> addSimpleProductToGuestCart(Product product, String quoteID) async {
    if (quoteID != null) {
      final params = {
        "cartItem": {
          "sku": product.sku,
          "qty": product.qty ?? 1,
          "quote_id": quoteID,
          "price": product.price,
          "item_id": product.itemId
        }
      };
//      final body = jsonEncode(params);
      var uri = Uri.parse(ClientConfigs.loadBasicURL() + APIPath.guestCartsPath + quoteID + "/items");
      final response = await http.post(uri,
          headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken, "Content-Type": "application/json"},
          body: json.encode(params));
      print(response);
      if (response.statusCode == ResponseStatus.RESPONSE_SUCCESS) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<List<Product>?> getItemFromCart(String quoteID) async {
    if (quoteID != null) {
      var uri = Uri.parse(ClientConfigs.loadBasicURL() + APIPath.guestCartsPath + quoteID + "/items");
      final response = await http
          .get(uri, headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken, "Content-Type": "application/json"});
      if (response.statusCode == ResponseStatus.RESPONSE_SUCCESS) {
        final data = json.decode(response.body);
        print(data);
        return data.map<Product>((json) => Product.fromJsonCart(json)).toList();
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<OrderCalculated?> calculateOrder(String quoteID) async {
    if (quoteID != null) {
      var uri = Uri.parse(ClientConfigs.loadBasicURL() + APIPath.guestCartsPath + quoteID + "/totals");
      final response = await http
          .get(uri, headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken, "Content-Type": "application/json"});
      if (response.statusCode == ResponseStatus.RESPONSE_SUCCESS) {
        return OrderCalculated.fromJsonCart(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String> createAnEmptyGuestCart() async {
    var uri = Uri.parse(ClientConfigs.loadBasicURL() + APIPath.guestCartsPath);
    final response = await http.post(uri, headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken});
    print(response);
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON.
      return json.decode(response.body) as String;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to create a guest cart');
    }
  }

  Future<bool> requestShippingInformation(quoteId, OrderRequest orderRequest) async {
    final params = {
      "addressInformation": {
        "shipping_address": {
          "countryId": "VN",
          "region": "",
          "street": [
            "29bt1"
          ],
          "company": "",
          "telephone": orderRequest.billingAddress!.telephone,
          "postcode": "100000",
          "city": "HANOI",
          "firstname": orderRequest.billingAddress!.firstname,
          "lastname": orderRequest.billingAddress!.lastname
        },
        "billing_address": {
          "countryId": "VN",
          "region": "",
          "street": [
            "29bt1"
          ],
          "company": "",
          "telephone":orderRequest.billingAddress!.telephone,
          "postcode": "100000",
          "city": "HANOI",
          "firstname": orderRequest.billingAddress!.firstname,
          "lastname": orderRequest.billingAddress!.lastname,
          "saveInAddressBook": null
        },
        "shipping_method_code": "flatrate",
        "shipping_carrier_code": "flatrate",
        "extension_attributes": {}
      }
    };
    var uri = Uri.parse(ClientConfigs.loadBasicURL() + APIPath.guestCartsPath + quoteId + '/shipping-information');
    final response = await http.post(uri,
        headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken, "Content-Type": "application/json"},
        body: json.encode(params));
    print(response);
    if (response.statusCode == 200) {
      // Send API order create
      await requestCreateOrder(quoteId, orderRequest);
      return true;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to create a guest cart');
    }
  }
  Future<bool> requestCreateOrder(quoteId, OrderRequest orderRequest) async {
    final params = {
      "cartId": quoteId,
      "billingAddress": {
        "countryId": "VN",
        "region": "",
        "street": orderRequest.billingAddress!.street,
        "company": "ACC",
        "telephone": orderRequest.billingAddress!.telephone,
        "postcode": "100000",
        "city": "HANOI",
        "firstname": orderRequest.billingAddress!.firstname,
        "lastname": orderRequest.billingAddress!.lastname,
        "saveInAddressBook": null
      },
      "paymentMethod": {"method": "checkmo", "po_number": null, "additional_data": null},
      "email": orderRequest.email!.trim()
    };
    var uri = Uri.parse(ClientConfigs.loadBasicURL() + APIPath.guestCartsPath + quoteId + '/payment-information');
    final response = await http.post(uri,
        headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken, "Content-Type": "application/json"},
        body: json.encode(params));
    print(response);
    if (response.statusCode == 200) {

      KeyValueStorage().set('-1', PreferenceKeys.quoteGuestID);

      return true;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to create a guest cart');
    }
  }
}
