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

Future<bool> uploadFile(String token, String idUsuario, File arquivo) async {
  String apiUrl = _hostName + "/files";

  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  request.headers['Authorization'] = 'Bearer $token';

  request.fields['idCliente'] = idUsuario;

  request.files.add(
    http.MultipartFile(
      'file',
      arquivo.readAsBytes().asStream(),
      arquivo.lengthSync(),
      filename: arquivo.path.split('/').last,
    ),
  );

  // Envie a requisição e aguarde a resposta
  var response = await request.send();

  // Verifique o código de status da resposta
  if (response.statusCode == 200) {
    print('Arquivo enviado com sucesso!');
    return true;
  } else {
    print('Erro ao enviar arquivo. Código de status: ${response.statusCode}');
  }

  return false;
}

Future<dynamic> pegaArquivos(String token, String idCliente) async {
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
      //  print('conexão bem-sucedida');
    } else {
      print('Falha : ${response.statusCode}');
    }
    return json.decode(response.body)['arquivos'];
  } catch (e) {
    print('Erro durante o upload: $e');
  }
}
