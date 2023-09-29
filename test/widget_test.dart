// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:oriontek_test/screens/home.dart';

void main() {
  testWidgets('MyHomePage has a title and shows progress indicator',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: MyHomePage(title: 'Home'),
    ));

    // Verify that our widget has a title.
    expect(find.text('Home'), findsOneWidget);

    // Verify that our widget shows a progress indicator.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
