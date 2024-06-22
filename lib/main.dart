import 'package:flutter/material.dart';
import 'package:inherited_samples/inherited_notifier_sample_1.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final screens = const [
    InheritedNotifierSampleOne(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('inherited Samples'),
        ),
        body: ListView.builder(
          itemCount: screens.length,
          itemBuilder: (context, index) {
            final item = screens[index];
            return ListTile(
              title: Text('$item'),
              leading: const Icon(Icons.arrow_right),
              onTap: () => _openScreen(context, item),
            );
          },
        ),
      ),
    );
  }

  void _openScreen(BuildContext context, Widget screen) => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
}
