import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int ranNums = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "This is test event & method app",
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text(ranNums.toString()),
              ElevatedButton(
                  onPressed: () async {
                    const channel = MethodChannel('flutter_channel');
                    ranNums = await channel.invokeMethod('getRandomNumber');
                    setState(() {});
                  },
                  child: const Text("Get the numbers!"))
            ],
          ),
        ),
      ),
    );
  }
}
