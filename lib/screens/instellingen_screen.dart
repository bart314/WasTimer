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
  final List<String> voices = [
    'Bart',
    'Fenna',
    'Piet',
    'Klaas',
    'Henk',
    'Dylan',
    'Rob',
    'Martin',
    'Françoise',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welke stem?')),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox.square(dimension: 14),

        padding: const EdgeInsets.all(12),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: voices.length,
        itemBuilder: (BuildContext ctx, int idx) =>
            VoiceCard(voice: voices[idx]),
      ),
    );
  }
}

class VoiceCard extends StatelessWidget {
  final String voice;

  const VoiceCard({super.key, required this.voice});

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    final instellingen = Provider.of<InstellingenProvider>(context);

    final bool playing =
        audioProvider.playing && audioProvider.currentlyPlayer == voice;

    return GestureDetector(
      onTap: () => instellingen.voice = voice,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.woman,
              size: 50,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            instellingen.voice == voice ? Icon(Icons.check) : Text(''),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(voice, style: Theme.of(context).textTheme.headlineSmall),

                  Text(
                    'Korte beschrijving van $voice met allemaal interessante dingen om lange tekst te maken',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
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
                  audioProvider.playDemo(voice);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
