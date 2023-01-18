// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/widgets/textfield.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/current_page_provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/datatime_format.dart';
import 'package:fintrack/src/core/utils/extension.dart';

enum TransactionType {
  expense,
  income,
}

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
    final paymentIndex = ref.watch(paymentCurrentIndex);
    final payment = ref.watch(paymentName);
    final themeModeCheck = theme == ThemeMode.dark;
    final currentTransactionType = ref.watch(transactionType);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
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
                        ...List.generate(
                          TransactionType.values.length,
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
                                ),
                              ),
                            ).onTap(
                              () {
                                ref.read(transactionType.notifier).state =
                                    TransactionType.values[index];
                              },
                            );
                          },
                        )
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
                        ExpenseTap(
                          categoryName: categoryName,
                          category: category,
                          theme: theme,
                          ref: ref,
                          themeModeCheck: themeModeCheck,
                          textEditingController: _textEditingController,
                          paymentIndex: paymentIndex,
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
    );
  }
}

class ExpenseTap extends StatelessWidget {
  const ExpenseTap({
    Key? key,
    required this.categoryName,
    required this.category,
    required this.theme,
    required this.ref,
    required this.themeModeCheck,
    required TextEditingController textEditingController,
    required this.paymentIndex,
  })  : _textEditingController = textEditingController,
        super(key: key);

  final String categoryName;
  final int category;
  final ThemeMode theme;
  final WidgetRef ref;
  final bool themeModeCheck;
  final TextEditingController _textEditingController;
  final int paymentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextInput(
            hintText: 'Name of $categoryName expense',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  fontSize: 15,
                ),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(40),
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
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        CategoriesSection(
          category: category,
          theme: theme,
          ref: ref,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            children: [
              Container(
                height: 45,
                width: 115,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor),
                child: Center(
                  child: Text(
                    'Amount',
                    style: TextStyle(
                      color: themeModeCheck ? null : Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextInput(
                    // key:
                    keyboardType: TextInputType.number,

                    filled: false,
                    hintText: '1000',

                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: themeModeCheck ? Colors.white38 : Colors.black38,
                      ),
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    constraints: const BoxConstraints(
                      maxHeight: 60,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        10,
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              TextInput(
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: 15,
                    ),
                hintText: 'Description',
                filled: false,
                suffixIcon: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: IconButton(
                    onPressed: (() {}),
                    icon: Icon(
                      PhosphorIcons.camera,
                      size: 20,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: themeModeCheck ? Colors.white38 : Colors.black38,
              ),
              Padding(
                padding: EdgeInsets.only(left: context.width / 1.49),
                child: const Text(
                  'Add Bill image',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Payment Mode ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width * 0.12),
                    child: CategoryWidgets(
                      category: paymentIndex,
                      theme: theme,
                      ref: ref,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
