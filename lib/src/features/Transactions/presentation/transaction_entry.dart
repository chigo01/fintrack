import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/domain/category.dart';
import 'package:fintrack/src/core/presentation/controllers/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/background-dec.dart';
import 'package:fintrack/src/core/utils/datatime_format.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

StateProvider<int> currentIndex = StateProvider((ref) => 1);
StateProvider<String> currentCategory = StateProvider((ref) => 'Shopping');

class AddTransactionsScreen extends ConsumerStatefulWidget {
  const AddTransactionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends ConsumerState<AddTransactionsScreen> {
  DateTime date = DateTime.now();
  DateTimeFormatter format = DateTimeFormatter();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final category = ref.watch(currentIndex);
    final categoris = ref.watch(currentCategory);
    Category cat;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: theme == ThemeMode.dark
            ? backgroundColor()
            : const BoxDecoration(color: Colors.white),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Add Transaction',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              leading: IconButton(
                onPressed: () {
                  context.maybePop();
                },
                icon: Icon(
                  PhosphorIcons.arrowBendUpLeft,
                  color: theme == ThemeMode.light ? Colors.black : null,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              'Date: ${format.dateToString(date)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 10,
                                  ),
                            ),
                            AutoSizeText(
                              'Time:  ${format.timeToString(date)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 10,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 25,
                        ),
                        child: Text(
                          'Category',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w100,
                                color: const Color.fromARGB(255, 212, 209, 209),
                              ),
                        ),
                      ),
                      Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: (() {}),
                            icon: Icon(
                              PhosphorIcons.arrowCircleLeftLight,
                              size: 30,
                              color: theme == ThemeMode.light
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                          ),
                          SizedBox(
                              height: context.getHeight(0.09),
                              width: context.width * 0.7,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: categories.length,
                                itemBuilder: ((context, index) {
                                  Category elements =
                                      categories.elementAt(index);
                                  bool boolIndex = category == index;
                                  return Container(
                                    decoration: theme == ThemeMode.light
                                        ? BoxDecoration(
                                            color: Colors.white,
                                            shape: boolIndex
                                                ? BoxShape.circle
                                                : BoxShape.rectangle,

                                            border: boolIndex
                                                ? Border.all(
                                                    color: elements.color!,
                                                    width: 1,
                                                  )
                                                : null,
                                            boxShadow: boolIndex
                                                ? [
                                                    const BoxShadow(
                                                      color: Color(0xFFA7A9AF),
                                                      blurRadius: 5,
                                                      offset: Offset.zero,
                                                    ),
                                                  ]
                                                : null,

                                            // borderRadius: BorderRadius.circular(5),
                                          )
                                        : category == index
                                            ? BoxDecoration(
                                                shape: boolIndex
                                                    ? BoxShape.circle
                                                    : BoxShape.rectangle,
                                                border: boolIndex
                                                    ? Border.all(
                                                        color: elements.color!,
                                                        width: 1,
                                                      )
                                                    : null,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xff130F1A),
                                                    offset: Offset(0, 0),
                                                    blurRadius: 10,
                                                  ),
                                                ],
                                              )
                                            : null,
                                    width: 80,
                                    height: 100,
                                    // color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: elements.color
                                                      ?.withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Icon(elements.icon,
                                                    color: elements.color),
                                              ),
                                              Text(
                                                elements.title,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    ?.copyWith(fontSize: 8),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ).onTap(() {
                                    ref.read(currentIndex.notifier).state =
                                        index;

                                    // ref.read(categoris);

                                    print(categoris);
                                  });
                                }),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: (() {}),
                            icon: Icon(
                              PhosphorIcons.arrowCircleRightLight,
                              size: 30,
                              color: theme == ThemeMode.light
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
