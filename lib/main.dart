import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fun88/blocs/carousel_bloc.dart';
import 'package:fun88/blocs/theme_bloc.dart';
import 'package:fun88/components/button.dart';
import 'package:fun88/components/image_carousel.dart';
import 'package:fun88/utils/constants.dart';
import 'package:fun88/utils/futures.dart';

void main() {
  runApp(
    BlocProvider(create: (context) => ThemeBloc(), child: const MainApp()),
  );
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
  bool _isNavAppBarHidden = false;
  final List<String> _expansionTileList = [];
  final Futures futures = Futures();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _hideBottomNavBar(int index) {
    setState(() {
      _isNavAppBarHidden = !_isNavAppBarHidden;
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
    final isDark = context.select(
      (ThemeBloc bloc) => bloc.state.themeMode == ThemeMode.dark,
    );

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: state.themeMode,
          home: Scaffold(
            key: _scaffoldKey,
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
                            color: isDark ? Colors.black : Colors.white,
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
                                    color: isDark
                                        ? Colors.white.withAlpha(96)
                                        : Colors.black.withAlpha(96),
                                    fontSize: 16,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Button(
                                    fontSize: 16,
                                    child: "ACCESO",
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
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
                            color: isDark ? Colors.black : Colors.white,

                            child: Theme(
                              data: Theme.of(context).copyWith(
                                dividerColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                expandedAlignment: Alignment.center,
                                backgroundColor: Colors.grey.withAlpha(24),
                                collapsedBackgroundColor: Colors.transparent,
                                title: InkWell(
                                  splashColor: isDark
                                      ? Colors.black
                                      : Colors.white,
                                  highlightColor: isDark
                                      ? Colors.black
                                      : Colors.white,
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
                      color: isDark ? Colors.black : Colors.white,
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
                                onPressed: () {
                                  context.read<ThemeBloc>().add(
                                    ToggleThemeEvent(!isDark),
                                  );
                                },
                                icon: Icon(
                                  Icons.dark_mode_outlined,
                                  color: isDark
                                      ? Colors.white.withAlpha(128)
                                      : Colors.grey.withAlpha(128),
                                ),
                                child: 'Oscuro',
                                color: isDark
                                    ? Colors.white.withAlpha(128)
                                    : Colors.grey.withAlpha(128),
                              ),
                              Button(
                                icon: Icon(
                                  Icons.light_mode_outlined,
                                  color: isDark
                                      ? Colors.grey.withAlpha(128)
                                      : Colors.black.withAlpha(128),
                                ),
                                child: 'Luz',
                                color: isDark
                                    ? Colors.grey.withAlpha(128)
                                    : Colors.black.withAlpha(128),
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
            appBar: _isNavAppBarHidden
                ? null
                : AppBar(
                    leading: IconButton(
                      icon: Icon(Icons.menu, color: colors["highlight"]),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    actions: [
                      Button(
                        child: "ACCESO",
                        backgroundColor: colors["highlight"],
                      ),
                      SizedBox(width: 12),
                      Button(
                        child: "REGISTRATE",
                        backgroundColor: colors["primary"],
                      ),
                      SizedBox(width: 12),
                    ],
                    title: Image.asset('assets/images/title.webp', width: 78),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
            body: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverList.list(
                  children: [
                    BlocProvider(
                      create: (context) => CarouselBloc(),
                      child: ImageCarousel(
                        height: 200,
                        initialImageList: [
                          "assets/images/carousel/Bono Bienvenida (2240 x 1120 px).webp",
                          "assets/images/carousel/1800x900_pr_v2.webp",
                          "assets/images/carousel/ASTROPAY-1_2240x1120[1].webp",
                          "assets/images/carousel/1800x900_v3_1x.webp",
                          "assets/images/carousel/casino_inicio_bonos_8000_mobile.webp",
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
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Button(
                            color: isDark ? Colors.white : Colors.black,
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
                      child: FutureBuilder(
                        future: futures.getCategoryProviderList(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return SizedBox();
                          return ImageCarousel(
                            height: 116,
                            showThreeItems: true,
                            initialImageList: snapshot.data!.map((provider) {
                              return ColoredBox(
                                color: Colors.grey.withAlpha(25),
                                child: SizedBox.expand(
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsGeometry.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: ImageIcon(
                                          NetworkImage(provider.iconLight),
                                          size: 120,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          color: Colors.grey.withAlpha(64),
                                          child: Center(
                                            child: Padding(
                                              padding: EdgeInsetsGeometry.all(
                                                6,
                                              ),
                                              child: Text(
                                                provider.name,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  actionsIconTheme: IconThemeData(
                    color: Colors.transparent,
                    size: 120,
                  ),
                  collapsedHeight: 120,
                  expandedHeight: 120,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.transparent,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                          child: FutureBuilder(
                            future: futures.getCategories(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) return SizedBox();
                              return Row(
                                spacing: 16,
                                children: snapshot.data!.map((category) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          IconButton(
                                            icon: ImageIcon(
                                              NetworkImage(category.iconOff),
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                            onPressed: () => null,
                                            color: Colors.black,
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                color: colors['highlight'],
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 16,
                                                minHeight: 16,
                                              ),
                                              child: Text(
                                                '${category.count}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        category.category,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    // background: Container(
                    //   color: Colors.white,
                    //   child: SingleChildScrollView(child: Row(children: [])),
                    // ),
                  ),
                ),
                SliverFillRemaining(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      // Prevent scroll exvents from bubbling up to parent
                      return true;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FutureBuilder(
                        future: futures.getGames(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return SizedBox();
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 120,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.9,
                                  ),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var gameData = snapshot.data![index];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      16,
                                    ), // Adjust radius as needed
                                    child: Image.network(
                                      gameData.imgURL,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: _isNavAppBarHidden
                ? null
                : _bottomNavigationBar(),
            floatingActionButton: _isNavAppBarHidden
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
      },
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
        selectedItemColor: activeNavList.contains(navList[_currentIndex])
            ? Colors.blue
            : Colors.grey,
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
    width: 28,
    height: 28,
    color: isActive ? Colors.blue : Colors.grey,
  );
}
