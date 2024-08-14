import 'package:flutter/material.dart';

class NewTask extends StatelessWidget {
  const NewTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new task'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the new page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
