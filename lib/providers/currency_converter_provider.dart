import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CurrencyConverterProvider extends ChangeNotifier {
  var result;
  var fromVal;
  var toVal;

  Future<Map> getCurrencies() async {
    var uri = Uri.parse(
        "https://api.currencyapi.com/v3/latest?apikey=2bvx01IHEKFZALfVwbWVG9LKUKRyymcdonzaJhjs");
    var response = await http.get(uri);
    if (response.body.isNotEmpty) {
      return jsonDecode(response.body)["data"];
    } else {
      throw Exception("failed to load data");
    }
  }

  List<String> getCodes(Map currencyData) {
    List<String> codes = [];
    for (Map currency in currencyData.values) {
      codes.add(currency['code']);
    }
    return codes;
  }

  double getValue(String code, Map currencyData) {
    return currencyData[code]["value"];
  }

  void convert(double amount) {
    if (fromVal < toVal) {
      result = amount * toVal;
    } else {
      result = amount / toVal;
    }
    notifyListeners();
  }
}
