import 'package:fintrack/src/features/analysis/presentation/notifier/analysis.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final navigatesAnalysis = StateProvider((ref) => false);

final navigatesAnalysis =
    NotifierProvider<NavigateAnalysis, bool>(() => NavigateAnalysis());
