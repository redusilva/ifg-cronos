import 'package:flutter/material.dart';

class CampiCard extends StatelessWidget {
  final String city;
  final String imagePath; // Novo parâmetro para o caminho da imagem
  final VoidCallback onTap;

  const CampiCard({
    required this.city,
    required this.imagePath, // Recebe o caminho da imagem
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
          ),
        ],
      ),
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Image.asset(
                imagePath, // Usando o caminho recebido via construtor
                height: 170, // Ajuste a altura conforme necessário
                width: 170, // Ajuste a largura conforme necessário
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 5,
                left: 5,
                child: Container(
                  color: Colors.black54,
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    city,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}