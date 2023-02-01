
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum Categories {
  food,
  shopping,
  transport,
  entertainment,
  health,
  kids,
  education,
  leisure,
  clothing,
  subscription,
  technology,
  beauty,
  car,
  others,
}

class Category {
  final IconData icon;
  final String title;
  final Color? color;
  final Categories? category;

  const Category({
    required this.icon,
    required this.title,
    this.color,
    this.category,
  });

  @override
  String toString() {
    return 'Category(icon: $icon, title: $title, color: $color, category: $category)';
  }
}

List<Category> categories = [
  const Category(
    icon: PhosphorIcons.forkKnife,
    title: 'Food',
    color: Colors.red,
    category: Categories.food,
  ),
  const Category(
    icon: PhosphorIcons.shoppingCart,
    title: 'Shopping',
    color: Colors.blue,
    category: Categories.shopping,
  ),
  const Category(
    icon: PhosphorIcons.carSimple,
    title: 'Transport',
    color: Colors.green,
    category: Categories.transport,
  ),
  const Category(
    icon: PhosphorIcons.filmSlate,
    title: 'Entertainment',
    color: Colors.purple,
    category: Categories.entertainment,
  ),
  const Category(
    icon: PhosphorIcons.firstAidKit,
    title: 'Health',
    color: Colors.pink,
    category: Categories.health,
  ),
  const Category(
    icon: PhosphorIcons.student,
    title: 'Education',
    color: Colors.orange,
    category: Categories.education,
  ),
  const Category(
    icon: Icons.wc_outlined,
    title: 'Clothing',
    color: Colors.teal,
    category: Categories.clothing,
  ),
  const Category(
    icon: Icons.subscriptions_outlined,
    title: 'Subscription',
    color: Colors.indigo,
    category: Categories.subscription,
  ),
  const Category(
    icon: PhosphorIcons.laptop,
    title: 'Technology',
    color: Color.fromARGB(255, 29, 133, 198),
    category: Categories.beauty,
  ),
  const Category(
    icon: Icons.face_outlined,
    title: 'Beauty',
    color: Colors.brown,
    category: Categories.beauty,
  ),
  const Category(
    icon: PhosphorIcons.car,
    title: 'Vehicle',
    color: Colors.cyan,
    category: Categories.car,
  ),
  const Category(
    icon: PhosphorIcons.baby,
    title: 'Kids',
    color: Color.fromARGB(255, 232, 111, 12),
    category: Categories.kids,
  ),
  const Category(
    icon: PhosphorIcons.list,
    title: 'Others',
    color: Colors.grey,
    category: Categories.others,
  ),
];

List<Category> paymentCategory = [
  const Category(
    icon: PhosphorIcons.money,
    title: 'Cash',
  ),
  const Category(
    icon: PhosphorIcons.wallet,
    title: 'Wallet',
  ),
  const Category(
    icon: PhosphorIcons.creditCard,
    title: 'Card',
  ),
];

List<Category> incomeCategory = [
  const Category(
    icon: PhosphorIcons.bank,
    title: 'Salary',
  ),
  const Category(
    icon: PhosphorIcons.handshake,
    title: 'Business',
  ),
  const Category(
    icon: PhosphorIcons.archive,
    title: 'Investment',
  ),
  const Category(
    icon: PhosphorIcons.suitcase,
    title: 'Gift',
  ),
];
