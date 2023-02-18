import '../../../../core/domain/models/entities/transaction_collection.dart';

abstract class TransactionRepository {
  Future<void> getTransaction(int id);
  Future<void> addTransaction(Transaction transaction);
  Stream<List<Transaction>> getRecentTransactions(String transactionType);
  Stream<List<Transaction>> getAllTransactions(String transactionType);
  Stream<double> totalTransaction(String transactionType);


  Future<void> updateTransaction(Transaction transaction);
  Future<void> deleteTransaction(int id);
}
