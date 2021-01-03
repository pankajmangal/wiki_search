import 'package:flutter/material.dart';
import 'package:wikipedia_search/route/route_constants.dart';
import 'package:wikipedia_search/ui/search/detail_page.dart';
import 'package:wikipedia_search/ui/search/search_result_page.dart';
import 'package:wikipedia_search/ui/splash/splash_page.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashLaunch:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case searchResult:
        return MaterialPageRoute(builder: (_) => SearchResultPage());
      case searchDetail:
        var searchResults = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DetailPage(searchResult: searchResults));


      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}