import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/views/transaction_entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef ChangePeriod = String Function(DateTime);
final isDeleted = StateProvider<bool>((ref) => false);

class TransactionDetailScreen extends StatefulHookConsumerWidget {
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
  TransactionDetailScreenState createState() => TransactionDetailScreenState();
}

class TransactionDetailScreenState
    extends ConsumerState<TransactionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    bool imagesNotNull = widget.transaction.imageUrl != null;

    void deleteTransaction() {
      ref.read(
        deleteTransactions(
          widget.transaction.id,
        ),
      );

      ref.read(isDeleted.notifier).update((state) => true);
      Navigator.pop(context, true);
    }

    return Container(
      height: context
          .getHeight(0.63), //context.getHeight(imagesNotNull ? 0.63 : 0.3),
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      /*imagesNotNull
          ? const EdgeInsets.fromLTRB(16, 0, 16, 32)
          : const EdgeInsets.fromLTRB(16, 0, 16, 120),*/
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
                  widget.categoryIcon,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
                const SizedBox(width: 5),
                Column(
                  children: [
                    Text(
                      widget.transaction.category,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      widget.transaction.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 10),
                    ),
                    Text(
                      '${widget.date(widget.transaction.date)}'
                      '     ${widget.time(widget.transaction.date)}',
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
                        value: widget.transaction.amount,
                        symbol: widget.currency,
                      ),
                      style: TextStyle(
                        color: widget._transactionType == 'income'
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
                            widget.paymentType?.icon,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                          Text(
                            widget.paymentType?.title ?? '',
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
            if (widget.transaction.description != null)
              Text(
                widget.transaction.description ?? '',
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 10),
            if (imagesNotNull)
              Container(
                height: context.getHeight(0.4),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: FileImage(
                        File(widget.transaction.imageUrl!),
                      ),
                      fit: BoxFit.fill,
                    )),
                // child: Image.file(
                //   File(widget.transaction.imageUrl!),
                //   fit: BoxFit.fill,
                //   //width: double.infinity,
                //   // height: double.infinity,
                // ),
              )
            else
              Placeholder(
                color: Theme.of(context).primaryColor,
                fallbackHeight: 300,
                fallbackWidth: 10,
                strokeWidth: 1,
                // child: const Text(
                //   'no image for this transaction',
                //   style: TextStyle(fontSize: 18),
                // ),
              ),
            const Spacer(),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final isDelete = ref.watch(isDeleted);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Clear All',
                      child: IconButton(
                        onPressed: () {
                          log(widget.transaction.imageUrl ?? 'h');
                          alertDialog(
                            content: 'are you sure you want to delete this '
                                'transaction?',
                            context: context,
                            ref: ref,
                            title: 'Delete Transaction',
                            delete: deleteTransaction,
                          ).then((value) {
                            value ??= isDelete;
                            if (value == true) {
                              Navigator.pop(context);
                            }
                          });
                        },
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    const Spacer(),
                    Tooltip(
                      message: 'Edit',
                      child: IconButton(
                          onPressed: () {
                            context
                                .pushTransition(
                                  AddTransactionsScreen(
                                    isNav: true,
                                    name: widget.transaction.name,
                                    amount:
                                        widget.transaction.amount.toString(),
                                    description: widget.transaction.description,
                                    date: widget.transaction.date,
                                    categoryTransactionName:
                                        widget.transaction.category,
                                    payMent:
                                        widget.transaction.paymentType ?? '',
                                    id: widget.transaction.id,
                                    imagePath: widget.transaction.imageUrl,
                                    transactionType:
                                        widget.transaction.transactionType,
                                  ),
                                )
                                .whenComplete(() => Navigator.pop(context));
                          },
                          icon: const Icon(Icons.edit),
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<bool?> alertDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Function() delete,
    required String title,
    required String content,
  }) {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Text(content,
            style: GoogleFonts.roboto(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            )),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'NO',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: delete,
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
