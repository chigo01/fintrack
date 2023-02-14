import 'package:fintrack/src/features/Transactions/presentation/views/transaction_entry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

StateProvider<int> currentIndex = StateProvider((ref) => 1);
final paymentName = StateProvider((ref) => 'Cash');
final incomeName = StateProvider((ref) => 'Business');

final currentCategory = StateProvider<String>((ref) => 'Shopping');

StateProvider<int> paymentCurrentIndex = StateProvider((ref) => 1);

final StateProvider<TransactionType> transactionType = StateProvider(
  (ref) => TransactionType.expense,
);
