import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exp04_form_validation/main.dart';

void main() {
  test('efficiency categories', () {
    expect(efficiencyFor(3), 'Low Efficiency');
    expect(efficiencyFor(9.99), 'Low Efficiency');
    expect(efficiencyFor(10), 'Average Efficiency');
    expect(efficiencyFor(15), 'Average Efficiency');
    expect(efficiencyFor(15.01), 'Excellent Efficiency');
    expect(calculateMileage(12, 4), 3);
  });

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const CarMileageApp());
  }

  testWidgets('Empty fields show validation errors', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Calculate Mileage'));
    await tester.pump();
    expect(find.text('Please enter distance'), findsOneWidget);
    expect(find.text('Please enter fuel'), findsOneWidget);
  });

  testWidgets('Zero fuel and invalid text are rejected', (tester) async {
    await pumpApp(tester);
    await tester.enterText(find.byKey(const Key('distanceField')), 'abc');
    await tester.enterText(find.byKey(const Key('fuelField')), '0');
    await tester.tap(find.text('Calculate Mileage'));
    await tester.pump();
    expect(find.text('Enter a valid number'), findsOneWidget);
    expect(find.text('Fuel must be greater than zero'), findsOneWidget);
  });

  testWidgets('Valid input shows mileage, and Clear resets', (tester) async {
    await pumpApp(tester);
    await tester.enterText(find.byKey(const Key('distanceField')), '12');
    await tester.enterText(find.byKey(const Key('fuelField')), '4');
    await tester.tap(find.text('Calculate Mileage'));
    await tester.pump();
    expect(find.text('3.00'), findsOneWidget);
    expect(find.text('Low Efficiency'), findsOneWidget);

    await tester.tap(find.text('Clear'));
    await tester.pump();
    expect(find.text('3.00'), findsNothing);
  });
}
