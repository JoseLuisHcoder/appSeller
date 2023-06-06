import 'package:flutter/material.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('En vivo'),
        ),
        body: const Center(
          child: Text('Live Page'),
        ),
      ),
    );
  }
}
