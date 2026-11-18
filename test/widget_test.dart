import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonevault/main.dart';

void main() {
  testWidgets('retro banner animates and empty media explains what is missing', (tester) async {
    await tester.pumpWidget(const ToneVaultApp());
    expect(tester.widget<MaterialApp>(find.byType(MaterialApp)).debugShowCheckedModeBanner, isFalse);
    final signal = find.textContaining('[ TONEVAULT / SIGNAL ARCHIVE ]');
    final firstFrame = tester.widget<Text>(signal).data;
    await tester.pump(const Duration(milliseconds: 550));
    expect(tester.widget<Text>(signal).data, isNot(firstFrame));
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Enter Sandman'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Play Tone Recording'), 200,
        scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Play Tone Recording'));
    await tester.pumpAndSettle();
    expect(find.text('This tone has no saved audio recording.'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('View Equipment Photo'), 200,
        scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('View Equipment Photo'));
    await tester.pumpAndSettle();
    expect(find.text('This tone has no saved equipment photo.'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('edit, recreate, and delete a saved tone', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToneLibraryScreen()));
    await tester.tap(find.text('Enter Sandman'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit Tone'));
    await tester.pumpAndSettle();

    final original = [
      'Enter Sandman',
      'Metallica',
      'ESP - Bridge Pickup',
      'Gain: 7  Bass: 6  Mid: 4  Treble: 7',
      'Overdrive - Gain: 3  Level: 8',
      'Heavy rhythm tone',
    ];
    final updated = [
      'Updated tone',
      'Updated artist',
      'Telecaster',
      'Gain 5',
      'Delay 3',
      'Updated notes',
    ];
    for (var i = 0; i < original.length; i++) {
      final field = find.byType(TextField).at(i);
      expect(tester.widget<TextField>(field).controller!.text, original[i]);
      await tester.enterText(field, updated[i]);
    }
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Save Tone'), 200, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save Tone'));
    await tester.pumpAndSettle();
    for (final value in updated.skip(1)) {
      expect(find.text(value), findsOneWidget);
    }
    await tester.scrollUntilVisible(find.text('Recreate Tone'), 200, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Recreate Tone'));
    await tester.pumpAndSettle();
    expect(find.text('Updated tone'), findsOneWidget);
    expect(find.text('Gain 5'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Updated tone'), findsOneWidget);
    expect(find.text('Updated artist'), findsOneWidget);
    expect(find.text('Enter Sandman'), findsNothing);

    await tester.tap(find.text('Updated tone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit Tone'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Unsaved change');
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Unsaved change'), findsNothing);

    await tester.scrollUntilVisible(find.text('Delete Tone'), 200, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Tone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(ToneDetailsScreen), findsOneWidget);
    await tester.tap(find.text('Delete Tone'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.byType(ToneLibraryScreen), findsOneWidget);
    expect(find.text('Updated tone'), findsNothing);
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('save a tone and open its details', (tester) async {
    await tester.pumpWidget(const ToneVaultApp());
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    final values = [
      'My tone',
      'My song',
      'Telecaster',
      'Gain 4',
      'Delay 2',
      'Practice',
    ];
    for (var i = 0; i < values.length; i++) {
      await tester.enterText(find.byType(TextField).at(i), values[i]);
    }
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Save Tone'), 200, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
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
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Save Tone'), 200, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save Tone'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a tone name'), findsOneWidget);
    expect(find.byType(CreateToneScreen), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNWidgets(3));
  });
}
