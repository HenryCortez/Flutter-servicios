import 'package:flutter/material.dart';
import 'package:servicios/models/estudiante.dart';
import 'package:servicios/services/user_services.dart';
import 'package:servicios/views/formularioEstudiante.dart';

class Material3BottomNav extends StatefulWidget {
  const Material3BottomNav({super.key});

  @override
  State<Material3BottomNav> createState() => _Material3BottomNavState();
}

class _Material3BottomNavState extends State<Material3BottomNav> {

  late List<Estudiante> estudiantes;
 
  Future<List<Estudiante>> asignarEstudiantes() async {
    List<dynamic> data = await UserServices.getEstudiantes();
    print (data.toString());
    return data.map<Estudiante>((item) => Estudiante.fromJson(item)).toList();
  }

  void eliminarEstudiante(int index) async {
    final result = await UserServices.deleteEstudiantes(estudiantes[index].id);
    if (result == true) {
      // Si la eliminación fue exitosa, actualiza la lista de estudiantes
      setState(() {
       
      });
    }
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
          
            return Column(
              children: [
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
                        
                      }); // Recarga la página
                    }
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: estudiantes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('ID: ${estudiantes[index].id}'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    'Nombre: ${estudiantes[index].nombre}'
                                    '\nApellido: ${estudiantes[index].apellido}'
                                    '\nDireccion: ${estudiantes[index].direccion}'
                                    '\nTelefono: ${estudiantes[index].telefono}'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Eliminar'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      eliminarEstudiante(index);
                                    },
                                  ),
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
