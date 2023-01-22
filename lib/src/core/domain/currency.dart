// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrencyEntities {
  final String locale;
  final String symbol;
  final int decimalDigits;
  CurrencyEntities({
    required this.locale,
    required this.symbol,
    this.decimalDigits = 2,
  });

  CurrencyEntities copyWith({
    String? locale,
    String? symbol,
    int? decimalDigits,
  }) {
    return CurrencyEntities(
      locale: locale ?? this.locale,
      symbol: symbol ?? this.symbol,
      decimalDigits: decimalDigits ?? this.decimalDigits,
    );
  }

  @override
  bool operator ==(covariant CurrencyEntities other) {
    if (identical(this, other)) return true;

    return other.locale == locale &&
        other.symbol == symbol &&
        other.decimalDigits == decimalDigits;
  }

  @override
  int get hashCode =>
      locale.hashCode ^ symbol.hashCode ^ decimalDigits.hashCode;

  @override
  String toString() =>
      'CurrencyEntities(locale: $locale, symbol: $symbol, decimalDigits: $decimalDigits)';
}

List<CurrencyEntities> currency = [
  CurrencyEntities(
    locale: 'en_US',
    symbol: '\$',
  ),
  CurrencyEntities(
    locale: 'en_IE',
    symbol: '€',
  ),
  CurrencyEntities(
    locale: 'en_NG',
    symbol: '₦',
  ),
];
