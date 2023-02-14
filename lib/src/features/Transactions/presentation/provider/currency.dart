import 'package:hooks_riverpod/hooks_riverpod.dart';

class CurrencyProvider extends StateNotifier<String> {
  CurrencyProvider() : super('\$');

  void changeCurrency(String currency) => state = currency;
}

final currencyProvider = StateNotifierProvider<CurrencyProvider, String>(
  (ref) => CurrencyProvider(),
);
