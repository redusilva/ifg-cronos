import 'package:flutter/material.dart';







class AboutsScreen extends StatelessWidget {
  AboutsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.green, Colors.white],
          stops: [0.3, 0.3],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                _body(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.fromLTRB(18, 20, 16, 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
              Center(
                child: Text(
                  "Sobre o aplicativo",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.help_outline, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 25, width: 25),
          Center(
            child: Container(
              height: 150, // ajuste conforme necessário
              width: 150, // ajuste conforme necessário
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                    color: Colors.green, // cor da borda
                    width: 1 // largura da borda
                    ),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    4), // ajuste conforme necessário para o tamanho da borda
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/logo B.png'), // substitua com o caminho correto da sua imagem
                      fit: BoxFit.cover, // ou outro BoxFit conforme necessário
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _comprimentoDaHora() {
    final agora = DateTime.now();
    final hora = agora.hour;

    if (hora >= 6 && hora < 12) {
      return 'Bom Dia,';
    } else if (hora >= 12 && hora < 18) {
      return 'Boa Tarde,';
    } else {
      return 'Boa Noite,';
    }
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 10,
                      height: 10,
                    ),
                    Card(
                      color: Colors.white, // Cor de fundo cinza
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                            color: Colors.green, width: 5.5), // Borda verde
                      ),
                      child: Container(
                          padding: EdgeInsets.all(16.0),
                          width: 400, // Largura do card
                          child: Column(
                            children: [
                              Text("Objetivos",style: TextStyle(fontSize: 20,color: Colors.green),),
                              SizedBox(height: 10,width: 10,),
                              Text(" O IFG Mobile é um aplicativo que tem como objetivo apresentar o Instituto Federal de Goiás para toda a comunidade acadêmica, reunindo diversas informações relevantes sobre a instituição.\n\n Atualmente é possível acessar o sistema de bibliotecas Web, consultar informações sobre os câmpus, cursos, telefones, notícias, dúvidas frequentes, calendários acadêmicos e conhecer diversos regulamentos e procedimentos acadêmicos relacionados aos cursos do IFG e a vida acadêmica dos alunos.\n\n Para os alunos com vínculo, foi realizada uma integração com o Sistema Acadêmico do IFG permitindo consultar o Histórico, Boletim, Notas de Avaliações, Horários e Materiais de Aulas. O aluno também pode visualizar a Carteira Estudantil. Para os professores, é possível consultar os Horários de Aula e alunos matriculados nos diários. A Identifiação Funcional pode ser visualizada por todos os servidores do IFG. Este aplicativo é uma iniciativa da equipe da Pró-Reitoria de Ensino do Instituto Federal de Goiás.",style: TextStyle(fontSize: 16),),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
