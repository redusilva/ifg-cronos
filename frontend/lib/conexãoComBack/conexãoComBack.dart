import "dart:convert";
import "dart:io";
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const String _hostName = "http://localhost:3000";

Future<dynamic> pegaPlanos() async {
  const String servidor = _hostName + "/planos";
  try {
    final response = await http.get(
      Uri.parse(servidor),
    );
    if (response.statusCode == 200) {
      // print('conexão bem-sucedida');

      return json.decode(response.body);
    } else {
      //  print('Falha : ${response.statusCode}');
    }
  } catch (e) {
    //print('Erro durante o upload: $e');
  }
  return false;
}

Future<dynamic> criaConta(
    final String email, final String senha, final String idPlano) async {
  const String servidor = _hostName + "/user";
  final response = await http.post(
    Uri.parse(servidor),
    body: {'email': email, "senha": senha, "idPlano": idPlano},
  );

  return (response);
}

Future<dynamic> login(final String email, final String senha) async {
  const String servidor = _hostName + "/user/login";
  final response = await http.post(
    Uri.parse(servidor),
    body: {'email': email, "senha": senha},
  );

  return response;
}

Future<bool> uploadFile(String token, File file) async {
  final dio = Dio();
  final files = [
    FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path),
     
    }),
  ];

  dio.options.headers['Authorization'] = 'Bearer $token';

  try {
    for (final formData in files) {
      final response = await dio.post(
        _hostName + "/files",
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Arquivo enviado com sucesso.');
        return true;
      } else {
        print('Erro ao enviar arquivo: ${response.statusCode}');
      }
    }
  } catch (e) {
    print('Erro: $e');
  }
  return false;
}
