import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/utils/isar.dart';
import 'package:fintrack/src/features/Transactions/data/repository/transaction_repository.dart';
import 'package:isar/isar.dart';

// DateTime date = DateTime.now();

class IsarServiceRepository implements TransactionRepository {
  // late Future<Isar> db;
  final db = IsarSingleton();

  @override
  Stream<List<Transaction>> getRecentTransactions(
      String transactionType) async* {
    final isar = await db.instance;
    final query = isar.transactions
        .where(sort: Sort.desc)
        .filter()
        .transactionTypeEqualTo(transactionType, caseSensitive: false)
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
    final isar = await db.instance;
    isar.writeTxn(() async {
      await isar.transactions.put(transaction);
    });
  }

  @override
  Future<void> deleteTransaction(int id) async {
    final isar = await db.instance;
    isar.writeTxn(() async {
      await isar.transactions.delete(id);
    });
  }

  @override
  Future<void> getTransaction(int id) {
    // TODO: implement getTransaction
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(Transaction transaction, int id) async {
    final isar = await db.instance;
    final transactionId = isar.transactions;

    isar.writeTxn(() async {
      final transactions = await transactionId.get(id);
      transactions!
        ..amount = transaction.amount
        ..date = transaction.date
        ..description = transaction.description
        ..transactionType = transaction.transactionType
        ..imageUrl = transaction.imageUrl
        ..name = transaction.name
        ..paymentType = transaction.paymentType
        ..category = transaction.category;

      await transactionId.put(transactions);
    });
  }

  @override
  Stream<double> totalTransaction(String transactionType) async* {
    final isar = await db.instance;
    final query = isar.transactions
        .filter()
        .transactionTypeEqualTo(
          transactionType,
          caseSensitive: false,
        )
        .amountProperty()
        .build();
    await for (final transaction in query.watch(fireImmediately: true)) {
      if (transaction.isEmpty) {
        yield 0.0;
      } else {
        final result = transaction.reduce((value, element) => value + element);
        yield result;
      }
    }
  }

  @override
  Stream<List<Transaction>> getAllTransactions(String transactionType) async* {
    final isar = await db.instance;
    final query = isar.transactions
        .where(sort: Sort.desc)
        .filter()
        .transactionTypeEqualTo(transactionType, caseSensitive: false)
        .sortByDateDesc()
        .build();
    await for (final transaction in query.watch(fireImmediately: true)) {
      if (transaction.isNotEmpty) {
        yield transaction;
      }
    }
  }
}
