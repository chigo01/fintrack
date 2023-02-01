import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/features/Transactions/data/repository/transaction_repository.dart';
import 'package:isar/isar.dart';

class IsarServiceRepository implements TransactionRepository {
  late Future<Isar> db;

  IsarServiceRepository() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TransactionSchema],
      );
    }
    return Future.value(Isar.getInstance());
  }

  @override
  Stream<List<Transaction>> getTransactions() async* {
    final isar = await db;
    final query = isar.transactions
        .where(sort: Sort.desc)
        .sortByDateDesc()
        .limit(5)
        .build();
    await for (final transaction in query.watch(fireImmediately: true)) {
      if (transaction.isNotEmpty) {
        yield transaction;
      }
    }
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final isar = await db;
    isar.writeTxn(() async {
      await isar.transactions.put(transaction);
    });
  }

  @override
  Future<void> deleteTransaction(int id) {
    // TODO: implement deleteTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> getTransaction(int id) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
