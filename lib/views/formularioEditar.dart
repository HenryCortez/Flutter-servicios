// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:servicios/models/estudiante.dart';
import 'package:servicios/services/user_services.dart';

class FormularioUpdateEstudiantePage extends StatefulWidget {
  const FormularioUpdateEstudiantePage({super.key, required this.estudiante});
  final Estudiante estudiante;
  @override
  // ignore: library_private_types_in_public_api
  _FormularioUpdateEstudiantePageState createState() =>
      _FormularioUpdateEstudiantePageState();
}

class _FormularioUpdateEstudiantePageState extends State<FormularioUpdateEstudiantePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _idController;
  late final TextEditingController _apellidoController;
  late final TextEditingController _direccionController;
  late final TextEditingController _telefonoController;

@override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.estudiante.nombre);
    _idController = TextEditingController(text: widget.estudiante.id);
    _apellidoController =
        TextEditingController(text: widget.estudiante.apellido);
    _direccionController =
        TextEditingController(text: widget.estudiante.direccion);
    _telefonoController =
        TextEditingController(text: widget.estudiante.telefono);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar nuevo estudiante'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                enabled: false,
              ),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _apellidoController,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _direccionController,
                decoration: InputDecoration(labelText: 'Direccion'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un direccion';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Telefono'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un telefono';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Estudiante student = Estudiante(
                      id: _idController.text,
                      nombre: _nombreController.text,
                      apellido: _apellidoController.text,
                      direccion: _direccionController.text,
                      telefono: _telefonoController.text,
                    );

                    Navigator.pop(
                        context, UserServices.putEstudiantes(student));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
