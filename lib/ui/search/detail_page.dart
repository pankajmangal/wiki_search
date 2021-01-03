import 'package:flutter/material.dart';
import 'package:wikipedia_search/utils/AppUtils.dart';
import 'package:wikipedia_search/utils/Gap.dart';

import 'bloc/search_detail_bloc.dart';

class DetailPage extends StatefulWidget {
  final String searchResult;
  DetailPage({@required this.searchResult});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final SearchDetailBloc searchDetailBloc = SearchDetailBloc();
  String titleExtract = "";
  String title = "";
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    searchDetailBloc.searchDetailFromWiki(widget.searchResult);

    searchDetailBloc.signUpStream.listen((event) {
      if (event.batchcomplete == "") {
        setState(() {
          titleExtract = event.query.pages.extract;
          title = event.query.pages.title;
          print('pages extract -> ');
        });
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    searchDetailBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    /*searchDetailBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              });
        } else {
          Navigator.pop(context);
        }
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back_rounded),
            onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(widget.searchResult),
      ),
      body: title != "" ? SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16.0, 16, 16, 0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),),
              VerticalGap(gap: 12),
              Expanded(
                child: Text(titleExtract,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16
                    )),
              ),
            ],
          ),
        ),
      )
      : Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
