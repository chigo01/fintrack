import 'package:isar/isar.dart';

part 'transaction_collection.g.dart';

@collection
class Transaction {
  Id id;
  String name;
  double amount;
  String category;
  DateTime date;
  String? description;
  String transactionType;
  String? paymentType;
  String? imageUrl;

  Transaction({
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
    this.description,
    required this.transactionType,
    this.paymentType,
    this.imageUrl,
  }) : id = Isar.autoIncrement;


}
