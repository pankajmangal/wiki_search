
import 'package:flutter/material.dart';
import 'package:wikipedia_search/data/local/db_provider.dart';
import 'package:wikipedia_search/route/route_constants.dart';
import 'package:wikipedia_search/utils/Gap.dart';
import 'package:wikipedia_search/modal/search_result.dart';

import 'bloc/search_result_bloc.dart';

List<String> searchResults = List();

class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {

  final SearchResultBloc searchResultBloc = SearchResultBloc();
  final TextEditingController searchController = TextEditingController();
  List<Pages> pages;
  List<String> recentSearches;
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    pages = List();
    recentSearches = List();
    _query();

    searchResultBloc.signUpStream.listen((event) {
      if (event.batchcomplete == true) {
        setState(() {
          pages = event.query.pages;
          print('pages length -> ${pages.length}');
        });
      } else {
        // AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    searchResultBloc.errorStream.listen((event) {
      // AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    /*searchResultBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          // AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xFFF2F2F2),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              VerticalGap(gap: 25),
              Card(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)
                ),
                elevation: 7.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (search){
                            if(search.isEmpty){
                              setState(() {
                                pages = [];
                              });
                            }else{
                              searchResultBloc.searchReasultsFromWiki(search);
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Search here.....",
                              hintStyle: TextStyle(
                                  fontSize: 14
                              ),
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 5)),
                        ),
                      ),
                      InkWell(
                        child: Icon(Icons.clear_rounded),
                        onTap: (){
                          setState(() {
                            searchController.text = "";
                            pages = [];
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),

              recentSearches.length == 0 ? Container() : Flexible(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VerticalGap(gap: 25),
                      Text("Recent Search",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                        ),),
                      VerticalGap(gap: 12),
                      Flexible(
                          child: ListView.builder(itemBuilder:
                              (context, index) => ListTile(
                            leading: Icon(Icons.search),
                            title: Text(recentSearches[index]),
                            onTap: (){
                              Navigator.pushNamed(context, searchDetail, arguments: recentSearches[index]);
                            },
                          ),
                            itemCount: recentSearches.length,))
                    ],
                  ),
                ),
              ),

              VerticalGap(gap: 25),
              /*pages.isEmpty ? Expanded(
                child: Container(
                  child: Center(
                    child: Text("No search result found !!"),
                  ),
                ),
              )
                  :*/ Expanded(
                  child: ListView.builder(itemBuilder:
                      (context, index) => ListTile(
                        leading: Icon(Icons.search),
                        title: Text(pages[index].title),
                        onTap: (){
                          _insert(pages[index].title);
                          Navigator.pushNamed(context, searchDetail, arguments: pages[index].title);
                        },
                      ),
                  itemCount: pages.length,))
            ],
          ),
        ),
      ),
    );
  }



  void _insert(String title) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle : title
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => recentSearches.add(row["title"]));
    setState(() {

    });
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnTitle : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
