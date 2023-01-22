import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrencyProvider extends StateNotifier<String> {
  CurrencyProvider() : super('\$');

  void changeCurrency(String currency) => state = currency;
}

final currencyProvider = StateNotifierProvider<CurrencyProvider, String>(
  (ref) => CurrencyProvider(),
);
