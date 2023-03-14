import 'dart:io';

import "package:collection/collection.dart";
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/utils/animation.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/widgets/asyncvalue.dart';
import 'package:fintrack/src/features/goals/data/repository/notifiers/provider.dart';
import 'package:fintrack/src/features/goals/models/goal.dat.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AllGoalsScreen extends StatefulHookConsumerWidget {
  const AllGoalsScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllGoalsScreenState();
}

class _AllGoalsScreenState extends ConsumerState<AllGoalsScreen> {
  double value = 0.0;
  @override
  Widget build(BuildContext context) {
    final themeModeChecker = ref.watch(themeProvider) == ThemeMode.dark;
    final goal = ref
        .watch(getAllGoal)
        .valueOrNull
        ?.map(
          (e) => useLinearProgress(
            (e.savedAmount ?? 0.0) / (e.amount ?? 0.0) * 100,
          ).value,
        )
        .toList();

    Color color(double width) {
      if (width < 50) {
        return Colors.red;
      } else if (width < 80) {
        return Colors.orange;
      } else {
        return Colors.green;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('All Goals'),
        ),
        body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final allGoals = ref.watch(getAllGoal);
            if (allGoals.valueOrNull != null &&
                allGoals.valueOrNull!.isNotEmpty) {
              return AsyncValueWidgets(
                  value: allGoals,
                  data: (data) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final elementAt = data.elementAt(index);
                          final category = goals.singleWhereOrNull((element) =>
                              element.name == data[index].category);
                          final double maxWidth =
                              goal![index].isNaN ? 12 : goal[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: PhysicalModel(
                              color: themeModeChecker
                                  ? Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1)
                                  : Colors.white,
                              elevation: themeModeChecker ? 5.4 : 10,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: context.height * 0.16,
                                width: context.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.file(
                                        File(elementAt.imageUrl ?? ''),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        width: context.width * 0.6,
                                        height: double.infinity,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 20),
                                              Text(
                                                elementAt.name ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge
                                                    ?.copyWith(
                                                      fontSize: 16,
                                                    ),
                                              ),
                                              Text(
                                                'Set On : ${DateFormat.yMMMMd().format(elementAt.setOn!)}',
                                                style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Amount : ${elementAt.amount}',
                                                style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: SizedBox(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: context
                                                                  .getWidth(),
                                                              maxHeight: 5,
                                                            ),
                                                            // width: context.getWidth(),
                                                            // height: 14,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[300],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          Container(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  maxWidth,
                                                              maxHeight: 5,
                                                            ),
                                                            // width:
                                                            // height: 14,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color(
                                                                  maxWidth),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      ' ${goal[index].isNaN ? 0 : goal[index].toStringAsFixed(2)} %',
                                                      style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 30,
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {},
                                      icon: const Icon(
                                        PhosphorIcons.checkCircleLight,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
            } else {
              return const Center(
                child: Text('No Transactions'),
              );
            }
          },
        ));
  }
}
