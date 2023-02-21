import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef ChangePeriod = String Function(DateTime);

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen(
      {super.key,
      required this.transaction,
      required this.categoryIcon,
      this.paymentType,
      required String transactionType,
      required this.date,
      required this.time,
      required this.currency})
      : _transactionType = transactionType;

  final Transaction transaction;
  final IconData categoryIcon;
  final Category? paymentType;
  final ChangePeriod date;
  final ChangePeriod time;
  final String _transactionType;
  final String currency;

  @override
  Widget build(BuildContext context) {
    bool imagesNotNull = transaction.imageUrl != null;
    return Container(
      height: context.getHeight(imagesNotNull ? 0.63 : 0.3),
      width: double.infinity,
      margin: imagesNotNull
          ? const EdgeInsets.fromLTRB(16, 0, 16, 32)
          : const EdgeInsets.fromLTRB(16, 0, 16, 120),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Material(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    categoryIcon,
                    color: Theme.of(context).primaryColor,
                    size: 40,
                  ),
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      Text(
                        transaction.category,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        transaction.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 10),
                      ),
                      Text(
                        '${date(transaction.date)}'
                        '     ${time(transaction.date)}',
                        style: GoogleFonts.roboto(
                          color: Theme.of(context).primaryColor,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      AutoSizeText(
                        Money.format(
                          value: transaction.amount,
                          symbol: currency,
                        ),
                        style: TextStyle(
                          color: _transactionType == 'income'
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).colorScheme.error,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(
                          children: [
                            Icon(
                              paymentType?.icon,
                              color: Theme.of(context).primaryColor,
                              size: 20,
                            ),
                            Text(
                              paymentType?.title ?? '',
                              style: const TextStyle(fontSize: 8),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              if (transaction.description != null)
                Text(
                  transaction.description ?? '',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 10),
              if (imagesNotNull)
                SizedBox(
                  height: context.getHeight(0.4),
                  child: Image.file(
                    File(transaction.imageUrl!),
                    fit: BoxFit.fitHeight,
                  ),
                )
              else
                Placeholder(
                  color: Theme.of(context).primaryColor,
                  fallbackHeight: 60,
                  fallbackWidth: 10,
                  strokeWidth: 1,
                  child: const Text(
                    'no image for this transaction',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                      color: Theme.of(context).primaryColor),
                ],
              )
            ],
          )),
    );
  }
}
