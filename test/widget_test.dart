import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pomodoro_focus_flow1/core/app.dart';

void main() {
  testWidgets('App builds and shows FocusFlow title', (WidgetTester tester) async {
    // Uygulamayı çalıştır
    await tester.pumpWidget(const FocusFlowApp());

    // Ana başlık görünüyor mu?
    expect(find.text('FocusFlow'), findsOneWidget);

    // Timer text'i ilk buildte herhangi bir şey gösteriyor mu (örneğin 25:00 vs.)
    // Burada çok katı olmadan, sadece bir Text widget’i olmasını kontrol edelim:
    expect(find.byType(Text), findsWidgets);
  });
}
