import 'dart:async';

import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
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

final getAllTransactions = StreamProvider.autoDispose
    .family<List<Transaction>, String>((ref, transactionType) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.getAllTransactions(transactionType);
});

final totalTransactions = StreamProvider.autoDispose
    .family<double, String>((ref, transactionType) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.totalTransaction(transactionType);
});
final deleteTransactions = FutureProviderFamily<void, int>((ref, id) {
  final isarService = IsarServiceRepository();
  return isarService.deleteTransaction(id);
});

// final updateTransactions = FutureProviderFamily<void, Transaction>((ref, id) {
//   final isarService = IsarServiceRepository();
//   return isarService.updateTransaction(id);
// });

class UpdateTransaction extends AsyncNotifier {
  @override
  FutureOr build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> updateTransactions(Transaction transaction, int id) {
    final isarService = IsarServiceRepository();
    return isarService.updateTransaction(transaction, id);
  }
}

final updateTransaction = AsyncNotifierProvider(
  () => UpdateTransaction(),
);
