import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fintrack/src/core/utils/money.dart';
import 'package:fintrack/src/features/Transactions/presentation/provider/currency.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
    required this.income,
    required this.expense,
    required this.ref,
  });

  final double? income;
  final double? expense;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Balance',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 10,
              ),
        ),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              Money.format(
                value: (income ?? 1) - (expense ?? 1),
                symbol: ref.watch(currencyProvider),
              ),
              speed: const Duration(milliseconds: 150),
              cursor: '',
              textStyle: GoogleFonts.robotoCondensed(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          displayFullTextOnTap: true,
          stopPauseOnTap: false,
        ),
      ],
    );
  }
}
