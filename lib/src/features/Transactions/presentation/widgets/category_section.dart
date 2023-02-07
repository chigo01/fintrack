import 'dart:developer';
import 'package:fintrack/src/core/domain/models/category.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/current_page_provider.dart';
import 'package:fintrack/src/features/Transactions/presentation/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    Key? key,
    required this.category,
    required this.theme,
    required this.ref,
  }) : super(key: key);

  final int category;
  final ThemeMode theme;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.getWidth(0.05),
      ),
      height: context.getHeight(0.2),
      width: context.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: ((context, index) {
          Category elements = categories.elementAt(index);
          bool boolIndex = category == index;
          return CategoryCard(
            boolIndex: boolIndex,
            elements: elements,
            index: index,
            context: context,
            theme: theme,
            category: category,
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

class CategoryWidgets extends StatelessWidget {
  const CategoryWidgets({
    Key? key,
    required this.categoryIndex,
    required this.theme,
    required this.ref,
    required this.category,
    required this.categoryStateNotifier,
  }) : super(key: key);

  final int categoryIndex;
  final ThemeMode theme;
  final WidgetRef ref;
  final List<Category> category;
  final StateProvider<String> categoryStateNotifier;

  // final WidgetRef ref;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight(0.09),
      width: context.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: category.length,
        itemBuilder: ((context, index) {
          Category elements = category.elementAt(index);
          bool boolIndex = categoryIndex == index;
          return CategoryCard(
            boolIndex: boolIndex,
            category: categoryIndex,
            context: context,
            elements: elements,
            index: index,
            theme: theme,
          ).onTap(
            () {
              ref.read(paymentCurrentIndex.notifier).state = index;
              ref
                  .read(
                    categoryStateNotifier.notifier,
                  )
                  .update(
                    (state) => state = elements.title,
                  );

              log(elements.title.toString());
            },
          );
        }),
      ),
    );
  }
}
