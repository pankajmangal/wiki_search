import 'dart:convert';

class SearchDetail {
  SearchDetail(
    this.batchcomplete,
    this.query,
    this.message
  );

  String batchcomplete;
  Query query;
  String message;
  int statusCode;

  SearchDetail.fromMap(Map<String, dynamic> json) {
    this.batchcomplete = json["batchcomplete"] == null ? null : json["batchcomplete"];
    this.query = json["query"] == null ? null : Query.fromMap(json["query"]);
  }

  SearchDetail.fromError(String errorMsg, int statusCode){
    this.message = message;
    this.statusCode = statusCode;
  }
}

class Query {
  Query(
    this.pages,
  );

  Pages pages;

  Query.fromMap(Map<String, dynamic> json){
    this.pages = json["pages"] == null ? null : Pages.fromMap(json["pages"]);
  }
}

class Pages {
  Pages({
    this.pageid,
    this.ns,
    this.title,
    this.extract,
  });

  int pageid;
  int ns;
  String title, extract;

  Pages.fromMap(Map<String, dynamic> json){
    for(var data in json.keys){
      this.pageid = json[data]["pageid"] == null ? null : json[data]["pageid"];
      this.ns = json[data]["ns"] == null ? null : json[data]["ns"];
      this.title = json[data]["title"] == null ? null : json[data]["title"];
      this.extract = json[data]["extract"] == null ? null : json[data]["extract"];
    }
  }

  Map<String, dynamic> toMap() => {
    "pageid": pageid == null ? null : pageid,
    "ns": ns == null ? null : ns,
    "title": title == null ? null : title,
    "extract": extract == null ? null : extract,
  };
}
