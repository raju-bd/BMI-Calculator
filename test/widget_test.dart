import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bmi_calculator/main.dart';

void main() {
  testWidgets('BMI Calculator loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BmiCalculatorApp());

    // Verify that the app title is displayed.
    expect(find.text('BMI Calculator'), findsOneWidget);

    // Verify that the calculate button is present.
    expect(find.text('Calculate BMI'), findsOneWidget);

    // Verify that the reset button is NOT present before calculation.
    expect(find.text('Reset'), findsNothing);

    // Verify that the instructional text is displayed initially.
    expect(
      find.text('Enter your height and weight\nto calculate your BMI.'),
      findsOneWidget,
    );
  });

  testWidgets('Input fields accept numeric values', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiCalculatorApp());

    // Find the weight and height fields
    final weightField = find.byType(TextFormField).at(0);
    final heightField = find.byType(TextFormField).at(1);

    // Enter weight and height
    await tester.enterText(weightField, '70');
    await tester.enterText(heightField, '170');

    // Tap calculate button
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    // Verify that the BMI result is displayed with 2 decimal places
    expect(find.text('24.22'), findsOneWidget);
    expect(find.text('Normal Weight'), findsOneWidget);

    // Verify that reset button appears after calculation
    expect(find.text('Reset'), findsOneWidget);
  });

  testWidgets('Validation prevents empty inputs', (WidgetTester tester) async {
    await tester.pumpWidget(const BmiCalculatorApp());

    // Tap calculate without entering anything
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    // Verify validation error messages appear
    expect(find.text('Please enter your weight.'), findsOneWidget);
  });
}
