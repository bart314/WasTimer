import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    );
  }
}

class VoiceCard extends StatelessWidget {
  final String voice;

  const VoiceCard({super.key, required this.voice});

  @override
  Widget build(BuildContext context) {
    final henk = Provider.of<InstellingenProvider>(context);
    return GestureDetector(
      onTap: () => henk.voice = voice,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.woman,
              size: 50,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            henk.voice == voice ? Icon(Icons.check) : Text(''),
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
            Icon(
              Icons.play_circle_outline,
              size: 50,
              color: Colors.purple[200],
            ),
          ],
        ),
      ),
    );
  }
}
