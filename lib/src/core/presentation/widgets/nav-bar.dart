import 'package:fintrack/src/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/glass_container.dart';

class GlassMorphicNavBar extends StatelessWidget {
  const GlassMorphicNavBar({
    Key? key,
    required this.theme,
    required this.currentIndex,
    required this.unchanged,
  }) : super(key: key);

  final ThemeMode theme;
  final int currentIndex;
  final ValueChanged<int> unchanged;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GlassMorphic(
      mode: theme,
      height: context.getHeight(0.07),
      width: context.getWidth(0.3),
      borderWidth: 2,
      border: BorderRadius.circular(50),
      margin: const EdgeInsets.all(15),
      borderColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            _bottomNavigationBarItems.length,
            (index) {
              bool indexCheck = index == currentIndex;
              _Item elementAt = _bottomNavigationBarItems[index];
              return InkWell(
                onTap: () => unchanged(index),
                child: Padding(
                  padding: const EdgeInsets.only(right: 25, left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.decelerate,
                          padding: EdgeInsets.only(
                            bottom: indexCheck ? 12 : 0,
                            top: indexCheck ? 0 : 12,
                            left: indexCheck ? 0 : 3,
                          ),
                          child: Icon(
                            indexCheck ? elementAt.activeIcon : elementAt.icon,

                            color: theme == ThemeMode.dark
                                ? indexCheck
                                    ? const Color(0xff508cf3)
                                    : const Color(0xff858b92)
                                : Theme.of(context).primaryColor,
                            // size: 13.4,
                          ),
                        ),
                      ),
                      // SizedBox(height: 6),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: index == currentIndex ? 6.0 : 0,
                        ),
                        child: Text(
                          indexCheck ? elementAt.label : '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: width < 400 && height < 700 ? 6 : 10,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

const List<_Item> _bottomNavigationBarItems = [
  _Item(
    'Home',
    icon: PhosphorIcons.house,
    activeIcon: PhosphorIcons.houseFill,
  ),
  _Item(
    'Analysis',
    icon: PhosphorIcons.chartBar,
    activeIcon: PhosphorIcons.chartBarFill,
  ),
  _Item(
    'budgets',
    icon: PhosphorIcons.walletLight,
    activeIcon: PhosphorIcons.walletFill,
  ),
  _Item(
    'Notes',
    icon: PhosphorIcons.note,
    activeIcon: PhosphorIcons.noteFill,
  ),
];

class _Item {
  final String label;
  final IconData icon, activeIcon;
  const _Item(this.label, {required this.icon, required this.activeIcon});
}
