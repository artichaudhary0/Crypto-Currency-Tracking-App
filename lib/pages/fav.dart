import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/crypto_currency.dart';
import '../providers/market_provider.dart';
import '../widgets/crypto_currency_list.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Marketprovider>(builder: (context, marketProvider, child) {
      List<CryptoCurrency> favorites = marketProvider.markets
          .where((element) => element.isFav == true)
          .toList();
      if (favorites.isNotEmpty) {
        return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, int index) {
              CryptoCurrency currentCrypto = favorites[index];
              return CryptoListTile(currentCrypto: currentCrypto);
            });
      } else {
        return const Center(
          child: Text(
            "No Favorites yet!!!",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        );
      }
    });
  }
}
