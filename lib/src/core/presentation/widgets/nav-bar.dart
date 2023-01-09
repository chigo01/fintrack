import 'package:fintrack/src/core/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../widgets/glass_container.dart';

// ignore: must_be_immutable
class GlassMorphicNavBar extends StatefulWidget {
  GlassMorphicNavBar({
    Key? key,
    required this.theme,
    required this.currentIndex,
  }) : super(key: key);

  final ThemeMode theme;
  int currentIndex;

  @override
  State<GlassMorphicNavBar> createState() => _GlassMorphicNavBarState();
}

class _GlassMorphicNavBarState extends State<GlassMorphicNavBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GlassMorphic(
      mode: widget.theme,
      height: context.getHeight(0.07),
      width: context.getWidth(0.3),
      borderWidth: 2,
      border: BorderRadius.circular(50),
      margin: const EdgeInsets.all(15),
      borderColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            _bottomNavigationBarItems.length,
            (index) {
              bool indexCheck = index == widget.currentIndex;
              return InkWell(
                onTap: () {
                  setState(() {
                    widget.currentIndex = index;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                            bottom: indexCheck ? 12 : 0,
                            top: indexCheck ? 0 : 12),
                        child: Icon(
                          indexCheck
                              ? _bottomNavigationBarItems[index].activeIcon
                              : _bottomNavigationBarItems[index].icon,

                          color: widget.theme == ThemeMode.dark
                              ? indexCheck
                                  ? Colors.white
                                  : const Color(0xff858b92)
                              : Theme.of(context).primaryColor,
                          // size: 13.4,
                        ),
                      ),
                    ),
                    // SizedBox(height: 6),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: index == widget.currentIndex ? 6.0 : 0,
                      ),
                      child: Text(
                        indexCheck
                            ? _bottomNavigationBarItems[index].label
                            : '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: width < 400 && height < 700 ? 6 : 10,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

const _bottomNavigationBarItems = [
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
    icon: PhosphorIcons.cardholder,
    activeIcon: PhosphorIcons.cardholderFill,
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
