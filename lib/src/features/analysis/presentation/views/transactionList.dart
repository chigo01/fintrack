import 'dart:developer';

import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/presentation/widgets/trans_row.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/widgets/glass_container.dart';
import 'package:fintrack/src/features/analysis/presentation/providers/nav_analysis.dart';
import 'package:fintrack/src/features/analysis/presentation/views/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ChangePeriod = String Function(DateTime);

class TransactionList extends HookConsumerWidget {
  const TransactionList({
    super.key,
    required this.search,
    required this.date,
    required this.categories,
    required String transactionType,
    required this.time,
    required this.currency,
    required this.totalAmount,
  }) : _transactionType = transactionType;

  final List<Transaction> search;
  final List<Category> categories;

  final String _transactionType;
  final String currency;

  final double totalAmount;
  // ValueChanged<String> date;
  final ChangePeriod date;
  final ChangePeriod time;

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeProvider);
    final navAnalysis = ref.watch(navigatesAnalysis);

    return SizedBox(
      height: context.getHeight(navAnalysis
          ? .4
          : context.height >= 900
              ? 0.33
              : .3),
      width: context.getWidth(.9),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: search.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final element = search[index];
          final categoryIcon = categories
              .singleWhereOrNull((value) => value.title == element.category)
              ?.icon;
          final paymentIcon = paymentCategory
              .singleWhereOrNull((value) => value.title == element.paymentType);
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GlassMorphic(
              mode: theme,
              border: BorderRadius.circular(12),
              height: 80,
              width: 300,
              borderWidth: 2,
              borderColor: Colors.white30,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  TransactionRow(
                    categoryIcon: categoryIcon,
                    totalAmount: totalAmount,
                    transType: _transactionType,
                    currency: currency,
                    amount: element.amount,
                    text: Text(
                      element.category.capitalized,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    name: element.name.capitalized,
                    date: '${date(element.date)}'
                        '     ${time(element.date)}',
                    width: 10,
                    paymentTypeIcon: paymentIcon?.icon,
                    paymentType: paymentIcon?.title,
                  ),
                ],
              ),
            ),
          ).onTap(
            () {
              // context.push(TransactionDetailScreen(transaction: element))
              showCupertinoModalPopup(
                context: context,
                builder: (context) => TransactionDetailScreen(
                  transaction: element,
                  categoryIcon: categoryIcon!,
                  date: date,
                  time: time,
                  transactionType: _transactionType,
                  paymentType: paymentIcon,
                  currency: currency,
                ),
              );
              log(element.name);
              log(element.imageUrl!);
            },
          );
        },
      ),
    );
  }
}
