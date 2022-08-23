import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import '../models/crypto_currency.dart';
import '../providers/market_provider.dart';
import '../widgets/details_list.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 29.0,
          ),
          child: Consumer<Marketprovider>(
              builder: (context, marketProvider, child) {
            CryptoCurrency currentCrypto =
                marketProvider.fetchCryptoById(widget.id);
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      maxRadius: 35.0,
                      backgroundImage: NetworkImage(currentCrypto.image!),
                    ),
                    title: Text(
                      "${currentCrypto.name!} (${currentCrypto.symbol!.toUpperCase()})",
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Text(
                      "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                      style: const TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Price Change (24h)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      Builder(builder: (context) {
                        double priceChange = currentCrypto.priceChange24!;
                        double priceChangePercentage =
                            currentCrypto.priceChangePercentage24!;
                        if (priceChange < 0) {
                          //negative
                          return Text(
                            "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 25),
                          );
                        } else {}
                        return Text(
                          "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                          style: const TextStyle(
                              color: Colors.green, fontSize: 25),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleDetail(
                          title: "Market Cap",
                          detail: " ₹ "
                              "${currentCrypto.marketCap!.toStringAsFixed(4)}",
                          crossAxisAlignment: CrossAxisAlignment.start),
                      titleDetail(
                          title: "Market Cap Rank",
                          detail: "#"
                              "${currentCrypto.marketCapRank}",
                          crossAxisAlignment: CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleDetail(
                          title: "Low 24h",
                          detail: " ₹ "
                              "${currentCrypto.low24.toStringAsFixed(4)}",
                          crossAxisAlignment: CrossAxisAlignment.start),
                      titleDetail(
                          title: "High 24h",
                          detail: " ₹ "
                              "${currentCrypto.high24!.toStringAsFixed(4)}",
                          crossAxisAlignment: CrossAxisAlignment.end),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleDetail(
                          title: "Circulating Supply",
                          detail: currentCrypto.circulatingSupply!
                              .toInt()
                              .toString(),
                          crossAxisAlignment: CrossAxisAlignment.start),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleDetail(
                          title: "All Time Low",
                          detail: currentCrypto.atl!.toStringAsFixed(4),
                          crossAxisAlignment: CrossAxisAlignment.start),
                      titleDetail(
                          title: "All Time High",
                          detail: currentCrypto.ath!.toStringAsFixed(4),
                          crossAxisAlignment: CrossAxisAlignment.end),
                    ],
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
