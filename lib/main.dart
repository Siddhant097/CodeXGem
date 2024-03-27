import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Online.dart';
import 'package:flutter_application_1/pages/conteststanding.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/homepage.dart';
import 'package:flutter_application_1/pages/problemset.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        initialRoute: '/', // Initial route
        onGenerateRoute: (routeSettings) {
          switch (routeSettings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => HomePages());
            case '/online':
              return MaterialPageRoute(builder: (context) => Online());
              case '/home_page':
              return MaterialPageRoute(builder: (context) => HomePage());
            case '/problemset': // Corrected the typo here
              return MaterialPageRoute(builder: (context) => ProblemSet());
            case '/conteststanding': // Corrected the typo here
              return MaterialPageRoute(builder: (context) => ContestStanding());
            // case '/contesthacks': // Corrected the typo here
            //   return MaterialPageRoute(builder: (context) => ContestHacks());
            default:
              return null;
          }
        },
      ),
      theme: ThemeData(
          fontFamily: 'PressStart',
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey.shade900,
          primaryColor: Colors.grey.shade900),
    );
  }
}
