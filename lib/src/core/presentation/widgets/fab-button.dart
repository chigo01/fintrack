import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/theme/app_color.dart';
import 'package:fintrack/src/features/Transactions/presentation/views/transaction_entry.dart';
import 'package:fintrack/src/features/Transactions/theme.dart';
import 'package:fintrack/src/features/goals/presentation/views/choose_goal.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FabButton extends StatelessWidget {
  const FabButton({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeMode theme;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    bool fabSize = width > 300 || (height >= 640 || height <= 860);
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return FabCircularMenu(
      alignment: Alignment.bottomCenter,
      ringDiameter: 300,
      ringColor:
          Theme.of(context).primaryColor.withOpacity(.5), //themeCheck.color,
      ringWidth: 100,
      fabOpenIcon: const Icon(Icons.add, color: AppColor.white),
      fabCloseIcon: const Icon(Icons.close, color: AppColor.white),
      fabColor: Theme.of(context).primaryColor,
      fabMargin: EdgeInsets.only(
        // bottom: bottomHeight ? 30 : (bottomHeight2 ? 54 : 23),
        // right: bottomHeight ? 27 : 27,
        bottom: devicePixelRatio >= 3
            ? (devicePixelRatio >= 3.5 &&
                    aspectRatio >= 0.43 &&
                    aspectRatio <= 0.5)
                ? 40
                : 69
            : (devicePixelRatio <= 2.9 && devicePixelRatio > 2 ? 30 : 54),
        right: 27,
      ),
      fabSize: fabSize ? 50 : 60,
      children: [
        FabChildren(
          children: [
            FabWidget(
              color: const Color(0xff05aa6d),
              icon: PhosphorIcons.exportLight,
              onTap: () => context.push(const AddTransactionsScreen()),
            ),
            Text(
              'Transactions',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 9, color: AppColor.white),
              maxLines: 1,
            )
          ],
        ),
        FabChildren(children: [
          FabWidget(
            color: const Color(0XFF7d42ca),
            icon: PhosphorIcons.chalkboardSimple,
            onTap: (() {
              context.push(const ChooseGoalScreen());
              // context.maybePop();
            }),
          ),
          Text(
            'Goals',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: 9, color: AppColor.white),
            maxLines: 1,
          )
        ]),
        FabChildren(
          children: [
            FabWidget(
              color: const Color(0xffFF6B07),
              icon: PhosphorIcons.notePencil,
              onTap: (() {
                context.push(const LightMode());
              }),
            ),
            Text(
              'Notes',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 9, color: AppColor.white),
              maxLines: 1,
            )
          ],
        ),
      ],
    );
  }
}

class FabChildren extends StatelessWidget {
  const FabChildren({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        children: children,
      ),
    );
  }
}

class FabWidget extends StatelessWidget {
  const FabWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 25,
              color: Colors.white,
            )),
      ),
    );
  }
}
