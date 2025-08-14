import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun88/blocs/carousel_bloc.dart';
import 'package:fun88/components/button.dart';
import 'package:fun88/components/image_carousel.dart';
import 'package:fun88/utils/constants.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

final navList = ['deportes', 'favoritos', 'jugar', 'casino', 'expandir'];
final activeNavList = ['casino', 'expandir'];
final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

class _MainAppState extends State<MainApp> {
  int _currentIndex = navList.indexOf('casino');
  bool _isBottomNavBarHidden = false;
  final List<String> _expansionTileList = [];

  void _hideBottomNavBar(int index) {
    setState(() {
      _isBottomNavBarHidden = !_isBottomNavBarHidden;
      _currentIndex = navList.indexOf('casino');
    });
  }

  void changeIndex(int index) {
    setState(() => _currentIndex = index);
    if (index == navList.indexOf('expandir')) {
      _hideBottomNavBar(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawerScrimColor: Colors.black.withAlpha(128),
        drawerEnableOpenDragGesture: true,
        drawer: Drawer(
          surfaceTintColor: colors['primary'],
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    DrawerHeader(
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: null,
                      ),
                      child: SizedBox.expand(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BIENVENIDO!',
                              style: TextStyle(
                                color: Colors.black.withAlpha(96),
                                fontSize: 16,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Button(
                                fontSize: 16,
                                child: "ACCESO",
                                width: MediaQuery.of(context).size.width / 1.7,
                                backgroundColor: colors['highlight'],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'REGISTRATE!',
                                style: TextStyle(
                                  color: colors['highlight'],
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                  decorationColor: colors['highlight'],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ...drawerTiles.entries.map((entry) {
                      return Container(
                        color: Colors.white,
                        // padding: EdgeInsets.all(0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            // tilePadding: EdgeInsets.zero,
                            expandedAlignment: Alignment.center,
                            backgroundColor: Colors.grey.withAlpha(24),
                            collapsedBackgroundColor: Colors.transparent,
                            title: InkWell(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  color: colors['highlight'],
                                ),
                              ),
                            ),
                            trailing: entry.value.isEmpty
                                ? Icon(null)
                                : Icon(
                                    _expansionTileList.contains(entry.key)
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    size: 28,
                                    color: colors["highlight"],
                                  ),
                            initiallyExpanded: _expansionTileList.contains(
                              entry.key,
                            ),
                            onExpansionChanged: (bool expanded) {
                              if (entry.value.isEmpty) return;
                              setState(() {
                                if (expanded) {
                                  _expansionTileList.add(entry.key);
                                } else {
                                  _expansionTileList.remove(entry.key);
                                }
                              });
                            },
                            children: entry.value.isNotEmpty
                                ? entry.value
                                      .map(
                                        (value) => ListTile(
                                          title: Text(
                                            value,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: colors['highlight'],
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.pop(context);
                                            // Add navigation logic
                                          },
                                        ),
                                      )
                                      .toList()
                                : [SizedBox()],
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(26),
                        borderRadius: BorderRadius.circular(64),
                      ),
                      margin: EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Button(
                            icon: Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.grey.withAlpha(128),
                            ),
                            child: 'Oscuro',
                            color: Colors.grey.withAlpha(128),
                          ),
                          Button(
                            icon: Icon(
                              Icons.light_mode_outlined,
                              color: Colors.grey,
                            ),
                            child: 'Luz',
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu, color: colors["highlight"]),
            onPressed: () => null,
          ),
          actions: [
            Button(child: "ACCESO", backgroundColor: colors["highlight"]),
            SizedBox(width: 12),
            Button(child: "REGISTRATE", backgroundColor: colors["primary"]),
            SizedBox(width: 12),
          ],
          title: Image.asset('assets/images/title.webp', width: 78),
          backgroundColor: Colors.white, // Optional: customize color
          elevation: 0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.list(
              children: [
                BlocProvider(
                  create: (context) => CarouselBloc(),
                  child: ImageCarousel(
                    height: 200,
                    initialImageList: [
                      'assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp',
                      'assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp',
                      'assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp',
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 12, bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          'Proveedores de juego',
                          softWrap: true,
                          style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                        ),
                      ),
                      SizedBox(width: 12),
                      Button(
                        color: Colors.black,
                        backgroundColor: Colors.grey.withAlpha(26),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        child: "MÁS",
                      ),
                      SizedBox(width: 3),
                      Button(
                        color: Colors.white,
                        backgroundColor: Colors.grey.withAlpha(26),
                        child: Icon(Icons.chevron_left_rounded, size: 28),
                      ),
                      SizedBox(width: 3),
                      Button(
                        color: Colors.white,
                        backgroundColor: Colors.grey.withAlpha(26),
                        child: Icon(Icons.chevron_right_rounded, size: 28),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                BlocProvider(
                  create: (context) => CarouselBloc(),
                  child: ImageCarousel(
                    height: 116,
                    showThreeItems: true,
                    initialImageList: [
                      'assets/images/pgsoft_68.webp',
                      'assets/images/pgsoft_68.webp',
                      'assets/images/pgsoft_98.webp',
                      'assets/images/pgsoft_126.webp',
                    ],
                  ),
                ),
              ],
            ),
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Sticky Header'),
                background: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Icon(Icons.star, size: 50, color: Colors.white),
                  ),
                ),
              ),
            ),
            SliverList.list(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of items per row
                            crossAxisSpacing:
                                8, // Horizontal spacing between items
                            mainAxisSpacing:
                                8, // Vertical spacing between items
                            childAspectRatio:
                                0.8, // Width/height ratio for each item
                          ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 40,
                                  color: Colors.blue[800],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  items[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: _isBottomNavBarHidden
            ? null
            : _bottomNavigationBar(),
        floatingActionButton: _isBottomNavBarHidden
            ? FloatingActionButton(
                elevation: 0,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                onPressed: () => _hideBottomNavBar(0),
                child: _buildCustomIcon(
                  'assets/images/expandir-inactive.webp',
                  true,
                ),
              )
            : null,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
      ),
    );
  }

  Widget _bottomNavigationBar() {
    void onTapCallback(int e) => navList.indexOf('expandir') != _currentIndex
        ? changeIndex(e)
        : _hideBottomNavBar(e);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            spreadRadius: 1,
            blurRadius: 12,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 10, fontFamily: 'Poppins'),
        onTap: onTapCallback,
        items: navList
            .map(
              (v) => BottomNavigationBarItem(
                icon: _buildCustomIcon(
                  v == 'expandir'
                      ? 'assets/images/$v.webp'
                      : 'assets/images/$v-inactive.webp',
                  v == 'expandir' || _currentIndex == navList.indexOf(v),
                ),
                activeIcon: _buildCustomIcon(
                  'assets/images/$v.webp',
                  _currentIndex == navList.indexOf(v) &&
                      activeNavList.contains(navList[navList.indexOf(v)]),
                ),
                label: v.toUpperCase(),
              ),
            )
            .toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

Map<String, List<String>> drawerTiles = {
  "CASINO": [
    "POPULAR",
    "INCIO",
    "JACKPOT",
    "NUEVO",
    "CASUAL",
    "CRASH",
    "PRAGMATIC",
    "FAT PANDA",
    "PLAYTECH",
    "SLOTS",
    "BINGO",
    "EN VIVO",
  ],
  "APUESTAS DEPORTIVAS": ["Mejor cuota", "Apuesta y Gana", "Mas transmisiones"],
  "MI PERFIL": ["Informacion personal", "Cambiar Contrasena"],
  "VERIFICACION DE USUARIO": [],
  "CAJERO": [
    "Deposito",
    "Retiros",
    "Transacciones",
    "Transacciones financieras",
    "Historial de Bonos",
  ],
  "BONO GRATIS": [],
  "CODIGO PROMOCIONAL": [],
  "PROGRAMA DE REFERIDOS": [],
  "SUGERENCIAS": [],
  "PROMOCIONES": [],
  "PATROCINADORAS": [],
  "BLOGS": [],
  "NOTICIAS": [],
};

Widget _buildCustomIcon(String assetPath, bool isActive) {
  return Image.asset(
    assetPath,
    width: 28, // Standard icon size
    height: 28,
    color: isActive ? Colors.blue : Colors.grey, // Optional: tint color
  );
}
