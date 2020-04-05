import 'dart:convert';
import 'package:flutter/material.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class Banners {
  Future<List> getBanner(type) async {
    List banners;
    final response = await http.post('$BASE_URL/banners/getBanners/', body: {
      'type': type,
    });
    if (response.statusCode == 200) {
      var bannerImgsObj = json.decode(response.body);
      banners = bannerImgsObj["banners"];

      return banners;
    } else {
      print("$response");
    }
  }
}
