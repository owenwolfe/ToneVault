import 'package:flutter/material.dart';

import 'retro.dart';

void main() {
  runApp(const ToneVaultApp());
}

class ToneVaultApp extends StatelessWidget {
  const ToneVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToneVault',
      debugShowCheckedModeBanner: false,
      theme: retroTheme(),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RetroScaffold(
      stageLabel: 'BACKSTAGE / WELCOME',
      appBar: AppBar(
        title: const Text('ToneVault'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('TONE / VAULT',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 3)),
            const SizedBox(height: 8),
            const Text('YOUR SOUND. ON FILE.'),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ToneLibraryScreen(),
                  ),
                );
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => showNotice(context, 'Local demo',
                'Accounts are not connected yet. Tap Login to explore your local tone library.'),
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class Tone {
  const Tone({
    required this.name,
    this.artist = '',
    this.guitar = '',
    this.ampSettings = '',
    this.pedalSettings = '',
    this.notes = '',
  });

  final String name;
  final String artist;
  final String guitar;
  final String ampSettings;
  final String pedalSettings;
  final String notes;
}

class ToneLibraryScreen extends StatefulWidget {
  const ToneLibraryScreen({super.key});

  @override
  State<ToneLibraryScreen> createState() => _ToneLibraryScreenState();
}

class _ToneLibraryScreenState extends State<ToneLibraryScreen> {
  // The library owns the tones; forms return values and details use callbacks.
  // Kept in memory for now.
  final List<Tone> tones = [
    const Tone(
      name: 'Enter Sandman',
      artist: 'Metallica',
      guitar: 'ESP - Bridge Pickup',
      ampSettings: 'Gain: 7  Bass: 6  Mid: 4  Treble: 7',
      pedalSettings: 'Overdrive - Gain: 3  Level: 8',
      notes: 'Heavy rhythm tone',
    ),
    const Tone(name: 'Clean Tone', guitar: 'Stratocaster'),
    const Tone(name: 'Blues Lead', guitar: 'Les Paul'),
  ];

  @override
  Widget build(BuildContext context) {
    return RetroScaffold(
      stageLabel: 'THE RECORD CRATE',
      appBar: AppBar(
        title: const Text('My Tones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: tones.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  '[ ARCHIVE EMPTY ]\n\nTap + to save your first tone.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
        itemCount: tones.length,
        itemBuilder: (context, index) {
          final tone = tones[index];
          return ListTile(
            tileColor: Colors.white,
            leading: const Icon(Icons.music_note),
            trailing: const Icon(Icons.chevron_right),
            title: Text(tone.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(tone.artist.isEmpty ? tone.guitar : tone.artist),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ToneDetailsScreen(
                    tone: tone,
                    onChanged: (updatedTone) {
                      setState(() => tones[index] = updatedTone);
                    },
                    onDeleted: () {
                      setState(() => tones.removeAt(index));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // get the saved tone back from the form
          final tone = await Navigator.push<Tone>(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateToneScreen(),
            ),
          );
          if (!mounted || tone == null) return;
          setState(() => tones.add(tone));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateToneScreen extends StatefulWidget {
  const CreateToneScreen({super.key, this.tone});

  final Tone? tone;

  @override
  State<CreateToneScreen> createState() => _CreateToneScreenState();
}

class _CreateToneScreenState extends State<CreateToneScreen> {
  final name = TextEditingController();
  final artist = TextEditingController();
  final guitar = TextEditingController();
  final ampSettings = TextEditingController();
  final pedalSettings = TextEditingController();
  final notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    final tone = widget.tone;
    if (tone == null) return;
    name.text = tone.name;
    artist.text = tone.artist;
    guitar.text = tone.guitar;
    ampSettings.text = tone.ampSettings;
    pedalSettings.text = tone.pedalSettings;
    notes.text = tone.notes;
  }

  @override
  void dispose() {
    name.dispose();
    artist.dispose();
    guitar.dispose();
    ampSettings.dispose();
    pedalSettings.dispose();
    notes.dispose();
    super.dispose();
  }

  void saveTone() {
    if (name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a tone name')),
      );
      return;
    }
    Navigator.pop(
      context,
      Tone(
        name: name.text.trim(),
        artist: artist.text.trim(),
        guitar: guitar.text.trim(),
        ampSettings: ampSettings.text.trim(),
        pedalSettings: pedalSettings.text.trim(),
        notes: notes.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RetroScaffold(
      stageLabel: 'SOUNDCHECK / DIAL IT IN',
      appBar: AppBar(
        title: Text(widget.tone == null ? 'Create Tone' : 'Edit Tone'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
              labelText: 'Tone Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: artist,
            decoration: const InputDecoration(
              labelText: 'Artist / Song',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: guitar,
            decoration: const InputDecoration(
              labelText: 'Guitar / Pickup',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: ampSettings,
            decoration: const InputDecoration(
              labelText: 'Amplifier Settings',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: pedalSettings,
            decoration: const InputDecoration(
              labelText: 'Pedal Settings',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: notes,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => showNotice(context, 'Camera unavailable',
              'Equipment photo capture is not available yet. You can save your settings as text.'),
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Equipment Photo'),
          ),
          ElevatedButton.icon(
            onPressed: () => showNotice(context, 'Recording unavailable',
              'Audio recording is not available yet. You can describe your tone in Notes.'),
            icon: const Icon(Icons.mic),
            label: const Text('Record Tone'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveTone,
            child: const Text('Save Tone'),
          ),
        ],
      ),
    );
  }
}

class ToneDetailsScreen extends StatefulWidget {
  const ToneDetailsScreen({
    super.key,
    required this.tone,
    required this.onChanged,
    required this.onDeleted,
  });

  final Tone tone;
  final ValueChanged<Tone> onChanged;
  final VoidCallback onDeleted;

  @override
  State<ToneDetailsScreen> createState() => _ToneDetailsScreenState();
}

class _ToneDetailsScreenState extends State<ToneDetailsScreen> {
  late Tone tone;

  @override
  void initState() {
    super.initState();
    tone = widget.tone;
  }

  Future<void> editTone() async {
    final updatedTone = await Navigator.push<Tone>(
      context,
      MaterialPageRoute(builder: (context) => CreateToneScreen(tone: tone)),
    );
    if (!mounted || updatedTone == null) return;
    widget.onChanged(updatedTone);
    setState(() => tone = updatedTone);
  }

  Future<void> deleteTone() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Tone?'),
        content: Text('Delete "${tone.name}" from your library?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    widget.onDeleted();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return RetroScaffold(
      stageLabel: 'ON THE SETLIST',
      appBar: AppBar(
        title: Text(tone.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            tone.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(tone.artist),
          const Divider(),
          ListTile(
            title: const Text('Guitar'),
            subtitle: Text(tone.guitar),
          ),
          ListTile(
            title: const Text('Amplifier'),
            subtitle: Text(tone.ampSettings),
          ),
          ListTile(
            title: const Text('Pedals'),
            subtitle: Text(tone.pedalSettings),
          ),
          ListTile(
            title: const Text('Notes'),
            subtitle: Text(tone.notes),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: editTone,
            icon: const Icon(Icons.edit),
            label: const Text('Edit Tone'),
          ),
          ElevatedButton.icon(
            onPressed: deleteTone,
            icon: const Icon(Icons.delete),
            label: const Text('Delete Tone'),
          ),
          ElevatedButton.icon(
            onPressed: () => showNotice(context, 'No recording',
              'This tone has no saved audio recording.'),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play Tone Recording'),
          ),
          ElevatedButton.icon(
            onPressed: () => showNotice(context, 'No equipment photo',
              'This tone has no saved equipment photo.'),
            icon: const Icon(Icons.photo),
            label: const Text('View Equipment Photo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecreationScreen(tone: tone),
                ),
              );
            },
            child: const Text('Recreate Tone'),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RetroScaffold(
      stageLabel: 'TUNE THE FREQUENCY',
      appBar: AppBar(
        title: const Text('Search Tones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Clean',
                  child: Text('Clean'),
                ),
                DropdownMenuItem(
                  value: 'Overdrive',
                  child: Text('Overdrive'),
                ),
                DropdownMenuItem(
                  value: 'Distortion',
                  child: Text('Distortion'),
                ),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.music_note),
              title: Text('Enter Sandman'),
              subtitle: Text('Metallica - Distortion'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecreationScreen extends StatelessWidget {
  const RecreationScreen({super.key, required this.tone});

  final Tone tone;

  @override
  Widget build(BuildContext context) {
    return RetroScaffold(
      stageLabel: 'PLUG IN / PLAY IT BACK',
      appBar: AppBar(
        title: const Text('Recreate Tone'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            tone.name,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              title: const Text('Guitar'),
              subtitle: Text(tone.guitar),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Amplifier'),
              subtitle: Text(
                tone.ampSettings,
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Overdrive Pedal'),
              subtitle: Text(
                tone.pedalSettings,
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () => showNotice(context, 'No equipment photo',
                'This tone has no saved equipment photo.'),
              leading: const Icon(Icons.photo),
              title: const Text('Equipment Photo'),
              subtitle: const Text('No photo attached'),
            ),
          ),
        ],
      ),
    );
  }
}
