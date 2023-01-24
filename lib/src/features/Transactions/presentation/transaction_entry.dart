// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/current_page_provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/tabs/expense_tab.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/tabs/income_tab.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/datatime_format.dart';
import 'package:fintrack/src/core/utils/extension.dart';

enum TransactionType {
  expense,
  income,
}

class AddTransactionsScreen extends StatefulHookConsumerWidget {
  const AddTransactionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends ConsumerState<AddTransactionsScreen> {
  DateTime date = DateTime.now();
  DateTimeFormatter format = DateTimeFormatter();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final category = ref.watch(currentIndex);
    final categoryName = ref.watch(currentCategory);
    final paymentIndex = ref.watch(paymentCurrentIndex);
    final payment = ref.watch(paymentName);
    final themeModeCheck = theme == ThemeMode.dark;
    final currentTransactionType = ref.watch(transactionType);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
          // padding: EdgeInsets.only(bottom: context.width * 0.02),
          height: 60,
          color: Colors.transparent,
          child: Column(
            children: [
              Icon(
                PhosphorIcons.checkSquare,
                color: Theme.of(context).primaryColor,
              ),
              const Text(
                'Save',
                style: TextStyle(fontSize: 8),
              )
            ],
          ),
        ).onTap(() {
          log('saved');
        }),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Add Transaction',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            leading: IconButton(
              onPressed: () {
                context.maybePop();
              },
              icon: Icon(
                PhosphorIcons.arrowBendUpLeft,
                color: themeModeCheck ? null : Colors.black,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          TransactionType.values.length,
                          (index) {
                            bool selectedTransaction = currentTransactionType ==
                                TransactionType.values[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                height: 45,
                                width: 115,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: selectedTransaction
                                      ? Theme.of(context)
                                          .primaryColor //Theme.of(context).primaryColor
                                      : null,
                                  border: Border.all(
                                    color: selectedTransaction
                                        ? Colors.transparent
                                        : const Color(0xff508cf3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    TransactionType
                                        .values[index].name.capitalized,
                                    style: TextStyle(
                                      color: themeModeCheck
                                          ? null
                                          : selectedTransaction
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ).onTap(
                              () {
                                ref.read(transactionType.notifier).state =
                                    TransactionType.values[index];
                              },
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'Date: ${format.dateToString(date)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 10,
                                ),
                          ),
                          AutoSizeText(
                            'Time:  ${format.timeToString(date)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 10,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    IndexedStack(
                      index: currentTransactionType.index,
                      children: [
                        ExpenseTap(
                          categoryName: categoryName,
                          category: category,
                          theme: theme,
                          ref: ref,
                          themeModeCheck: themeModeCheck,
                          textEditingController: _textEditingController,
                          paymentIndex: paymentIndex,
                        ),
                        IncomeTab(
                          categoryName: categoryName,
                          categoryIndex: category,
                          theme: theme,
                          ref: ref,
                          themeModeCheck: themeModeCheck,
                          paymentIndex: paymentIndex,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
