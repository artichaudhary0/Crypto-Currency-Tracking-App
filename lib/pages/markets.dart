import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/crypto_currency.dart';
import '../providers/market_provider.dart';
import '../widgets/crypto_currency_list.dart';

class MarketValueView extends StatefulWidget {
  const MarketValueView({Key? key}) : super(key: key);

  @override
  State<MarketValueView> createState() => _MarketValueViewState();
}

class _MarketValueViewState extends State<MarketValueView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Marketprovider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (marketProvider.markets.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = marketProvider.markets[index];

                  return CryptoListTile(
                    currentCrypto: currentCrypto,
                  );
                },
              ),
            );
          } else {
            return const Text("Data Not Found!");
          }
        }
      },
    );
  }
}
