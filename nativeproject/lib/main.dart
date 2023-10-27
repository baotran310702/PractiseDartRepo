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
  List ringtones = [];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "This is test event & method app",
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              if (ringtones.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: ringtones.length,
                    itemBuilder: (_, index) {
                      return Text(index.toString());
                    },
                  ),
                ),
              ElevatedButton(
                  onPressed: () async {
                    const channel = MethodChannel('flutter_channel');
                    ringtones = await channel.invokeMethod('getRingtones');
                    setState(() {});
                  },
                  child: const Text("Get the rington!"))
            ],
          ),
        ),
      ),
    );
  }
}
