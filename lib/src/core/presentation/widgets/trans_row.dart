import 'package:fintrack/src/core/utils/money.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionRow extends StatelessWidget {
  const TransactionRow({
    super.key,
    required this.categoryIcon,
    required this.totalAmount,
    // required this.categoryName,
    required this.transType,
    required this.currency,
    required this.amount,
    required this.text,
    required this.width,
    this.name,
    this.date,
    this.paymentTypeIcon,
    this.paymentType,
  });

  final IconData? categoryIcon;
  final IconData? paymentTypeIcon;
  final double totalAmount;
  final double amount;
  // final String categoryName;
  final String currency;
  final String transType;
  final Text text;
  final double width;
  final String? name;
  final String? date;
  final String? paymentType;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(categoryIcon, size: 20, color: Colors.white),
              ),
              SizedBox(width: width),
              Expanded(
                flex: 1,
                child: name == null
                    ? text
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          text,
                          Text(
                            name ?? '',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            date ?? '',
                            style: GoogleFonts.acme(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 70),
        if (name == null)
          Expanded(
            child: Text(
              Money.percentage(
                amount: amount,
                totalAmount: totalAmount,
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        const SizedBox(width: 35),
        name == null
            ? Expanded(
                child: Text(
                  Money.format(
                    value: amount,
                    symbol: currency,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: transType == 'expense'
                            ? const Color(0xffFF4439)
                            : const Color(0xff4CAF50),
                      ),
                ),
              )
            : Expanded(
                child: Row(
                  children: [
                    Text(
                      Money.format(
                        value: amount,
                        symbol: currency,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: transType == 'expense'
                                ? const Color(0xffFF4439)
                                : const Color(0xff4CAF50),
                          ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          paymentTypeIcon,
                          size: 17,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          paymentType ?? '',
                          style: const TextStyle(fontSize: 8),
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
