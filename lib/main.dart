import 'package:flutter/material.dart';

void main() {
  runApp(const ToneVaultApp());
}

class ToneVaultApp extends StatelessWidget {
  const ToneVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToneVault',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToneVault'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.music_note, size: 80),
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
              onPressed: () {},
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}

class ToneLibraryScreen extends StatelessWidget {
  const ToneLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Enter Sandman'),
            subtitle: const Text('Metallica - Distortion'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ToneDetailsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Clean Tone'),
            subtitle: const Text('Stratocaster - Clean'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Blues Lead'),
            subtitle: const Text('Les Paul - Overdrive'),
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateToneScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateToneScreen extends StatelessWidget {
  const CreateToneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Tone'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Tone Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Artist / Song',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Guitar / Pickup',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Amplifier Settings',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Pedal Settings',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            label: const Text('Take Equipment Photo'),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mic),
            label: const Text('Record Tone'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Save Tone'),
          ),
        ],
      ),
    );
  }
}

class ToneDetailsScreen extends StatelessWidget {
  const ToneDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Sandman'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Enter Sandman',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text('Metallica'),
          const Divider(),
          const ListTile(
            title: Text('Guitar'),
            subtitle: Text('ESP - Bridge Pickup'),
          ),
          const ListTile(
            title: Text('Amplifier'),
            subtitle: Text('Gain: 7  Bass: 6  Mid: 4  Treble: 7'),
          ),
          const ListTile(
            title: Text('Pedals'),
            subtitle: Text('Overdrive - Gain: 3  Level: 8'),
          ),
          const ListTile(
            title: Text('Notes'),
            subtitle: Text('Heavy rhythm tone'),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow),
            label: const Text('Play Tone Recording'),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.photo),
            label: const Text('View Equipment Photo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecreationScreen(),
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
    return Scaffold(
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
  const RecreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recreate Tone'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Enter Sandman',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: ListTile(
              title: Text('Guitar'),
              subtitle: Text('ESP - Bridge Pickup'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Amplifier'),
              subtitle: Text(
                'Gain: 7\nBass: 6\nMid: 4\nTreble: 7\nVolume: 5',
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('Overdrive Pedal'),
              subtitle: Text(
                'Gain: 3\nTone: 6\nLevel: 8',
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.photo),
              title: Text('Equipment Photo'),
              subtitle: Text('Tap to view saved knob positions'),
            ),
          ),
        ],
      ),
    );
  }
}
