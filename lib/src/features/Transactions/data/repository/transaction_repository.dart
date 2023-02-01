import '../../../../core/domain/models/entities/transaction_collection.dart';

abstract class TransactionRepository {
  Future<void> getTransaction(int id);
  Future<void> addTransaction(Transaction transaction);
  Stream<List<Transaction>> getTransactions();
  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
}
