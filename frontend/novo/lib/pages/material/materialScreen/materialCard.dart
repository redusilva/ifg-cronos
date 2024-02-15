import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  final String materialName;
  final String activityType;
  final String uploadDate;
  final String fileExtension;

  MaterialCard({
    required this.materialName,
    required this.activityType,
    required this.uploadDate,
    required this.fileExtension,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                          height: 10,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                _fileIcon(fileExtension),
                                color: Colors.white,
                                size: 60,
                              ),
                              SizedBox(height: 6,width: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Abrir",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 3,
                          height: 3,
                        ),
                      ]),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Icon(
                          Icons.assignment,
                          color: Colors.green[800],
                        ),
                        Text(
                          " " + materialName,
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10, width: 5),
                    Row(
                      children: [
                        Icon(Icons.description),
                        Text(
                          " " + activityType,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                      width: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text(
                          " " + uploadDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.7,
          color: Colors.grey,
        )
      ],
    );
  }

  IconData _fileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    return _mapIcons[extension] ?? Icons.insert_drive_file;
  }

// Lista/Mapa com todos os icones
  final Map<String, IconData> _mapIcons = {
    'txt': Icons.description,
    'p': Icons.description,
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
}
