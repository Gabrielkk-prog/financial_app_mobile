//BY DEFAULT, THE PAGE VIEW CLEARS THE STATE OF THE PREVIOUS PAGE WHEN IT IS NOT VISIBLE. 
import 'package:financial_app_project/common/constants/app_colors.dart';
import 'package:financial_app_project/common/constants/keys.dart';
import 'package:financial_app_project/common/extensions/page_controller_ext.dart';
import 'package:financial_app_project/common/widgets/custom_bottom_app_bar.dart';
import 'package:financial_app_project/common/widgets/home_controller.dart';
import 'package:financial_app_project/common/widgets/home_page.dart';
import 'package:financial_app_project/features/balance/balance_controller.dart';
import 'package:financial_app_project/features/home/transaction/transaction_controller.dart';
import 'package:financial_app_project/features/home/wallet/wallet_controller.dart';
import 'package:financial_app_project/features/locator.dart';
import 'package:financial_app_project/features/profile/profile_page.dart';
import 'package:financial_app_project/features/stats/wallet/wallet.dart' hide WalletController;
import 'package:flutter/material.dart';
import '../profile/profile.dart';
import '../stats/stats_controller.dart';
import '../stats/stats_page.dart';


class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final homeController = locator.get<HomeController>();
  final walletController = locator.get<WalletController>();
  final balanceController = locator.get<BalanceController>();
  final statsController = locator.get<StatsController>();

  @override
  void initState() {
    super.initState();
    homeController.setPageController = PageController();
  }

  @override
  void dispose() {
    locator.resetLazySingleton<HomeController>();
    locator.resetLazySingleton<BalanceController>();
    locator.resetLazySingleton<WalletController>();
    locator.resetLazySingleton<TransactionController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    homeController.pageController.setBottomAppBarItemIndex = 0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: homeController.pageController,
        children: const [
          HomePage(),
          StatsPage(),
          WalletPage(),
          ProfilePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/transaction');
          if (result != null) {
            switch (homeController.pageController.page) {
              case 0:
                homeController.getLatestTransactions();
                break;
              case 1:
                statsController.getTrasactionsByPeriod();
                break;
              case 2:
                walletController.getTransactionsByDateRange();
                break;
            }

            balanceController.getBalances();
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar(
        controller: homeController.pageController,
        selectedItemColor: AppColors.green,
        children: [
          CustomBottomAppBarItem(
            key: Keys.homePageBottomAppBarItem,
            label: BottomAppBarItem.home.name,
            primaryIcon: Icons.home,
            secondaryIcon: Icons.home_outlined,
            onPressed: () => homeController.pageController.navigateTo(
              BottomAppBarItem.home,
            ),
          ),
          CustomBottomAppBarItem(
            key: Keys.statsPageBottomAppBarItem,
            label: BottomAppBarItem.stats.name,
            primaryIcon: Icons.analytics,
            secondaryIcon: Icons.analytics_outlined,
            onPressed: () => homeController.pageController.navigateTo(
              BottomAppBarItem.stats,
            ),
          ),
          CustomBottomAppBarItem.empty(),
          CustomBottomAppBarItem(
            key: Keys.walletPageBottomAppBarItem,
            label: BottomAppBarItem.wallet.name,
            primaryIcon: Icons.account_balance_wallet,
            secondaryIcon: Icons.account_balance_wallet_outlined,
            onPressed: () => homeController.pageController.navigateTo(
              BottomAppBarItem.wallet,
            ),
          ),
          CustomBottomAppBarItem(
            key: Keys.profilePageBottomAppBarItem,
            label: BottomAppBarItem.profile.name,
            primaryIcon: Icons.person,
            secondaryIcon: Icons.person_outline,
            onPressed: () => homeController.pageController.navigateTo(
              BottomAppBarItem.profile,
            ),
          ),
        ],
      ),
    );
  }
}