import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tonevault/main.dart';
import 'package:tonevault/retro.dart';

const fieldLabels = [
  'Tone Name',
  'Artist / Song',
  'Guitar / Pickup',
  'Amplifier Settings',
  'Pedal Settings',
  'Notes',
];

void main() {
  testWidgets('ASCII stage respects reduced motion and compact layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: AsciiSignal(),
        ),
      ),
    );
    final stage = find.byKey(const ValueKey('ascii-stage'));
    final frame = tester.widget<Text>(stage).data;
    await tester.pump(const Duration(seconds: 2));
    expect(tester.widget<Text>(stage).data, frame);
    await tester.pumpWidget(
      const MaterialApp(
        home: SizedBox(
          height: 300,
          child: RetroScaffold(
            appBar: PreferredSize(preferredSize: Size.zero, child: SizedBox()),
            body: Text('Content stays visible'),
          ),
        ),
      ),
    );
    // A small viewport gets the compact signal strip.
    await tester.binding.setSurfaceSize(const Size(320, 400));
    await tester.pumpAndSettle();
    expect(stage, findsNothing);
    expect(find.text('Content stays visible'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets(
    'retro banner animates and empty media explains what is missing',
    (tester) async {
      await tester.pumpWidget(const ToneVaultApp());
      expect(
        tester
            .widget<MaterialApp>(find.byType(MaterialApp))
            .debugShowCheckedModeBanner,
        isFalse,
      );
      final signal = find.textContaining('[ TONEVAULT / SIGNAL ARCHIVE ]');
      final stage = find.byKey(const ValueKey('ascii-stage'));
      final firstStage = tester.widget<Text>(stage).data;
      final firstFrame = tester.widget<Text>(signal).data;
      await tester.pump(const Duration(milliseconds: 550));
      expect(tester.widget<Text>(signal).data, isNot(firstFrame));
      expect(tester.widget<Text>(stage).data, isNot(firstStage));
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Enter Sandman'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Play Tone Recording'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Play Tone Recording'));
      await tester.pumpAndSettle();
      expect(
        find.text('This tone has no saved audio recording.'),
        findsOneWidget,
      );
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('View Equipment Photo'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('View Equipment Photo'));
      await tester.pumpAndSettle();
      expect(
        find.text('This tone has no saved equipment photo.'),
        findsOneWidget,
      );
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SizedBox());
    },
  );

  testWidgets('edit, recreate, and delete a saved tone', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToneLibraryScreen()));
    await tester.tap(find.text('Enter Sandman'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Edit Tone'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
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
      final field = find.widgetWithText(TextField, fieldLabels[i]);
      await tester.scrollUntilVisible(
        field,
        120,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(field).controller!.text, original[i]);
      await tester.enterText(field, updated[i]);
    }
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save Tone'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save Tone'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).first, const Offset(0, 1000));
    await tester.pumpAndSettle();
    for (final value in updated.skip(1)) {
      await tester.scrollUntilVisible(
        find.text(value),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(find.text(value), findsOneWidget);
    }
    await tester.scrollUntilVisible(
      find.text('Recreate Tone'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
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
    await tester.scrollUntilVisible(
      find.text('Edit Tone'),
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit Tone'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Unsaved change');
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Unsaved change'), findsNothing);

    await tester.scrollUntilVisible(
      find.text('Delete Tone'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
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
      final field = find.widgetWithText(TextField, fieldLabels[i]);
      await tester.scrollUntilVisible(
        field,
        120,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.enterText(field, values[i]);
    }
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Save Tone'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save Tone'));
    await tester.pumpAndSettle();
    expect(find.text('My tone'), findsOneWidget);

    await tester.tap(find.text('My tone'));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).first, const Offset(0, 1000));
    await tester.pumpAndSettle();
    for (final value in values.skip(1)) {
      await tester.scrollUntilVisible(
        find.text(value),
        100,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
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
    await tester.scrollUntilVisible(
      find.text('Save Tone'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
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
