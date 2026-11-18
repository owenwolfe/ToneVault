import 'dart:async';

import 'package:flutter/material.dart';

ThemeData retroTheme() {
  const ink = Color(0xFF202020);
  const paper = Color(0xFFE8E8E8);
  const border = BorderSide(color: ink, width: 2);
  const square = RoundedRectangleBorder(side: border);
  return ThemeData(
    useMaterial3: false,
    fontFamily: 'monospace',
    scaffoldBackgroundColor: paper,
    colorScheme: const ColorScheme.light(
      primary: ink,
      onPrimary: Colors.white,
      secondary: Color(0xFF555555),
      onSecondary: Colors.white,
      surface: paper,
      onSurface: ink,
      error: Color(0xFF444444),
      onError: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ink,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'monospace',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFCECECE),
        foregroundColor: ink,
        elevation: 3,
        shadowColor: Colors.black,
        shape: square,
        minimumSize: const Size(48, 46),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ink,
        shape: square,
        minimumSize: const Size(48, 44),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ink,
      foregroundColor: Colors.white,
      shape: square,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.zero),
      enabledBorder: OutlineInputBorder(borderSide: border),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ink, width: 3),
      ),
      floatingLabelStyle: TextStyle(color: ink),
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: square,
      margin: EdgeInsets.symmetric(vertical: 6),
    ),
    listTileTheme: const ListTileThemeData(
      shape: Border(bottom: BorderSide(color: Color(0xFF999999))),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),
    dialogTheme: const DialogThemeData(shape: square, backgroundColor: paper),
    dividerTheme: const DividerThemeData(color: ink, thickness: 1),
  );
}

void showNotice(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class RetroScaffold extends StatelessWidget {
  const RetroScaffold({
    super.key,
    required this.appBar,
    required this.body,
    this.floatingActionButton,
    this.stageLabel = 'LIVE AT TONEVAULT',
  });

  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final String stageLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AsciiSignal(
                    stageLabel: stageLabel,
                    showStage: constraints.maxHeight >= 500,
                  ),
                  Expanded(child: body),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AsciiSignal extends StatefulWidget {
  const AsciiSignal({
    super.key,
    this.stageLabel = 'LIVE AT TONEVAULT',
    this.showStage = true,
  });

  final String stageLabel;
  final bool showStage;

  @override
  State<AsciiSignal> createState() => _AsciiSignalState();
}

class _AsciiSignalState extends State<AsciiSignal> {
  Timer? timer;
  int frame = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    timer?.cancel();
    if (!MediaQuery.disableAnimationsOf(context)) {
      timer = Timer.periodic(const Duration(milliseconds: 550), (_) {
        if (mounted && TickerMode.valuesOf(context).enabled) {
          setState(() => frame = (frame + 1) % 4);
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Equal-width frames keep the stage still while the player and notes move.
  static const stageFrames = [
    r'    __           _     _          O         '
        '\n'
        r'   |==|         | |___| |        /|\  __    '
        '\n'
        r'   |--|         |_______|       / |==/==/   '
        '\n'
        r'  /|  |\        @       @        / \        '
        '\n'
        r' (  ()  )     .  .  .  .        _/   \_     '
        '\n'
        r'  \____/     ----------------  ----------   ',
    r'    __          _     _           O   .     '
        '\n'
        r'   |==|        | |___| |         /|\  __    '
        '\n'
        r'   |--|        |_______|        / |==\==\   '
        '\n'
        r'  /|  |\       @       @         / \        '
        '\n'
        r' (  ()  )      .  .  .  .       _/   \_     '
        '\n'
        r'  \____/     ----------------  ----------   ',
    r'    __           _     _         \O/        '
        '\n'
        r'   |==|         | |___| |          |   __   '
        '\n'
        r'   |--|         |_______|       .  |==/==/  '
        '\n'
        r'  /|  |\        @       @        / \        '
        '\n'
        r' (  ()  )     .  .  .  .        _/   \_     '
        '\n'
        r'  \____/     ----------------  ----------   ',
    r'    __            _     _          O        '
        '\n'
        r'   |==|          | |___| |        /|\  __   '
        '\n'
        r'   |--|          |_______|       / |==\==\  '
        '\n'
        r'  /|  |\         @       @     .  / \       '
        '\n'
        r' (  ()  )      .  .  .  .        _/   \_    '
        '\n'
        r'  \____/     ----------------  ----------   ',
  ];

  @override
  Widget build(BuildContext context) {
    const signals = [
      '__/|__ /||/ __/|__ /||/',
      '_/||/ __/|__ /||/ __/|',
      '/||/ __/|__ /||/ __/|_',
      '||/ __/|__ /||/ __/|__',
    ];
    return Semantics(
      label: 'ToneVault. Your personal tone archive. Decorative guitar stage.',
      child: ExcludeSemantics(
        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF202020),
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: const [
              BoxShadow(color: Color(0xFF999999), offset: Offset(4, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  '[ TONEVAULT / SIGNAL ARCHIVE ]\n'
                  '${signals[frame]}   [ LOCAL ]\n'
                  'SAVE. TWEAK. PLUG IN. REPEAT.',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.5,
                    letterSpacing: 1,
                  ),
                ),
              ),
              if (widget.showStage) ...[
                const Divider(color: Color(0xFF777777), height: 16),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    stageFrames[frame],
                    key: const ValueKey('ascii-stage'),
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFFDDDDDD),
                      fontSize: 11,
                      height: 1.15,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '[ ${widget.stageLabel} ]',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 9,
                    letterSpacing: 1,
                    color: Color(0xFFBBBBBB),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
