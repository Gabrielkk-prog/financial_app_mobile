import 'package:financial_app_project/common/constants/app_colors.dart';
import 'package:financial_app_project/common/constants/app_text_styles.dart';
import 'package:financial_app_project/common/constants/routes.dart';
import 'package:financial_app_project/common/controllers/balance_controller.dart';
import 'package:financial_app_project/common/controllers/home_controller.dart';
import 'package:financial_app_project/common/extensions/page_controller_ext.dart';
import 'package:financial_app_project/common/mixins/custom_modal_sheet_mixin.dart';
import 'package:financial_app_project/common/widgets/app_header.dart';
import 'package:financial_app_project/common/widgets/balance_card_widget.dart';
import 'package:financial_app_project/common/widgets/custom_circular_progress_indicator.dart';
import 'package:financial_app_project/common/widgets/home_controller.dart';
import 'package:financial_app_project/common/widgets/home_state.dart';
import 'package:financial_app_project/common/widgets/transaction_list_view.dart';
import 'package:financial_app_project/features/balance/balance_controller.dart';
import 'package:financial_app_project/features/locator.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with CustomModalSheetMixin {
  final _homeController = locator.get<HomeController>();
  final _balanceController = locator.get<BalanceController>();

  @override
  void initState() {
    super.initState();

    _homeController.getUserData();
    _homeController.getLatestTransactions();
    _balanceController.getBalances();

    _homeController.addListener(_handleHomeStateChange);
  }

  @override
  void dispose() {
    _homeController.removeListener(_handleHomeStateChange);
    super.dispose();
  }

  void _handleHomeStateChange() {
    final state = _homeController.state;
    switch (state.runtimeType) {
      case HomeStateError:
        if (!mounted) return;

        showCustomModalBottomSheet(
          context: context,
          content: (_homeController.state as HomeStateError).message,
          buttonText: 'Go to login',
          isDismissible: false,
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            NamedRoutes.initial,
            (route) => false,
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _homeController,
            builder: (context, child) {
              if (_homeController.state is HomeStateSuccess) {
                return const AppHeader();
              }

              return const SizedBox.shrink();
            },
          ),
          BalanceCardWidget(controller: _balanceController),
          Positioned(
            top: 397.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transaction History',
                        style: AppTextStyles.mediumText18,
                      ),
                      GestureDetector(
                        onTap: () {
                          _homeController.pageController
                              .navigateTo(BottomAppBarItem.wallet);
                        },
                        child: const Text(
                          'See all',
                          style: AppTextStyles.inputLabelText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _homeController,
                    builder: (context, _) {
                      if (_homeController.state is HomeStateLoading) {
                        return const CustomCircularProgressIndicator(
                          color: AppColors.green,
                        );
                      }
                      if (_homeController.state is HomeStateError) {
                        return const Center(
                          child: Text('An error has occurred'),
                        );
                      }

                      if (_homeController.state is HomeStateSuccess &&
                          _homeController.transactions.isNotEmpty) {
                        return TransactionListView(
                          transactionList: _homeController.transactions,
                          onChange: () {
                            _homeController.getLatestTransactions();
                            _balanceController.getBalances();
                          },
                        );
                      }

                      return const Center(
                        child: Text('There are no transactions at this time.'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}