import 'package:flutter/material.dart';
import 'file:///E:/MangalProjects/flutter_projects/wikipedia_search/lib/ui/search/search_result_page.dart';
import 'package:wikipedia_search/route/route_constants.dart';
import 'package:wikipedia_search/route/route_generator.dart';
import 'package:wikipedia_search/ui/splash/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: splashLaunch,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
