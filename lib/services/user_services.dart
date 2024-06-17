import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:servicios/models/estudiante.dart';

class UserServices {
  static var url = Uri.parse('https://10.0.2.2/quinto/clase/controllers/apiRest.php');
  static getEstudiantes() async {
     try {
      

      HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(httpClient);

      var response = await ioClient.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  static postEstudiantes(Estudiante est) async {
    try {
      HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(httpClient);

      String jsonBody = jsonEncode(est.toJson());
      print(jsonBody);
      var response = await ioClient.post(url, 
      headers: {"Content-Type": "application/json"},
      body: jsonBody );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    }catch(e){
      print(e);
    }
}

  static putEstudiantes(Estudiante est) async {
    try {
      var urld = Uri.parse("$url?id=${est.id}&nombre=${est.nombre}&apellido=${est.apellido}&direccion=${est.direccion}&telefono=${est.telefono}");
      HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(httpClient);
      var response = await ioClient.put(urld, 
      headers: {"Content-Type": "application/json"},);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    }catch(e){
      print(e);
    }
  }

  static deleteEstudiantes(id) async {
     try {
      var urld = Uri.parse("$url?id=$id");
      HttpClient httpClient = HttpClient()..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(httpClient);
      var response = await ioClient.delete(urld, 
      headers: {"Content-Type": "application/json"}
      );
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    }catch(e){
      print(e);
    }
    }

}