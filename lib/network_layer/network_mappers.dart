import 'dart:convert';

// Handler for the network's request.
abstract class RequestMappable {
  Map<String, dynamic> toJson();
}

// Handler for the network's response.
abstract class Mappable {
  factory Mappable(Mappable type, String data) {
    if (type is BaseMappable) {
      Map<String, dynamic> mappingData = json.decode(data);
      return type.fromJson(mappingData);
    } else if (type is ListMappable) {
      List iterableData = json.decode(data);
      return type.fromJsonList(iterableData);
    }

    return Mappable(type, data);
  }
}

abstract class BaseMappable<T> implements Mappable {
  Mappable fromJson(Map<String, dynamic> json);
}

abstract class ListMappable<T> implements Mappable {
  Mappable fromJsonList(List<dynamic> json);
}

// Handler for the network's error response.
abstract class ErrorMappable implements BaseMappable {
  String? errorCode;
  String? description;
}