import 'package:flutter/material.dart';


// Retorna o icone do arquivo a partir do nome
IconData retornaIconeArquivo(String fileName) {
  final extension = fileName.split('.').last.toLowerCase();
  return _mapaDeIcones[extension] ?? Icons.insert_drive_file;
}

// Lista/Mapa com todos os icones
final Map<String, IconData> _mapaDeIcones = {
  'txt': Icons.description,
  'docx': Icons.book,
  'pdf': Icons.picture_as_pdf,
  'jpg': Icons.image,
  'png': Icons.image,
  'mp3': Icons.music_note,
  'mp4': Icons.video_call,
  'xls': Icons.table_chart,
  'ppt': Icons.slideshow,
  'zip': Icons.archive,
  'html': Icons.code,
  'css': Icons.style,
  'js': Icons.code,
  'dart': Icons.code,
  'avi': Icons.movie,
  'json': Icons.code,
  'xml': Icons.code,
  'php': Icons.code,
  'exe': Icons.desktop_windows,
  'gif': Icons.gif,
  'svg': Icons.image_aspect_ratio,
  'doc': Icons.library_books,
  'pptx': Icons.slideshow,
  'xlsx': Icons.table_chart,
  'java': Icons.code,
  'cpp': Icons.code,
  'py': Icons.code,
  'c': Icons.code,
  'bat': Icons.code,
  'html5': Icons.code,
  'css3': Icons.style,
  'ts': Icons.code,
  'vue': Icons.code,
  'npm': Icons.code,
  'yarn': Icons.code,
  'docker': Icons.code,
  'swift': Icons.code,
  'ruby': Icons.code,
  'scala': Icons.code,
  'go': Icons.code,
  'lua': Icons.code,
};
