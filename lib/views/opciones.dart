import 'package:flutter/material.dart';
import 'package:servicios/models/estudiante.dart';
import 'package:servicios/services/user_services.dart';
import 'package:servicios/views/formularioEditar.dart';
import 'package:servicios/views/formularioEstudiante.dart';

class Material3BottomNav extends StatefulWidget {
  const Material3BottomNav({super.key});

  @override
  State<Material3BottomNav> createState() => _Material3BottomNavState();
}

class _Material3BottomNavState extends State<Material3BottomNav> {
  late List<Estudiante> estudiantes;
   late List<Estudiante> estudiantesFiltrados;
   @override
  void initState() {
    
    super.initState();
    estudiantesFiltrados = [];
  }
     final TextEditingController _busquedaController = TextEditingController();
  Future<List<Estudiante>> asignarEstudiantes() async {
    List<dynamic> data = await UserServices.getEstudiantes();
    print(data.toString());
    if (estudiantesFiltrados.isNotEmpty) {
      return estudiantesFiltrados;
    }
    estudiantesFiltrados = data.isEmpty
        ? []
        : data.map<Estudiante>((item) => Estudiante.fromJson(item)).toList();
    return estudiantesFiltrados;
    // return data.map<Estudiante>((item) => Estudiante.fromJson(item)).toList();
  }

  void eliminarEstudiante(int index) async {
    final result = await UserServices.deleteEstudiantes(estudiantes[index].id);
    if (result == true) {
      // Si la eliminación fue exitosa, actualiza la lista de estudiantes
      setState(() {});
    }
  }

    void buscarEstudiante() {
    setState(() {
      estudiantesFiltrados = estudiantes
          .where((estudiante) =>
              estudiante.id
                  .toLowerCase()
                  .contains(_busquedaController.text.toLowerCase()) 
              )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
      ),
      body: FutureBuilder<List<Estudiante>>(
        future: asignarEstudiantes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay estudiantes disponibles'));
          } else {
            estudiantes = snapshot.data!;
            estudiantesFiltrados = estudiantes;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _busquedaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Buscar',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _busquedaController.clear();
                          setState(() {
                            estudiantesFiltrados = [];
                          });
                        } ,
                      ),
                    ),
                    onSubmitted: (value) => buscarEstudiante(),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Agregar nuevo estudiante'),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FormularioEstudiantePage()),
                    );
                    if (result == true) {
                      setState(() {
                        estudiantesFiltrados = [];
                      }); // Recarga la página
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: estudiantesFiltrados.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('ID: ${estudiantesFiltrados[index].id}'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    'Nombre: ${estudiantesFiltrados[index].nombre}'
                                    '\nApellido: ${estudiantesFiltrados[index].apellido}'
                                    '\nDireccion: ${estudiantesFiltrados[index].direccion}'
                                    '\nTelefono: ${estudiantesFiltrados[index].telefono}'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text(
                                      'Eliminar',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      eliminarEstudiante(index);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      'Editar',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 FormularioUpdateEstudiantePage(estudiante: estudiantesFiltrados[index],)),
                                      );
                                      if (result == true) {
                                        setState(() {
                                          estudiantesFiltrados = [];
                                        });
                                         Navigator.of(context).pop();// Recarga la página
                                      }
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
