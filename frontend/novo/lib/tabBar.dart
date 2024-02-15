import 'package:flutter/material.dart';
import 'persistent_bottom_bar_scaffold.dart';

import 'pages/main/instituteScreen.dart';
import 'pages/main/linkScreen.dart';

import 'pages/main/homeScreen.dart';

import 'pages/main/aboutsScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistentBottomBarScaffold(
      items: [
        PersistentTabItem(
          tab: const HomeScreenTab(),
          icon: Icons.home,
          title: 'Inicio',
        ),
        PersistentTabItem(
          tab: const InstituteScreenTab(),
          icon: Icons.school,
          title: 'Instituição',
        ),
        PersistentTabItem(
          tab: const LinkScreenTab(),
          icon: Icons.link,
          title: 'Links',
        ),
        PersistentTabItem(
          tab: const AboutsScreenTab(),
          icon: Icons.info_outline,
          title: 'Sobre',
        ),
      ],
    );
  }
}

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  _HomeScreenTabState createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Importante chamar o método build da classe pai.
    print('TabPage1 build');
    return HomeScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class InstituteScreenTab extends StatefulWidget {
  const InstituteScreenTab({Key? key}) : super(key: key);

  @override
  _InstituteScreenTabState createState() => _InstituteScreenTabState();
}

class _InstituteScreenTabState extends State<InstituteScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Importante chamar o método build da classe pai.
    print('TabPage2 build');
    return InstituteScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class LinkScreenTab extends StatefulWidget {
  const LinkScreenTab({Key? key}) : super(key: key);

  @override
  _LinkScreenTabState createState() => _LinkScreenTabState();
}

class _LinkScreenTabState extends State<LinkScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Importante chamar o método build da classe pai.
    print('TabPage3 build');
    return LinkScreen();
  }

  @override
  bool get wantKeepAlive => true;
}

class AboutsScreenTab extends StatefulWidget {
  const AboutsScreenTab({Key? key}) : super(key: key);

  @override
  _AboutsScreenTabState createState() => _AboutsScreenTabState();
}

class _AboutsScreenTabState extends State<AboutsScreenTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Importante chamar o método build da classe pai.
    print('TabPage4 build');
    return AboutsScreen();
  }

  @override
  bool get wantKeepAlive => true;
}
