import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/crypto_currency.dart';
import '../pages/details.page.dart';
import '../pages/markets.dart';
import '../providers/market_provider.dart';

class CryptoListTile extends StatelessWidget {
  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  final CryptoCurrency currentCrypto;

  @override
  Widget build(BuildContext context) {
    Marketprovider marketProvider =
        Provider.of<Marketprovider>(context, listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsPage(
                      id: currentCrypto.id!,
                    )));
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          currentCrypto.image!,
        ),
      ),
      title: Row(
        children: [
          Flexible(
              child: Text(
            currentCrypto.name!,
            overflow: TextOverflow.ellipsis,
          )),
          const SizedBox(
            width: 10,
          ),
          (currentCrypto.isFav == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFav(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart,
                    size: 20,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFav(currentCrypto);
                  },
                  child: const Icon(
                    CupertinoIcons.heart_fill,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
        ],
      ),
      subtitle: Text(
        currentCrypto.symbol!.toUpperCase(),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
            style: const TextStyle(
                color: Color(0xff0395eb),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;
            if (priceChange < 0) {
              //negative
              return Text(
                "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                style: const TextStyle(color: Colors.red),
              );
            } else {}
            return Text(
              "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
              style: const TextStyle(color: Colors.green),
            );
          }),
        ],
      ),
    );
  }
}
