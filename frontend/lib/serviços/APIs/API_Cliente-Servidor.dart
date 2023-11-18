import "dart:convert";
import "dart:io";
import 'package:http/http.dart' as http;

const String _hostName = "http://localhost:3000";



  Future<dynamic> pegaPlanos() async {
  const String servidor = _hostName + "/planos";
  try {
    final response = await http.get(
      Uri.parse(servidor),
    );
    if (response.statusCode == 200) {

      return json.decode(response.body);
    } else {
    }
  } catch (e) {
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
  dynamic response;
  try {
    response = await http.post(
      Uri.parse(servidor),
      body: {'email': email, "senha": senha},
    );
    return response;
  } catch (e) {
    return false;
  }
}

Future<dynamic> uploadFile(
    final String token, final String idCliente, final File arquivo) async {
  String apiUrl = _hostName + "/files";

  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  request.headers['Authorization'] = 'Bearer $token';

  request.fields['idCliente'] = idCliente;

  request.files.add(
    http.MultipartFile(
      'file',
      arquivo.readAsBytes().asStream(),
      arquivo.lengthSync(),
      filename: arquivo.path.split('/').last,
    ),
  );

  var response = await request.send();

  if (response.statusCode == 200) {
    return true;
  } else {
    print('Erro ao enviar arquivo. Código de status: ${response.statusCode}');
    ;
  }

  return false;
}

Future<dynamic> pegaArquivos(final String token, final String idCliente) async {
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };
  final String servidor = _hostName + "/files/" + idCliente;
  try {
    final response = await http.get(
        Uri.parse(
          servidor,
        ),
        headers: headers);
    if (response.statusCode == 200) {
    } else {
      print('Falha : ${response.statusCode}');
    }

    return json.decode(response.body);
  } catch (e) {
    print('Erro durante o upload: $e');
  }
}

Future<dynamic> deletaArquivos(
    final String idArquivo, final String token) async {
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };
  final String servidor = _hostName + "/files/" + idArquivo;
  try {
    final response = await http.delete(
        Uri.parse(
          servidor,
        ),
        headers: headers);
    if (response.statusCode == 200) {
    } else {
      print('Falha : ${response.statusCode}');
    }
    return json.decode(response.body);
  } catch (e) {
    print('Erro F: $e');
  }
}

Future<dynamic> download(
  final String idArquivo,
  final String token,
  final String savePath,
) async {
  Map<String, String> headers = {
    'Authorization': 'Bearer $token',
  };
  final String servidor = _hostName + "/files/download/" + idArquivo;
  try {
    final response = await http.get(
      Uri.parse(servidor),
      headers: headers,
    );

    if (response.statusCode == 200) {
      if (response.headers.containsKey('content-disposition')) {
        String contentDisposition = response.headers['content-disposition']!;
        String fileName = json.decode(contentDisposition
            .split(';')
            .firstWhere((element) => element.trim().startsWith('filename='))
            .split('=')
            .last
            .trim());

        String filePath = '$savePath/$fileName';

        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        print('Arquivo salvo em: $filePath');
      } else {
        print('Cabeçalho "Content-Disposition" não encontrado na resposta.');
      }
    } else {
      print('Falha : ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Erro F: $e');
  }
}

  




