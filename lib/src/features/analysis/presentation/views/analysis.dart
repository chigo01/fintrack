import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/features/analysis/presentation/views/Time_tabs/month.dart';
import 'package:fintrack/src/features/analysis/presentation/views/Time_tabs/today.dart';
import 'package:fintrack/src/features/analysis/presentation/views/Time_tabs/week.dart';
import 'package:fintrack/src/features/analysis/presentation/views/Time_tabs/year.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/app_color.dart';

List<String> categoriesDate = [
  'Today',
  'Week',
  'Month',
  'Year',
];

List<Widget> tabBody = [
  const TodayTab(),
  const WeekTab(),
  const MonthTab(),
  const YearTab()
];
final selectedIndex = StateProvider((ref) => 0);

final selectedCategoryDay = StateProvider((ref) => categoriesDate[0]);

class AnalysisScreen extends HookConsumerWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print(transaction!
    //     .where((element) => element.date.month == DateTime.february)
    //     .map((e) => e.amount)
    //     .reduce((value, element) => element + value));
    final ThemeData theme = Theme.of(context);
    final bool themeCheck = ref.watch(themeProvider) == ThemeMode.dark;
    PageController pageController = PageController();

    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: 350,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.2),
                ),
                child: Column(children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          context.maybePop();
                        },
                        icon: Icon(
                          PhosphorIcons.arrowBendUpLeft,
                          color: themeCheck ? null : theme.primaryColor,
                        ),
                      ),
                      Text(
                        'Analysis',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 20,
                          // color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          PhosphorIcons.trashSimple,
                          color: themeCheck ? null : theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            constraints: const BoxConstraints(
                                maxHeight: 50, maxWidth: 300),
                            hintStyle: theme.textTheme.bodySmall?.copyWith(
                              color: themeCheck ? null : theme.primaryColor,
                            ),
                            suffixIcon: Icon(
                              PhosphorIcons.magnifyingGlass,
                              color: theme.primaryColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: themeCheck
                                ? theme.scaffoldBackgroundColor
                                : theme.primaryColor.withOpacity(0.2),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: theme.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              PhosphorIcons.funnel,
                              size: 30,
                              color: AppColor.white,
                            ),
                          ),
                        )
                      ])
                ]),
              ),
              Positioned(
                top: 150,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: context.getHeight(0.04),
                        width: context.getWidth(0.8),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: theme.primaryColor,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          children: [
                            for (var i = 0; i < categoriesDate.length; i++)
                              Expanded(
                                child: Consumer(
                                  builder: (BuildContext context, WidgetRef ref,
                                      Widget? child) {
                                    final index = ref.watch(selectedIndex) == i;
                                    final elementAt =
                                        i == categoriesDate.length - 1;

                                    return AnimatedContainer(
                                      // clipBehavior: Clip.antiAlias,
                                      width: elementAt ? 85 : 80,

                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: index
                                            ? theme.primaryColor
                                            : theme.scaffoldBackgroundColor,
                                        border: Border(
                                          right: elementAt
                                              ? BorderSide.none
                                              : BorderSide(
                                                  width: 2,
                                                  color: theme.primaryColor,
                                                ),
                                        ),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.easeIn,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 2,
                                          left: elementAt ? 20 : 9,
                                        ),
                                        child: Center(
                                          child: Text(
                                            categoriesDate[i],
                                            // style: const TextStyle(
                                            //     color: AppColor.white),
                                          ),
                                        ),
                                      ),
                                    ).onTap(() {
                                      ref
                                          .read(selectedCategoryDay.notifier)
                                          .state = categoriesDate[i];

                                      ref.read(selectedIndex.notifier).state =
                                          i;
                                      pageController.animateToPage(i,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);
                                    });
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: context.height * 0.9,
                        width: context.width,
                        child: PageView.builder(
                          allowImplicitScrolling: true,
                          physics: const BouncingScrollPhysics(),
                          controller: pageController,
                          itemCount: tabBody.length,
                          onPageChanged: (value) =>
                              ref.read(selectedIndex.notifier).state = value,
                          itemBuilder: (context, index) => tabBody[index],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
