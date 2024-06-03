

import 'dart:convert';

Estudiante estudianteFromJson(String str) => Estudiante.fromJson(json.decode(str));

String estudianteToJson(Estudiante data) => json.encode(data.toJson());

class Estudiante {
    String id;
    String nombre;
    String apellido;
    String direccion;
    String telefono;

    Estudiante({
        required this.id,
        required this.nombre,
        required this.apellido,
        required this.direccion,
        required this.telefono,
    });

    factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "telefono": telefono,
    };
    @override
  String toString() {
    
    return "id: "+ id +" nombre: " +nombre ;
  }
}
