


Map<String, dynamic> formataMetrica(double tamanho) {
    final metricas = ["B", "KB", "MB", "GB", "TB"];
    int index = 0;

    while (tamanho >= 1024 && index < metricas.length - 1) {
      tamanho /= 1024;
      index++;
    }

    return {
      'label': metricas[index],
      'tamanho': tamanho,
    };
  }