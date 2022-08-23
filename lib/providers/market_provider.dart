import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../models/api.dart';
import '../models/crypto_currency.dart';
import '../models/local_storage.dart';

class Marketprovider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  Marketprovider() {
    fetchData();
  }
  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarket();
    List<String> favorites = await LocalStorage.fetchfav();

    List<CryptoCurrency> temp = [];
    for (var markets in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(markets);
      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isFav = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFav(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFav = true;
    await LocalStorage.saveFav(crypto.id!);
    notifyListeners();
  }

  void removeFav(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFav = false;
    await LocalStorage.removefav(crypto.id!);
    notifyListeners();
  }
}
