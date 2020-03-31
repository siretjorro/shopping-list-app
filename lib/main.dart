import 'package:flutter/material.dart';
import 'package:shopping_list_app/screens/shopping_list.dart';
import 'screens/archive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_list_app/res/strings.dart' as Strings;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.APP_NAME,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[500],
        accentColor: Colors.blueAccent,

        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              // indicatorColor: Color(0xff1f7a1f),
              tabs: [
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.history)),
              ],
            ),
            title: Text(Strings.APP_NAME),
            // backgroundColor: Color(0xffadebad),
          ),
          body: TabBarView(
            children: [
              ShoppingList(),
              Archive(),
            ],
          ),
        ),
      ),
    );
  }
}
