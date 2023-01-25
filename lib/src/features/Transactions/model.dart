class Expense {
  String category;
  double amount;

  Expense({required this.category, required this.amount});
}

List<Expense> expenses = [
  Expense(category: "Food", amount: 50.0),
  Expense(category: "Transportation", amount: 20.0),
  Expense(category: "Food", amount: 30.0),
  Expense(category: "Entertainment", amount: 40.0),
];

String targetCategory = "Food";

int count =
    expenses.where((expense) => expense.category == targetCategory).length;

void main() {
  // print(
  //     "The category $targetCategory appears $count times in the expenses list.");

  final total = expenses.length;

  final categories = expenses.map((e) => e.category).toList();

  for (String category in categories) {
    int occurrences =
        expenses.where((expense) => expense.category == category).length;
    double percentage = (occurrences / total) * 100;
    print(
        "The category '$category' has a $percentage% occurrence in the expenses list.");
  }
}
