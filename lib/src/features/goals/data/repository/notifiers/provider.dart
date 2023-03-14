import 'dart:async';

import 'package:fintrack/src/features/goals/data/repository/isar_service.dart';
import 'package:fintrack/src/features/goals/models/goal_collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final goalsRepositoryProvider = Provider<GoalsIsarServiceRepository>((ref) {
  return GoalsIsarServiceRepository();
});

class GoalsNotifier extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {}
  final goalsRepository = GoalsIsarServiceRepository();

  Future<void> addGoals(GoalsCollection goals) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => goalsRepository.addGoal(goals),
    );
  }
  // Future<void> addGoals(GoalsCollection goals) async {
  //   final isarService = GoalsIsarServiceRepository();
  //   return isarService.addTransaction(goals);
  // }
}

class GoalsStreamNotifier extends StreamNotifier<List<GoalsCollection>> {
  @override
  Stream<List<GoalsCollection>> build() {
    // TODO: implement build
    final goals = ref.watch(goalsRepositoryProvider);
    return goals.getAllGoals();
  }
}

final goalsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<GoalsNotifier, void>(
  () => GoalsNotifier(),
);

final getAllGoal =
    StreamNotifierProvider<GoalsStreamNotifier, List<GoalsCollection>>(
  () => GoalsStreamNotifier(),
);
