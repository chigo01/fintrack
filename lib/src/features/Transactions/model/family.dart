// ignore_for_file: public_member_api_docs, sort_constructors_first
class FamilyProvider {
  int days;
  String transactionType;
  FamilyProvider({
    required this.days,
    required this.transactionType,
  });

  @override
  bool operator ==(covariant FamilyProvider other) {
    if (identical(this, other)) return true;

    return other.days == days && other.transactionType == transactionType;
  }

  @override
  int get hashCode => days.hashCode ^ transactionType.hashCode;
}
