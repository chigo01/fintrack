import 'package:fintrack/src/core/domain/category.dart';
import 'package:fintrack/src/core/utils/extension.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final bool boolIndex;
  final Category elements;
  final int index;
  final BuildContext context;
  final ThemeMode theme;
  final int category;
  const CategoryCard({
    Key? key,
    required this.boolIndex,
    required this.elements,
    required this.index,
    required this.context,
    required this.theme,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: theme == ThemeMode.light
          ? BoxDecoration(
              color: Colors.white,
              shape: boolIndex ? BoxShape.circle : BoxShape.rectangle,

              border: boolIndex
                  ? Border.all(
                      color: elements.color == null
                          ? Theme.of(context).primaryColor
                          : elements.color!,
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
                          color: elements.color == null
                              ? Theme.of(context).primaryColor
                              : elements.color!,
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
                  child: Icon(
                    elements.icon,
                    color: elements.color == null
                        ? Theme.of(context).primaryColor
                        : elements.color!,
                  ),
                ),
                Text(
                  elements.title,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontSize: boolIndex && context.height < 700 ? 6.7 : 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
