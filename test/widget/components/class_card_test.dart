import 'package:c317_mobile/components/class_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('ClassCard displays subject, day, and time',
      (WidgetTester tester) async {
    const subject = 'Math';
    const day = 'Monday';
    const time = '9:00 AM';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ClassCard(
            subject: subject,
            day: day,
            time: time,
          ),
        ),
      ),
    );
    final subjectText = find.text(subject);
    final dayTimeText = find.text('$day - $time');
    expect(subjectText, findsOneWidget);
    expect(dayTimeText, findsOneWidget);
  });
}