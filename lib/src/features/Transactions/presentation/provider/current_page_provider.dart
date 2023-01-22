import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/features/Transactions/presentation/transaction_entry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final category = Provider(
  (ref) => categories[1],
);
StateProvider<int> currentIndex = StateProvider((ref) => 1);
final paymentName = StateProvider((ref) => 'Cash');
final incomeName = StateProvider((ref) => 'Business');

final currentCategory = StateProvider<String>(
  (ref) => ref.watch(
    category.select(
      (value) => value.title,
    ),
  ),
);

StateProvider<int> paymentCurrentIndex = StateProvider((ref) => 1);

final StateProvider<TransactionType> transactionType = StateProvider(
  (ref) => TransactionType.expense,
);
