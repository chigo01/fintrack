import 'package:fintrack/src/features/goals/models/goal_collection.dart';

abstract class GoalsRepository {
  Future<void> addGoal(GoalsCollection goals);
  Stream<List<GoalsCollection>> getRecentTransactions();
  Stream<List<GoalsCollection>> getAllGoals();
  // Stream<double> totalTransaction(String transactionType);

  Future<void> updateTransaction(GoalsCollection goals, int id);
//  Future<void> deleteTransaction(int id);
}
