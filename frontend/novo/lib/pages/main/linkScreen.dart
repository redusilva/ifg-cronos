import 'package:flutter/material.dart';
import 'package:ifg_mobile_estudante/widgets/campiCard.dart';
import "campusScreen.dart";

class LinkScreen extends StatelessWidget {
  LinkScreen({super.key});



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
                  "Links Externos",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const AccountCard(),

              SizedBox(
                width: 10,
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sistemas do IFG",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ],
              ),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CampiCard(
                        imagePath: 'assets/images/q.png',
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CampusScreen(),
                            ),
                          ),
                        },
                        city: "Q-acadêmico",
                      ),
                      CampiCard(
                        imagePath: 'assets/images/m.png',
                        onTap: () => {},
                        city: "Moodle",
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CampiCard(
                        imagePath: 'assets/images/sophia.png',
                        onTap: () => {},
                        city: "Sophia",
                      ),
                      CampiCard(
                        imagePath: 'assets/images/suap.png',
                        onTap: () => {},
                        city: "Suap",
                      ),
                    ],
                  ),
                ],
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

class PasswordField extends StatefulWidget {
  final String labelText;
  final Color color;

  PasswordField({required this.labelText, required this.color});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: widget.color),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.color),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: widget.color),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: widget.color,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
