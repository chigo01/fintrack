import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/features/Transactions/data/repository/transaction_repository.dart';
import 'package:isar/isar.dart';

// DateTime date = DateTime.now();

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
  Stream<List<Transaction>> getRecentTransactions(
      String transactionType) async* {
    final isar = await db;
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

  @override
  Stream<double> totalTransaction(String transactionType) async* {
    final isar = await db;
    final query = isar.transactions
        .where()
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
  Stream<List<Transaction>> totalTransactionByDay(
      String transactionType) async* {
    final isar = await db;
    final query = isar.transactions
        .filter()
        .dateEqualTo(
          DateTime.utc(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        )
        .and()
        .transactionTypeEqualTo(transactionType, caseSensitive: false)
        .build();

    await for (final transaction in query.watch(fireImmediately: true)) {
      if (transaction.isEmpty) {
        yield [];
      } else {
        yield transaction;
      }
    }
  }

  @override
  Stream<List<Transaction>> getAllTransactions(String transactionType) async* {
    final isar = await db;
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
