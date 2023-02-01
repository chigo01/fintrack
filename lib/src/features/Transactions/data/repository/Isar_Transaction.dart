// // import 'dart:async';

// // import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
// // import 'package:fintrack/src/features/Transactions/data/repository/transaction_repository.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:isar/isar.dart';

// // class TransactionServiceRepository
// //     extends AsyncNotifier<Stream<List<Transaction>>>
// //     implements TransactionRepository {
// //   @override
// //   FutureOr<Stream<List<Transaction>>> build() {
// //     return listenTransaction();
// //   }

// //   late Future<Isar> db;

// //   TransactionServiceRepository() {
// //     db = openIsar();
// //   }

// //   Future<Isar> openIsar() async {
// //     if (Isar.instanceNames.isEmpty) {
// //       return await Isar.open(
// //         [TransactionSchema],
// //       );
// //     }
// //     return Future.value(Isar.getInstance());
// //   }

// //   @override
// //   Future<void> addTransaction(Transaction transaction) async {
// //     final isar = await db;
// //     isar.writeTxn(() async {
// //       await isar.transactions.put(transaction);
// //     });
// //   }

// //   @override
// //   Future<void> deleteTransaction(int id) {
// //     // TODO: implement deleteTransaction
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<Transaction> getTransaction(int id) {
// //     // TODO: implement getTransaction
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Stream<List<Transaction>> listenTransaction() async* {
// //     final isar = await db;
// //     final query = isar.transactions.where().build();

// //     await for (final transaction in query.watch(fireImmediately: true)) {
// //       if (transaction.isNotEmpty) {
// //         yield transaction;
// //       }
// //     }
// //   }

// //   @override
// //   Future<void> updateTransaction(Transaction transaction) {
// //     // TODO: implement updateTransaction
// //     throw UnimplementedError();
// //   }

// // }

// // final transactionServiceRepositoryProvider = AsyncNotifierProvider<
// //         TransactionServiceRepository, Stream<List<Transaction>>>(
// //     TransactionServiceRepository.new); // constructor tie down

// import 'dart:async';

// import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
// import 'package:fintrack/src/features/Transactions/data/repository/transaction_repository.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class Transactions extends AsyncNotifier implements TransactionRepository {
//   @override
//   FutureOr build() {}

//   @override
//   Future<void> addTransaction(Transaction transaction) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> deleteTransaction(int id) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> getTransaction(int id) {
//     throw UnimplementedError();
//   }

//   @override
//   Stream<List<Transaction>> getTransactions() {
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> updateTransaction(Transaction transaction) {
//     throw UnimplementedError();
//   }
// }
