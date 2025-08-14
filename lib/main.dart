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

class _MainAppState extends State<MainApp> {
  int _currentIndex = navList.indexOf('casino');
  bool _isBottomNavBarHidden = false;

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
        appBar: AppBar(
          actions: [
            Button(child: "ACCESO", backgroundColor: colors["highlight"]),
            SizedBox(width: 12),
            Button(child: "REGISTRATE", backgroundColor: colors["primary"]),
            SizedBox(width: 12),
          ],
          title: Row(
            children: [
              IconButton(
                onPressed: () => null,
                icon: Icon(Icons.menu, color: colors['highlight'], size: 28),
              ),
              Image.asset('assets/images/title.webp', width: 78),
            ],
          ),
          backgroundColor: Colors.white, // Optional: customize color
          elevation: 0,
        ),
        body: Column(
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
                    width: 160,
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
                  SizedBox(width: 6),
                  Button(
                    color: Colors.white,
                    backgroundColor: Colors.grey.withAlpha(26),
                    child: Icon(Icons.chevron_left_rounded, size: 28),
                  ),
                  SizedBox(width: 6),
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
                height: 60,
                initialImageList: [
                  'assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp',
                  'assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp',
                  'assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp',
                ],
              ),
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

Widget _buildCustomIcon(String assetPath, bool isActive) {
  return Image.asset(
    assetPath,
    width: 28, // Standard icon size
    height: 28,
    color: isActive ? Colors.blue : Colors.grey, // Optional: tint color
  );
}
