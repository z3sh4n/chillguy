import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChillGuyApp extends StatefulWidget {
  const ChillGuyApp({super.key});

  @override
  State<ChillGuyApp> createState() => _ChillGuyAppState();
}

class _ChillGuyAppState extends State<ChillGuyApp> {
  Timer? _timer;
  int _remainingTime = 10; // Countdown time in seconds
 bool _isTimerRunning = false;
  void _startTimer() {
    setState(() {
      _remainingTime = 10; // Set the timer to 10 seconds
    });

    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
          _isTimerRunning = true;
        });
      } else {
        closeAppUsingSystemPop();
        timer.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Ensure the timer is canceled when the widget is disposed
    super.dispose();
  }

  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Chill Guy",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.blueGrey[50], // Adding a light background color for contrast
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners for image
                  child: Image.asset(
                    'assets/95c.png',
                    height: 300,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Time Remaining Text
              Text(
                'Chill Time: $_remainingTime seconds',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Instructional Text
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Press this button to be a chill guy:',
                  style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                ),
              ),

              // Chill Button
              ElevatedButton(
                onPressed: _isTimerRunning ? null : _startTimer, // Disable when timer is running
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded button
                  ),
                ),
                child: Text(
                  _isTimerRunning ? "Chillin..." : "Take a Chill", // Change text while running
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
