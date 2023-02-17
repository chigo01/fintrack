import 'package:fintrack/src/core/utils/enum.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryIndexWidget extends StatelessWidget {
  const CategoryIndexWidget({
    super.key,
    required this.currentTransactionType,
    required this.themeModeCheck,
    required this.ref,
    required this.transactionType,
  });

  final TransactionType currentTransactionType;
  final bool themeModeCheck;
  final WidgetRef ref;
  final StateProvider<TransactionType> transactionType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          TransactionType.values.length,
          (index) {
            bool selectedTransaction =
                currentTransactionType == TransactionType.values[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                    TransactionType.values[index].name.capitalized,
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
    );
  }
}
