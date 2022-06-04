import 'package:flutter/material.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(132, 202, 157, 1),
        title: const Text('Teste'),
      ),
      body: const Center(child: Text('Teste')),
    );
  }
}
