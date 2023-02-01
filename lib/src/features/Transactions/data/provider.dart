import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'repository/isar_service.dart';

final addTransaction = FutureProvider.autoDispose
    .family<void, Transaction>((ref, transaction) async {
  final isarService = IsarServiceRepository();
  return await isarService.addTransaction(transaction);
});

final getTransactions =
    StreamProvider.autoDispose<List<Transaction>>((ref) async* {
  final isarService = IsarServiceRepository();
  yield* isarService.getTransactions();
});
