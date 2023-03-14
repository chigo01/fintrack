import 'package:fintrack/src/core/utils/isar.dart';
import 'package:fintrack/src/features/goals/models/goal_collection.dart';
import 'package:isar/isar.dart';

import 'goals_repository.dart';

class GoalsIsarServiceRepository implements GoalsRepository {
  // late Future<Isar> db;
  final db = IsarSingleton();

  @override
  Future<void> addGoal(GoalsCollection goals) async {
    final isar = await db.instance;
    isar.writeTxn(() async {
      await isar.goalsCollections.put(goals);
    });
  }

  @override
  Stream<List<GoalsCollection>> getAllGoals() async* {
    final isar = await db.instance;
    final allGoals = isar.goalsCollections
        .where(sort: Sort.desc)
        .sortBySetOnDesc()
        .watch(fireImmediately: true);
    yield* allGoals;
  }

  @override
  Stream<List<GoalsCollection>> getRecentTransactions() {
    // TODO: implement getRecentTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransaction(GoalsCollection goals, int id) {
    // TODO: implement updateTransaction
    throw UnimplementedError();
  }
}
