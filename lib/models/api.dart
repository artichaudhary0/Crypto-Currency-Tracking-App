import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarket() async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=40&page=1&sparkline=false");
      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);
      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (e) {
      return [];
    }
  }

  static Future<List<dynamic>> getChartData(String id) async {
    try {
      Uri requestPath = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=inr&days=7&interval=daily");
      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);
      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (e) {
      return [];
    }
  }
}
