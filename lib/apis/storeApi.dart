import 'dart:convert';
import 'dart:io';
import 'dart:core';
import 'package:magento2_app/configurations/clientConfig.dart';
import 'package:magento2_app/models/catalog.dart';
import 'package:http/http.dart' as http;
import 'package:magento2_app/models/store.dart';

class StoreAPI {
  Future<StoreConfig> getStoreConfig() async {
    var uri = Uri.parse(ClientConfigs.baseURL+ClientConfigs.requestType+ClientConfigs.storeID+ClientConfigs.version+APIPath.getStoreConfigPath);

    final response =
    await http.get(uri, headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken});

    if (response.statusCode == ResponseStatus.RESPONSE_SUCCESS) {
      // If the call to the server was successful, parse the JSON.
      final data = json.decode(response.body);
      final storeConfigs = data as List;
      return StoreConfig.fromJson(storeConfigs[0]);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load store config');
    }
  }

  Future<String> login() async {
    var uri = Uri.parse(ClientConfigs.baseURL+ClientConfigs.requestType+ClientConfigs.storeID+ClientConfigs.version+"integration/admin/token");
    final params = {
      "username": "demo",
      "password": "1q2w3e4r5t"
    };
    final response = await http.post(uri,
        headers: {'Authorization': 'Bearer ' + ClientConfigs.accessToken, "Content-Type": "application/json"},
        body: json.encode(params));

    if (response.statusCode == ResponseStatus.RESPONSE_SUCCESS) {
      // If the call to the server was successful, parse the JSON.
      final data = json.decode(response.body);
      return data;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load store config');
    }
  }
}

