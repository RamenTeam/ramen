import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {
  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  late Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          seconds = seconds + 1;
          if (seconds > 59) {
            minutes += 1;
            seconds = 0;
            if (minutes > 59) {
              hours += 1;
              minutes = 0;
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${minutes >= 10 ? minutes : '0$minutes'} : ${seconds >= 10 ? seconds : '0$seconds'}",
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
