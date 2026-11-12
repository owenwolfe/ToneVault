import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonevault/main.dart';

void main() {
  testWidgets('save a tone and open its details', (tester) async {
    await tester.pumpWidget(const ToneVaultApp());
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final values = [
      'My tone', 'My song', 'Telecaster', 'Gain 4', 'Delay 2', 'Practice',
    ];
    for (var i = 0; i < values.length; i++) {
      await tester.enterText(find.byType(TextField).at(i), values[i]);
    }
    await tester.ensureVisible(find.text('Save Tone'));
    await tester.tap(find.text('Save Tone'));
    await tester.pumpAndSettle();
    expect(find.text('My tone'), findsOneWidget);

    await tester.tap(find.text('My tone'));
    await tester.pumpAndSettle();
    for (final value in values.skip(1)) {
      expect(find.text(value), findsOneWidget);
    }
  });

  testWidgets('blank name stays on the form and back cancels', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToneLibraryScreen()));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '   ');
    await tester.ensureVisible(find.text('Save Tone'));
    await tester.tap(find.text('Save Tone'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a tone name'), findsOneWidget);
    expect(find.byType(CreateToneScreen), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNWidgets(3));
  });
}
