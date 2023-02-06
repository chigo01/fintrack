import 'package:fintrack/src/core/domain/currency.dart';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/core/widgets/textfield.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/current_page_provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExpenseTap extends StatelessWidget {
  const ExpenseTap({
    Key? key,
    required this.categoryName,
    required this.category,
    required this.theme,
    required this.ref,
    required this.themeModeCheck,
    required this.paymentIndex,
    required this.nameTextEditingController,
    required this.amountTextEditingController,
    required this.descriptionTextEditingController,
    this.onTap,
  }) : super(key: key);

  final String categoryName;
  final int category;
  final ThemeMode theme;
  final WidgetRef ref;
  final bool themeModeCheck;
  final TextEditingController nameTextEditingController;
  final TextEditingController amountTextEditingController;
  final TextEditingController? descriptionTextEditingController;
  final int paymentIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var currencySymbol = ref.watch(currencyProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: TextInput(
            hintText: 'Name of $categoryName expense',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 15,
                ),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            controller: nameTextEditingController,
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
              Column(
                children: [
                  Container(
                    height: 50,
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
                  const SizedBox(height: 40)
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextInput(
                        controller: amountTextEditingController,
                        keyboardType: TextInputType.number,
                        filled: false,
                        prefixStyle:
                            const TextStyle(fontSize: 18, color: Colors.grey),
                        hintText: '1000',
                        prefixText: currencySymbol,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: themeModeCheck
                                ? Colors.white38
                                : Colors.black38,
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
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ...currency
                              .map(
                                ((currency) => Padding(
                                      padding: EdgeInsets.only(
                                        right: context.width * 0.01,
                                      ),
                                      child: Container(
                                        height: 30,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: currencySymbol ==
                                                  currency.symbol
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                                  .primaryColor
                                                  .withOpacity(0.7),
                                        ),
                                        child: Center(
                                          child: Text(
                                            currency.symbol,
                                            style: TextStyle(
                                              color: themeModeCheck
                                                  ? null
                                                  : Colors.white,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ).onTap(() {
                                        ref
                                            .read(currencyProvider.notifier)
                                            .changeCurrency(currency.symbol);
                                      }),
                                    )),
                              )
                              .toList(),
                        ],
                      )
                    ],
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
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 15,
                    ),
                hintText: 'Description',
                filled: false,
                suffixIcon: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.1),
                  child: IconButton(
                    onPressed: onTap,
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
                controller: descriptionTextEditingController,
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
                      categoryIndex: paymentIndex,
                      theme: theme,
                      ref: ref,
                      category: paymentCategory,
                      categoryStateNotifier: paymentName,
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
