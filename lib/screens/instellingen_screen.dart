import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/providers/audio_provider.dart';
import 'package:timer_app/providers/instellingen_provider.dart';

class InstellingenScreen extends StatefulWidget {
  const InstellingenScreen({super.key});

  @override
  State<InstellingenScreen> createState() => _InstellingenScreenState();
}

class _InstellingenScreenState extends State<InstellingenScreen> {
  final List<String> voices = ['Bart', 'Sofia', 'Fenna'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WASTimer instellingen')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Welke stem?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  SizedBox.square(dimension: 14),

              padding: const EdgeInsets.all(12),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: voices.length,
              itemBuilder: (BuildContext ctx, int idx) =>
                  VoiceCard(voice: voices[idx]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('klaar')],
        ),
      ),
    );
  }
}

class VoiceCard extends StatelessWidget {
  final String voice;
  final AudioPlayer _player = AudioPlayer();

  VoiceCard({super.key, required this.voice});

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<InstellingenProvider>(context);
    final audioProvider = Provider.of<AudioProvider>(context);
    final bool playing =
        audioProvider.playing && audioProvider.currentlyPlayer == voice;

    return GestureDetector(
      onTap: () => preferences.voice = voice,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.woman,
              size: 50,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            preferences.voice == voice ? Icon(Icons.check) : Text(''),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(voice, style: Theme.of(context).textTheme.headlineSmall),
                Text(
                  'Allemaal dingen',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),

            IconButton(
              icon: playing
                  ? Icon(Icons.pause, size: 50, color: Colors.purple[200])
                  : Icon(
                      Icons.play_circle_outline,
                      size: 50,
                      color: Colors.purple[200],
                    ),
              onPressed: () {
                if (playing) {
                  audioProvider.stop();
                } else {
                  audioProvider.currentlyPlaying = voice;
                  audioProvider.playDemo(preferences.voice);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
