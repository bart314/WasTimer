import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/config/config.dart';
import 'package:timer_app/providers/timer_provider.dart';

class SetTimeScreen extends StatefulWidget {
  final int min;
  final int max;
  final int steps;
  final String screen;
  final int initialValue;

  const SetTimeScreen({
    required this.screen,
    this.min = 10,
    this.max = 120,
    this.steps = 5,
    this.initialValue = 10,
    super.key,
  });

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  late int _currentIntValue;

  @override
  void initState() {
    _currentIntValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.getRingColor(widget.screen),
      appBar: AppBar(
        title: Text('instellen ${widget.screen}-tijd'),
        backgroundColor: Config.getBackgroundColor(widget.screen),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Text(
                Config.getDescription(widget.screen),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: 20),
            NumberPicker(
              value: _currentIntValue,
              minValue: widget.min,
              maxValue: widget.max,
              step: widget.steps,
              haptics: true,
              itemHeight: 70,
              itemCount: 5,
              textStyle: Theme.of(context).textTheme.displaySmall,
              selectedTextStyle: Theme.of(context).textTheme.displayMedium!
                  .copyWith(color: Config.getFillColor(widget.screen)),
              onChanged: (value) => setState(() => _currentIntValue = value),
            ),
            Text('seconden'),
            //ElevatedButton(onPressed: null, child: Text('Opslaan')),
            saveButton(context),
          ],
        ),
      ),
    );
  }

  Widget saveButton(BuildContext context) {
    final timeProvider = Provider.of<TimerProvider>(context);

    return GestureDetector(
      onTap: () {
        timeProvider.setTime(widget.screen, _currentIntValue);
        Navigator.pop(context);
      },
      child: Padding(
        padding: EdgeInsetsGeometry.all(40),
        child: Card(
          color: Config.getBackgroundColor(widget.screen),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.save),
                title: Text('Opslaan', style: TextStyle(fontSize: 25)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('... en terug.', overflow: TextOverflow.clip),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
