// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fintrack/src/core/domain/models/entities/transaction_collection.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';
import 'package:fintrack/src/core/utils/cam.dart';
import 'package:fintrack/src/core/utils/datatime_format.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/utils/snackbar.dart';
import 'package:fintrack/src/core/widgets/category_widget.dart';
import 'package:fintrack/src/features/Transactions/data/provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/current_page_provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/tabs/expense_tab.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/tabs/income_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/utils/enum.dart';

//final imagePath = StateProvider<String?>((ref) => null);

class AddTransactionsScreen extends StatefulHookConsumerWidget {
  const AddTransactionsScreen({
    super.key,
    this.isNav,
    this.name,
    this.amount,
    this.description,
    this.payMent,
    String? transactionType,
    this.categoryTransactionName,
    this.date,
    this.id,
    this.imagePath,
  }) : _transactionType = transactionType;

  final bool? isNav;
  final String? name;
  final String? amount;
  final String? description;
  final DateTime? date;
  final String? categoryTransactionName;
  final String? _transactionType;
  final String? payMent;
  final int? id;
  final String? imagePath;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddTransactionsScreenState();
}

class _AddTransactionsScreenState extends ConsumerState<AddTransactionsScreen> {
  DateTime date = DateTime.now();
  DateTimeFormatter format = DateTimeFormatter();
  // final ScrollController _scrollController = ScrollController();
  void pickedImage() {
    getImage(ref);
  }

  @override
  void initState() {
    super.initState();
    ref.read(currentIndex);
    ref.read(currentCategory);
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final category = ref.watch(currentIndex);
    final categoryName = ref.watch(currentCategory);
    final paymentIndex = ref.watch(paymentCurrentIndex);
    final incomeCategory = ref.watch(incomeName);
    final payment = ref.watch(paymentName);
    final themeModeCheck = theme == ThemeMode.dark;
    final currentTransactionType = ref.watch(transactionType);
    final nameController = useTextEditingController();
    final amountController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final imageUrl = ref.watch(imagePath);
    final isNavigated = widget.isNav == true;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            bool currentTransaction =
                currentTransactionType == TransactionType.expense;

            return Container(
              // padding: EdgeInsets.only(bottom: context.width * 0.02),
              height: 60,
              color: Colors.transparent,
              child: Column(
                children: [
                  Icon(
                    PhosphorIcons.checkSquare,
                    color: Theme.of(context).primaryColor,
                  ),
                  const Text(
                    'Save',
                    style: TextStyle(fontSize: 8),
                  )
                ],
              ),
            ).onTap(() {
              widget.isNav == true
                  ? ref.read(updateTransaction.notifier).updateTransactions(
                        Transaction(
                          name: nameController.text.isEmpty
                              ? widget.name!
                              : nameController.text,
                          amount: amountController.text.trim().isEmpty
                              ? widget.amount!.toDouble
                              : amountController.text.toDouble,
                          date: widget.date!,
                          category: currentTransaction
                              ? categoryName
                              : incomeCategory,
                          transactionType: currentTransactionType.name,
                          description: descriptionController.text.isEmpty
                              ? widget.description
                              : descriptionController.text,
                          imageUrl: imageUrl ?? widget.imagePath,
                          paymentType: currentTransaction ? payment : null,
                        ),
                        widget.id ?? 0,
                      )
                  : ref
                      .read(
                        addTransaction(
                          Transaction(
                            name: nameController.text,
                            amount: amountController.text.trim().toDouble,
                            date: date,
                            category: currentTransaction
                                ? categoryName
                                : incomeCategory,
                            transactionType: currentTransactionType.name,
                            description: descriptionController.text,
                            imageUrl: imageUrl,
                            paymentType: currentTransaction ? payment : null,
                          ),
                        ).future,
                      )
                      .then((value) => showSnackBar(
                          context, 'Transaction Added Successfully'));

              context.maybePop().then((value) => showSnackBar(
                  context,
                  widget.isNav == true
                      ? 'Transaction Edited Successfully'
                      : 'Transaction Added Successfully'));

              log('saved');
              log(imageUrl.toString());
            });
          },
        ),
      ),
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          SliverAppBar(
            title: Text(
              widget.isNav == true ? 'Edit Transaction' : 'Add Transaction',
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
                    CategoryIndexWidget(
                      currentTransactionType: currentTransactionType,
                      themeModeCheck: themeModeCheck,
                      ref: ref,
                      transactionType: transactionType,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            'Date: ${format.dateToString(
                              widget.isNav != null ? widget.date! : date,
                            )}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 10,
                                ),
                          ),
                          AutoSizeText(
                            'Time:  ${format.timeToString(
                              widget.isNav != null ? widget.date! : date,
                            )}',
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
                          paymentIndex: paymentIndex,
                          nameTextEditingController: nameController,
                          amountTextEditingController: amountController,
                          descriptionTextEditingController:
                              descriptionController,
                          onTap: pickedImage,
                          name: isNavigated ? widget.name : null,
                          amount: isNavigated ? widget.amount : null,
                          description: isNavigated ? widget.description : null,
                          isNav: isNavigated ? widget.isNav : null,
                          categoryTransactionName:
                              widget.categoryTransactionName,
                          payMethod: isNavigated ? widget.payMent : null,
                          transactionType: currentTransactionType.name,
                        ),
                        IncomeTab(
                          categoryName: categoryName,
                          categoryIndex: category,
                          theme: theme,
                          ref: ref,
                          themeModeCheck: themeModeCheck,
                          paymentIndex: paymentIndex,
                          nameTextEditingController: nameController,
                          amountTextEditingController: amountController,
                          descriptionTextEditingController:
                              descriptionController,
                          onTap: pickedImage,
                          name: isNavigated ? widget.name : null,
                          amount: isNavigated ? widget.amount : null,
                          description: isNavigated ? widget.description : null,
                          categoryTransactionName:
                              widget.categoryTransactionName,
                          isNav: isNavigated ? widget.isNav : null,
                          // transactionType: currentTransactionType.name,
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
    );
  }
}
