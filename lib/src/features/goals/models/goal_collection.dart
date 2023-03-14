import 'package:isar/isar.dart';

part 'goal_collection.g.dart';

@collection
class GoalsCollection {
  String? name;
  double? amount;
  double? savedAmount;
  String? description;
  DateTime? setOn;
  DateTime? desiredDate;
  String? category;
  String? imageUrl;
  bool? reached;
  Id id;

  GoalsCollection({
    this.name,
    this.amount,
    this.savedAmount,
    this.description,
    this.setOn,
    this.desiredDate,
    this.category,
    this.reached,
    this.imageUrl,
  }) : id = Isar.autoIncrement;
}
