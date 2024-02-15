import 'package:flutter/material.dart';

class PersistentBottomBarScaffold extends StatefulWidget {
  final List<PersistentTabItem> items;

  const PersistentBottomBarScaffold({Key? key, required this.items})
      : super(key: key);

  @override
  _PersistentBottomBarScaffoldState createState() =>
      _PersistentBottomBarScaffoldState();
}

class _PersistentBottomBarScaffoldState
    extends State<PersistentBottomBarScaffold> {
  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  late PageController _pageController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _navigatorKeys =
        List.generate(widget.items.length, (_) => GlobalKey<NavigatorState>());
    _pageController = PageController(initialPage: _selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_navigatorKeys[_selectedTab].currentState?.canPop() ?? false) {
          _navigatorKeys[_selectedTab].currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics:
              NeverScrollableScrollPhysics(), // Impede o PageView de ser rolado manualmente
          onPageChanged: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          children: List.generate(
            widget.items.length,
            (index) => Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => widget.items[index].tab,
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedTab,
          selectedItemColor: Colors.green, // Defina a cor verde quando clicado
          unselectedItemColor:
              Colors.grey, // Defina a cor para os itens não selecionados
          onTap: (index) {
  if (index == _selectedTab) {
    _navigatorKeys[index]
        .currentState
        ?.popUntil((route) => route.isFirst);
  } else {
    setState(() {
      _selectedTab = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 1000), // Altere para 0 para uma transição instantânea
        curve: Curves.easeInOut,
      );
    });
  }
},
          items: widget.items
              .map((item) => BottomNavigationBarItem(
                    icon: Icon(item.icon),
                    label: item.title,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class PersistentTabItem {
  final Widget tab;
  final GlobalKey<NavigatorState>? navigatorkey;
  final String title;
  final IconData icon;

  PersistentTabItem({
    required this.tab,
    this.navigatorkey,
    required this.title,
    required this.icon,
  });
}

