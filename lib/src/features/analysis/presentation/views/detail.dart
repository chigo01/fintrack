import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:flutter/material.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(transaction.name),
        ),
      ),
    );
  }
}
