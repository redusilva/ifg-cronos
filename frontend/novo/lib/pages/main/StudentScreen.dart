import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/pages/schedule/scheduleScreen.dart';
import 'package:ifg_mobile_estudante/pages/grade/gradeDisciplineSelection.dart';
import 'package:ifg_mobile_estudante/pages/report/reportScreen.dart';
import 'package:ifg_mobile_estudante/pages/studentCard/studentCardScreen.dart';
import 'package:ifg_mobile_estudante/pages/material/materialDisciplineScreen.dart';

import 'package:ifg_mobile_estudante/widgets/label_button.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

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
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {},
              ),
              Center(
                child: Text(
                  "Painel Do Estudante",
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
          const SizedBox(height: 10, width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100, // ajuste conforme necessário
                width: 100, // ajuste conforme necessário
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/fotoExemplo.png'), // substitua com o caminho correto da sua imagem
                    fit: BoxFit.cover, // ou outro BoxFit conforme necessário
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          Center(
            child: Text(
              _comprimentoDaHora() + " Tarcyo" + "!",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
            height: 10,
          ),

          //const AccountCard(),

          Center(
            child: Card(
              color: Colors.white, // Cor de fundo cinza
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side:
                    BorderSide(color: Colors.green, width: 5.5), // Borda verde
              ),
              child: Container(
                padding: EdgeInsets.all(16.0),
                width: 355, // Largura do card
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Matricula",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("20211030180055"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Situação",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Matriculado"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Nome do estudante",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Tarcyo Guilherme Maia Borges"),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),

          Divider(
            height: 10,
            thickness: 2,
          ),

          const SizedBox(
            width: 15,
            height: 15,
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 10),
                LabelButton(
                  'Horário \nDe Aula',
                  Icons.calendar_month,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScheduleScreen()),
                  ),
                ),
                //    onPressed: () => {}  context.showBottomSheet(
                //  const PaymentScreen(),
                //  ),
                //      ),
                //LabelButton('Histórico Escolar', Icons.history,
                //  onPressed: () =>
                //      {} //context.showBottomSheet(TransferScreen()),
                //   ),
                //LabelButton(
                ////   'Arquivos',
                //   Icons.insert_drive_file,
                //   onPressed: () => context.showBottomSheet(
                //     const AccountCard(),
                //    ),
                // ),
                LabelButton(
                  'Minhas\nNotas', Icons.emoji_events,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GradeDisciplineScreen()),
                  ), //context.showBottomSheet(ChargeScreen()),
                ),
                // LabelButton(
                //    'Recarga de celular',
                //     NuIcons.ic_phone,
                //    onPressed: () => context.showBottomSheet(DepositScreen()),
                //  ),

                LabelButton(
                  'Meu\nBoletim', Icons.assignment,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportScreen()),
                  ), //context.showBottomSheet(ChargeScreen()),
                ),

                LabelButton(
                  'Material\nde aula', Icons.book,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MaterialDisciplineScreen()),
                  ), //context.showBottomSheet(ChargeScreen()),
                ),
                //  LabelButton(
                //    'Doação',
                //    NuIcons.nuds_ic_personal_loan,
                //    onPressed: () {},
                //  ),
                //   LabelButton(
                //    'Encontrar atalhos',
                //   NuIcons.help,
                //    onPressed: () {},
                //    tag: 'Dica',
                //  ),
                const SizedBox(width: 20),
              ],
            ),
          ),
          const SizedBox(height: 10),

          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Stack(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => studentCardScreen()),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: Colors.blueGrey[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.green[600]!,
                            width: 2.0), // Adicione o contorno vermelho aqui
                      ),
                      primary: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.badge,
                            color: Colors.green[600],
                            size: 40,
                            opticalSize: 40,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Carteira estudantil',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //  physics: const BouncingScrollPhysics(),
          // child: Row(
          // children: [
          //  const SizedBox(width: 24),
          //  TextCard(
          //  text: 'Você tem R\$ ${MockedValues.loan} disponíveis para ',
          //  highlightText: 'empréstimo.',
          //   onTap: () => context.push(
          //      const LoanScreen(),
          //    ),
          //  ),
          //   TextCard(
          //    text: 'Conquiste planos futuros: conheça as opções para ',
          //   highlightText: 'guardar dinheiro.',
          //     onTap: () {},
          //   ),
          //   const SizedBox(width: 10),
          //   ],
          //  ),
          //  ),
          // const SizedBox(height: 20),
//
          //  ..._cards,
          //  Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          // //  child: Text(
          //   'Sobre A Instituição:',
//style: Theme.of(context)
          ///       .textTheme
          //      .titleLarge
          //      ?.copyWith(fontWeight: FontWeight.w500),
          //  ),
          // ),
          // SingleChildScrollView(
          //  scrollDirection: Axis.horizontal,
          // physics: const BouncingScrollPhysics(),
          // child: IntrinsicHeight(
          //   child: Row(
          //      children: [
          //        const SizedBox(width: 24),
          // DiscoverCard(
          //   title: ' O que é o IFG?',
          //   content: 'Conheça a história e os objetivos do IFG.',
          //   buttonText: 'Quero conhecer',
          //   isNew: true,
          //   onTap: () {},
          // ),
          //   DiscoverCard(
          //     title: 'Informação sobre os campus',
          //    content:
          //         'Veja informações sobre os cursos e a estrutura de cada um dos Campus',
          //     buttonText: 'Deixe-me ver',
          //     onTap: () => context.showBottomSheet(const ReferScreen()),
          //   ),
          // DiscoverCard(
          //    title: 'Reitoria',
          ////     content: 'Saiba informação sobre a reitoria do IFG',
          //    buttonText: 'Deixe-me ver',
          ////     onTap: () => context.showBottomSheet(const ReferScreen()),
          //  ),
          const SizedBox(width: 14),
        ],
      ),
      //   ),
      //   ),
      // ],
      //  ),
    );
  }
}

Widget buildActivityRow(String activityName, String grade, String date) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        activityName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      Text(
        'Nota: $grade',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      Text(
        'Data: $date',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    ],
  );
}
