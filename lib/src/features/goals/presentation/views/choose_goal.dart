import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/features/goals/models/goal.dat.dart';
import 'package:fintrack/src/features/goals/presentation/views/add_goal_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/presentation/provider/themechanges.dart';

class ChooseGoalScreen extends HookConsumerWidget {
  const ChooseGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeChecker = ref.watch(themeProvider) == ThemeMode.dark;
    final Color color = themeModeChecker ? Colors.white : Colors.black;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'New Goals',
            style: TextStyle(color: color),
          ),
          leading: IconButton(
            icon: Icon(
              PhosphorIcons.arrowBendUpLeft,
              color: color,
            ),
            onPressed: () => context.maybePop(),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Settings a goal is the first step towards achieving it',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Let's Set Goal",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'What are you saving For?',
                  style: TextStyle(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: GridView.builder(
                  itemCount: goals.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: goals[index].color.withOpacity(.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              goals[index].imageUrl,
                              height: 70,
                              width: 100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(goals[index].name),
                      ],
                    ).onTap(
                      () => context.pushTransition(
                        AddGoalScreen(goals: goals[index]),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
