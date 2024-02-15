import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/pages/schedule/scheduleScreen.dart';
import 'package:ifg_mobile_estudante/pages/studentCard/studentCardScreen.dart';
import 'package:ifg_mobile_estudante/widgets/label_button2.dart';

class CampusScreen extends StatelessWidget {
  CampusScreen({super.key});

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
                  "Campus Inhumas",
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
                height: 180, // aumentei para 150
                width: 180, // aumentei para 150
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(180),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/i.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
            height: 10,
          ),

          //const AccountCard(),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.green, width: 5.5),
                ),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  width: 355,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Descrição",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 6,
                            height: 6,
                          ),
                          Text(
                              "Levando-se em conta as características e demandas regionais, o Câmpus Inhumas atua principalmente nas seguintes áreas de atuação: Informática, Química e Alimentos.")
                        ],
                      ),
                      SizedBox(
                          height:
                              8), // Espaçamento entre a string e outros widgets, se necessário
                      // Outros widgets aqui, se desejar
                    ],
                  ),
                ),
              ),
            ],
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
            child: Center(
                child: Column(
              children: [
                Row(
                  children: [
                    LabelButton2(
                      'Calendário\nAcadêmico',
                      Icons.calendar_month,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleScreen(),
                        ),
                      ),
                    ),
                    LabelButton2(
                      'Lista\n De Cursos',
                      Icons.list_alt,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 11,
                  height: 11,
                ),
                Row(
                  children: [
                    LabelButton2(
                      'Telefones',
                      Icons.phone,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleScreen(),
                        ),
                      ),
                    ),
                    LabelButton2('Localização', Icons.location_on,
                        onPressed: () => ()),
                  ],
                ),
                SizedBox(
                  width: 11,
                  height: 11,
                ),
                Row(
                  children: [
                    LabelButton2(
                      'Facebook',
                      Icons.facebook,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleScreen(),
                        ),
                      ),
                    ),
                    LabelButton2(
                      'Instagram',
                      Icons.camera_alt,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScheduleScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
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
                            Icons.house,
                            color: Colors.green[600],
                            size: 40,
                            opticalSize: 40,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Página Do Campus',
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
