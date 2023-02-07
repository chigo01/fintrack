// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fintrack/src/core/theme/app_color.dart';
import 'package:flutter/material.dart';


class PopMenuItems {
  final String name;
  final IconData iconName;

  final Color? color;

  const PopMenuItems({
    required this.name,
    required this.iconName,
    this.color,
  });

  @override
  bool operator ==(Object other) {
    return other is PopMenuItems &&
        other.name == name &&
        other.iconName == iconName &&
        other.color == color;
  }

  @override
  int get hashCode => Object.hash(name, iconName, color);
}

List<PopMenuItems> popMenuItems = [
  const PopMenuItems(
    name: 'profile',
    iconName: Icons.person_outline,
    color: Colors.white,
  ),
  const PopMenuItems(
    name: 'Notifications',
    iconName: Icons.notifications_outlined,
    color: Colors.white,
  ),
  const PopMenuItems(
    name: 'LightMode',
    iconName: Icons.light_mode_outlined,
    color: Colors.white,
  ),
  // const PopMenuItems(
  //   name: 'settings',
  //   iconName: Icons.settings_outlined,
  // ),
  PopMenuItems(
    name: 'Logout',
    iconName: Icons.login_outlined,
    color: AppColor.secondaryColors[3],
  ),
];
