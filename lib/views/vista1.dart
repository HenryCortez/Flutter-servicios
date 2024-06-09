import 'package:flutter/material.dart';
import 'package:servicios/models/estudiante.dart';

class Vista1 extends StatefulWidget {
  const Vista1({ super.key });

  @override
  _Vista1State createState() => _Vista1State();
}

class _Vista1State extends State<Vista1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
      ),
      
    );
  }
}