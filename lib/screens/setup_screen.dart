import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/config/config.dart';
import 'package:timer_app/providers/timer_provider.dart';
import 'package:timer_app/screens/number_picker.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimerProvider>(context);
    debugPrint('build in setupscreen..');
    return Scaffold(
      appBar: AppBar(title: Text('Trainingsinstellingen')),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buttonCard(
              'Hard werken',
              'actie',
              "${timeProvider.getTime('actie')} seconden",
              context,
            ),
            buttonCard(
              'Uitrusten',
              'rust',
              "${timeProvider.getTime('rust')} seconden",
              context,
            ),
            buttonCard(
              'Aantal oefeningen per rondje',
              'oefeningen',
              "${timeProvider.getTime('oefeningen')} oefeningen",
              context,
            ),
            buttonCard(
              'Aantal rondjes',
              'herhalingen',
              "${timeProvider.getTime('herhalingen')} rondjes",
              context,
            ),
            buttonCard(
              'Pauze tussen rondjes',
              'pauze',
              "${timeProvider.getTime('pauze')} seconden",
              context,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          timeProvider.startTimers();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => timeProvider.currentScreen),
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Starten',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Instellingen',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: 0,
      ),
    );
  }

  Widget buttonCard(
    String title,
    String what,
    String huidig,
    BuildContext context,
  ) {
    Icon icon;
    int min = 10;
    int max = 120;
    int steps = 5;
    switch (what) {
      case 'actie':
        icon = Icon(Icons.fitness_center);
        break;
      case 'rust':
        icon = Icon(Icons.airline_seat_recline_extra);
        break;
      case 'oefeningen':
        icon = Icon(Icons.repeat);
        min = 2;
        max = 10;
        steps = 1;
        break;
      case 'herhalingen':
        icon = Icon(Icons.circle_outlined);
        min = 2;
        max = 10;
        steps = 1;
        break;
      case 'pauze':
        icon = Icon(Icons.bed);
        break;
      default:
        icon = Icon(Icons.question_mark);
    }
    int time = Provider.of<TimerProvider>(context).getTime(what);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SetTimeScreen(
              screen: what,
              min: min,
              max: max,
              steps: steps,
              initialValue: time,
            ),
          ),
        );
      },
      child: Card(
        color: Config.getBackgroundColor(what),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: icon,
              title: Text(what, style: TextStyle(fontSize: 25)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[Text(huidig), const SizedBox(width: 18)],
            ),
          ],
        ),
      ),
    );
  }
}
