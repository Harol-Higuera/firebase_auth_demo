import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnonymousPage extends ConsumerStatefulWidget {
  const AnonymousPage({Key? key}) : super(key: key);

  @override
  _AnonymousPageState createState() => _AnonymousPageState();
}

class _AnonymousPageState extends ConsumerState<AnonymousPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Anonymous Experiment'),
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
