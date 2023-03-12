import 'package:flutter/material.dart';

class GoalsList {
  final String name;
  final String imageUrl;
  final Color color;

  GoalsList({
    required this.name,
    required this.imageUrl,
    required this.color,
  });
}

List<GoalsList> goals = [
  GoalsList(
      name: 'Buy a home',
      imageUrl: 'assets/images/home.png',
      color: Colors.red),
  GoalsList(
      name: 'Buy a car',
      imageUrl: 'assets/images/Car.png',
      color: Colors.greenAccent),
  GoalsList(
      name: 'Plan a vacation',
      imageUrl: 'assets/images/vacation.png',
      color: Colors.blueAccent),
  GoalsList(
      name: 'Charity',
      imageUrl: 'assets/images/charity.png',
      color: Colors.yellowAccent),
  GoalsList(
      name: 'Payoff debt',
      imageUrl: 'assets/images/debt.png',
      color: Colors.purpleAccent),
  GoalsList(
      name: 'Education',
      imageUrl: 'assets/images/education.png',
      color: Colors.orangeAccent),
];
