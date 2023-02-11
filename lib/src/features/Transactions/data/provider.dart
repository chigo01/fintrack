import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/features/Transactions/model/family.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'repository/isar_service.dart';

final addTransaction = FutureProvider.autoDispose
    .family<void, Transaction>((ref, transaction) async {
  final isarService = IsarServiceRepository();
  return await isarService.addTransaction(transaction);
});

final getTransactions = StreamProvider.autoDispose
    .family<List<Transaction>, String>((ref, transactionType) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.getRecentTransactions(transactionType);
});

final getTransactions2 = StreamProvider.autoDispose
    .family<List<Transaction>, String>((ref, transactionType) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.getAllTransactions(transactionType);
});

final totalTransactions = StreamProvider.autoDispose
    .family<double, String>((ref, transactionType) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.totalTransaction(transactionType);
});

final totalTransactionsByDay =
    StreamProvider.family<double, DateTime>((ref, date) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.totalTransactionByDay(
    date,
  );
});
