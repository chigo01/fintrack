import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/features/goals/models/goal_collection.dart';
import 'package:isar/isar.dart';

class IsarSingleton {
  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TransactionSchema, GoalsCollectionSchema],
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<Isar> get instance => openIsar();
}
