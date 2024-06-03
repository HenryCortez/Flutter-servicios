// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:servicios/models/estudiante.dart';
import 'package:servicios/services/user_services.dart';

class FormularioEstudiantePage extends StatefulWidget {
  const FormularioEstudiantePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormularioEstudiantePageState createState() =>
      _FormularioEstudiantePageState();
}

class _FormularioEstudiantePageState extends State<FormularioEstudiantePage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _idController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();

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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un ID';
                  } else if (value.length != 10) {
                    return 'El ID debe tener exactamente 10 caracteres';
                  }
                  return null;
                },
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
                        context, UserServices.postEstudiantes(student));
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
