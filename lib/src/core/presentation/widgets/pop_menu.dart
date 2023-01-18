import 'package:fintrack/src/core/domain/pop_menu_items.dart';
import 'package:fintrack/src/core/presentation/provider/themechanges.dart';
import 'package:fintrack/src/core/route/route_navigations.dart';

import 'package:fintrack/src/features/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopMenuWidget extends StatefulWidget {
  const PopMenuWidget({
    Key? key,
    required this.ref,
    required this.theme,
  }) : super(key: key);

  final WidgetRef ref;
  final ThemeMode theme;

  @override
  State<PopMenuWidget> createState() => _PopMenuWidgetState();
}

class _PopMenuWidgetState extends State<PopMenuWidget> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final pref = await SharedPreferences.getInstance();
    final themeMode = pref.getBool('darkMode') ?? false;
    widget.ref.read(themeProvider.notifier).changeMode(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopMenuItems>(
      onSelected: (PopMenuItems value) {
        switch (value.name) {
          case 'profile':
            context.pushTransition(const Profile());
            break;
          case 'Notifications':
            break;

          case 'LightMode':
            readTheme(widget.ref, widget.theme);
            break;
        }
      },
      constraints: const BoxConstraints(maxHeight: 245, maxWidth: 190),
      color: Theme.of(context).primaryColor.withOpacity(0.3),
      tooltip: "Profile Menu",
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
          image: const DecorationImage(
            image: AssetImage(
              "assets/images/profile.jpg",
            ),
          ),
        ),
      ),
      itemBuilder: (context) {
        return List.generate(popMenuItems.length, (index) {
          final indexAt = popMenuItems.elementAt(2);
          return popItems(
            index: index,
            indexAt: indexAt,
            context: context,
            ref: widget.ref,
          );
        });
      },
    );
  }
}

PopupMenuItem<PopMenuItems> popItems({
  required int index,
  required PopMenuItems indexAt,
  required BuildContext context,
  required WidgetRef ref,
}) {
  final watchTheme = ref.watch(themeProvider);
  final bool themeChecker = watchTheme == ThemeMode.dark;
  return PopupMenuItem(
    value: popMenuItems[index],
    child: Row(
      children: [
        Icon(
          indexAt == popMenuItems[index]
              ? (themeChecker
                  ? popMenuItems[index].iconName
                  : Icons.dark_mode_outlined)
              : popMenuItems[index].iconName,
          color: themeChecker
              ? (index == 3 ? popMenuItems[index].color : Colors.white)
              : popMenuItems[index].color,
          size: 17,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 32,
          ),
          child: Text(
            indexAt == popMenuItems[index]
                ? (themeChecker ? popMenuItems[index].name : 'Dark Mode')
                : popMenuItems[index].name,
            style: themeChecker
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

void readTheme(WidgetRef ref, ThemeMode theme) {
  ref.read(themeProvider.notifier).toggleMode(mode: theme);
}
