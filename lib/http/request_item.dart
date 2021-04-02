import 'dart:convert';

import 'package:flutter_networking/http/base_request.dart';
import 'package:flutter_networking/model/item.dart';
import 'package:http/http.dart' as http;

class RequestItem implements HTTPRequest<Item> {
  final String host;
  final String api;
  const RequestItem({ required this.host, required this.api });

  @override
  Future<Item> execute() async {
    final response = await http.get(Uri.https(host, api));

    if (response.statusCode != 200) {
      throw http.ClientException('Oh darn!');
    }

    return _parseJson(response.body);
  }

  Item _parseJson(String response) =>
      Item.fromJson(jsonDecode(response));
}