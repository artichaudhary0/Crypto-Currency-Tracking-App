import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'fav.dart';
import 'markets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController viewController;
  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Crypto Today",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    themeProvider.toggle();
                  },
                  icon: (themeProvider.themeMode == ThemeMode.light)
                      ? const Icon(
                          Icons.dark_mode,
                        )
                      : const Icon(Icons.light_mode),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TabBar(
              controller: viewController,
              tabs: [
                Tab(
                  child: Text(
                    "Markets",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Tab(
                  child: Text(
                    "Favorites",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                  controller: viewController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: const [
                    MarketValueView(),
                    Favorites(),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
