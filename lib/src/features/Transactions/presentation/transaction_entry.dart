import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/domain/category.dart';
import 'package:fintrack/src/core/presentation/controllers/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/theme/app_color.dart';
import 'package:fintrack/src/core/utils/datatime_format.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

final category = Provider(
  (ref) => categories[1],
);
StateProvider<int> currentIndex = StateProvider(
  (ref) => 1,
);

final currentCategory = StateProvider<String>(
  (ref) => ref.watch(
    category.select(
      (value) => value.title,
    ),
  ),
);

final StateProvider<TransactionType> transactionType = StateProvider(
  (ref) => TransactionType.income,
);

enum TransactionType { income, expense }

class AddTransactionsScreen extends ConsumerStatefulWidget {
  const AddTransactionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends ConsumerState<AddTransactionsScreen> {
  DateTime date = DateTime.now();
  DateTimeFormatter format = DateTimeFormatter();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final category = ref.watch(currentIndex);
    final categoryName = ref.watch(currentCategory);
    final themeModeCheck = theme == ThemeMode.dark;
    final currentTransactionType = ref.watch(transactionType);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: Container(
        // decoration: themeModeCheck
        //     ? backgroundColor()
        //     : const BoxDecoration(color: Colors.white),
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
                  color: themeModeCheck ? null : Colors.black,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...List.generate(TransactionType.values.length,
                              (index) {
                            bool selectedTransaction = currentTransactionType ==
                                TransactionType.values[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                  height: 45,
                                  width: 115,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: selectedTransaction
                                        ? Theme.of(context)
                                            .primaryColor //Theme.of(context).primaryColor
                                        : null,
                                    border: Border.all(
                                      color: selectedTransaction
                                          ? Colors.transparent
                                          : const Color(0xff508cf3),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      TransactionType
                                          .values[index].name.capitalized,
                                      style: TextStyle(
                                        color: themeModeCheck
                                            ? null
                                            : selectedTransaction
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  )),
                            ).onTap(
                              () {
                                ref.read(transactionType.notifier).state =
                                    TransactionType.values[index];
                              },
                            );
                          })
                        ],
                      ),
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 5),
                      IndexedStack(
                        index: currentTransactionType.index,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: TextFormField(
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                        fontSize: 15,
                                      ),
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  ),
                                ),
                              ),
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
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.getWidth(0.05),
                                ),
                                height: context.getHeight(0.2),
                                width: context.width,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                  ),
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
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
                                                        color:
                                                            Color(0xFFA7A9AF),
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
                                                          color:
                                                              elements.color!,
                                                          width: 1,
                                                        )
                                                      : null,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor
                                                          .primaryColor
                                                          .withOpacity(
                                                              0.1), //Color(0xff130F1A),
                                                      offset:
                                                          const Offset(0, 0),
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
                                                        BorderRadius.circular(
                                                            5),
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
                                                      ?.copyWith(
                                                        fontSize: boolIndex &&
                                                                context.height <
                                                                    700
                                                            ? 6.7
                                                            : 8,
                                                      ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).onTap(
                                      () {
                                        ref.read(currentIndex.notifier).state =
                                            index;
                                        ref
                                            .read(
                                              currentCategory.notifier,
                                            )
                                            .update(
                                              (state) => state = elements.title,
                                            );
                                      },
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 45,
                                      width: 115,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Center(
                                        child: Text(
                                          'Amount',
                                          style: TextStyle(
                                            color: themeModeCheck
                                                ? null
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            filled: false,
                                            hintText: '1000',
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontSize: 15,
                                                ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: themeModeCheck
                                                    ? Colors.white38
                                                    : Colors.black38,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            constraints: const BoxConstraints(
                                                maxHeight: 60),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _textEditingController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          ?.copyWith(
                                            fontSize: 15,
                                          ),
                                      decoration: InputDecoration(
                                        hintText: 'Description',
                                        filled: false,
                                        suffixIcon: CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: IconButton(
                                            onPressed: (() {}),
                                            icon: const Icon(
                                              PhosphorIcons.camera,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 15,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: themeModeCheck
                                          ? Colors.white38
                                          : Colors.black38,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 230.0),
                                      child: Text(
                                        'Add Bill image',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 8,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(),
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

class CategoryWidgets extends StatelessWidget {
  const CategoryWidgets({
    Key? key,
    required ScrollController scrollController,
    required this.category,
    required this.theme,
    required this.ref,
    required this.textEditingController,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final int category;
  final ThemeMode theme;
  final WidgetRef ref;
  final TextEditingController textEditingController;

  // final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(0.09),
      width: context.width * 0.7,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: ((context, index) {
          Category elements = categories.elementAt(index);
          bool boolIndex = category == index;
          return Container(
            decoration: theme == ThemeMode.light
                ? BoxDecoration(
                    color: Colors.white,
                    shape: boolIndex ? BoxShape.circle : BoxShape.rectangle,

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
                        shape: boolIndex ? BoxShape.circle : BoxShape.rectangle,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 25,
                        width: 30,
                        decoration: BoxDecoration(
                          color: elements.color?.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Icon(elements.icon, color: elements.color),
                      ),
                      Text(
                        elements.title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              fontSize:
                                  boolIndex && context.height < 700 ? 6.7 : 8,
                            ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ).onTap(
            () {
              ref.read(currentIndex.notifier).state = index;
              ref
                  .read(
                    currentCategory.notifier,
                  )
                  .update(
                    (state) => state = elements.title,
                  );
            },
          );
        }),
      ),
    );
  }
}
