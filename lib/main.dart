import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_1/GenreScreen.dart';
import 'package:test_1/HomeScreen.dart';
import 'package:test_1/Favorite.dart';
import 'package:test_1/SettingsScreen.dart';
import 'package:test_1/SongScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test App",
      initialRoute: "/",
      routes: {
        "/": (context) => DefaultApp(),
        "/SongScreen": (context) => SongScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: Colors.black,
          accentColor: Color(0xFF940CFF)),
    );
  }
}

class DefaultApp extends StatefulWidget {
  const DefaultApp({Key? key}) : super(key: key);

  @override
  State<DefaultApp> createState() => _DefaultAppState();
}

class _DefaultAppState extends State<DefaultApp> {
  final screen = [
    HomeScreen(),
    GenreScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  int selectedIndex = 0;

  changeIndex(int currentIndex) {
    setState(() {
      selectedIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0XFF191626),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color(0xFF940CFF),
        unselectedItemColor: Color(0XFFAAAAAA),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(
              icon: Icon(Icons.album_outlined), label: "Genre"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Love"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: "Settings")
        ],
        currentIndex: selectedIndex,
        onTap: changeIndex,
      ),
    );
  }
}
