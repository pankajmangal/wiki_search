import 'package:flutter/material.dart';

class WikiSearch extends SearchDelegate<String>{

  final searchSuggestion = [
    "virat kholi",
    "india",
    "Sachin T"
  ];

  final recentSuggesion = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [ IconButton(
      icon: Icon(Icons.clear),
      onPressed: (){
        query = "";
      },
    )];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,
    ), onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // query.isNotEmpty ? searchResultBloc.searchReasultsFromWiki(query) : null;
    final suggestionList = query.isEmpty ? recentSuggesion : searchSuggestion;
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      leading: Icon(Icons.search),
      title: Text(suggestionList[index]),
    ),
      itemCount: suggestionList.length,);
  }

}