import 'package:crafty_bay/features/carts/presentation/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('orders screen shows placeholder content', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartScreen()));

    expect(find.text('Orders'), findsOneWidget);
    expect(find.text('Orders screen coming soon'), findsOneWidget);
    expect(find.byIcon(Icons.receipt_long_outlined), findsOneWidget);
  });
}