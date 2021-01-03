import 'dart:convert';

SearchResults homeFromMap(String str) => SearchResults.fromMap(json.decode(str));

String homeToMap(SearchResults data) => json.encode(data.toMap());

class SearchResults {
  SearchResults(
    this.batchcomplete,
    this.homeContinue,
    this.query,
    this.message
  );

  bool batchcomplete;
  Continue homeContinue;
  Query query;
  String message;
  int statusCode;

  SearchResults.fromMap(Map<String, dynamic> json) {
    this.batchcomplete = json["batchcomplete"] == null ? null : json["batchcomplete"];
    this.homeContinue = json["continue"] == null ? null : Continue.fromMap(json["continue"]);
    this.query = json["query"] == null ? null : Query.fromMap(json["query"]);
  }

  Map<String, dynamic> toMap() => {
    "batchcomplete": batchcomplete == null ? null : batchcomplete,
    "continue": homeContinue == null ? null : homeContinue.toMap(),
    "query": query == null ? null : query.toMap(),
  };

  SearchResults.fromError(String errorMsg, int statusCode){
    this.message = message;
    this.statusCode = statusCode;
  }
}

class Continue {
  Continue({
    this.gpsoffset,
    this.continueContinue,
  });

  final int gpsoffset;
  final String continueContinue;

  factory Continue.fromMap(Map<String, dynamic> json) => Continue(
    gpsoffset: json["gpsoffset"] == null ? null : json["gpsoffset"],
    continueContinue: json["continue"] == null ? null : json["continue"],
  );

  Map<String, dynamic> toMap() => {
    "gpsoffset": gpsoffset == null ? null : gpsoffset,
    "continue": continueContinue == null ? null : continueContinue,
  };
}

class Query {
  Query(
    this.redirects,
    this.pages,
  );

  List<Redirect> redirects;
  List<Pages> pages;

  Query.fromMap(Map<String, dynamic> json){
    this.redirects =
    json["redirects"] == null ? null : List<Redirect>.from(
        json["redirects"].map((x) => Redirect.fromMap(x)));

    this.pages = json["pages"] == null ? null : (json["pages"] as List).map((x) => Pages.fromMap(x)).toList();
  }

  Map<String, dynamic> toMap() => {
    "redirects": redirects == null ? null : List<dynamic>.from(redirects.map((x) => x.toMap())),
    "pages": pages == null ? null : List<dynamic>.from(pages.map((x) => x.toMap())),
  };
}

class Pages {
  Pages({
    this.pageid,
    this.ns,
    this.title,
    this.index,
    this.thumbnail,
    this.terms,
  });

  int pageid;
  int ns;
  String title;
  int index;
  Thumbnail thumbnail;
  Terms terms;

  Pages.fromMap(Map<String, dynamic> json){
    this.pageid = json["pageid"] == null ? null : json["pageid"];
    this.ns = json["ns"] == null ? null : json["ns"];
    this.title = json["title"] == null ? null : json["title"];
    this.index = json["index"] == null ? null : json["index"];
    this.thumbnail = json["thumbnail"] == null ? null : Thumbnail.fromMap(json["thumbnail"]);
    this.terms = json["terms"] == null ? null : Terms.fromMap(json["terms"]);
  }

  Map<String, dynamic> toMap() => {
    "pageid": pageid == null ? null : pageid,
    "ns": ns == null ? null : ns,
    "title": title == null ? null : title,
    "index": index == null ? null : index,
    "thumbnail": thumbnail == null ? null : thumbnail.toMap(),
    "terms": terms == null ? null : terms.toMap(),
  };
}

class Terms {
  Terms({
    this.description,
  });

  List<String> description;

  Terms.fromMap(Map<String, dynamic> json){
    this.description = json["description"] == null ? null : json["description"].map((x) => x).toList();

  }

  Map<String, dynamic> toMap() => {
    "description": description == null ? null : List<dynamic>.from(description.map((x) => x)),
  };
}

class Thumbnail {
  Thumbnail(
    this.source,
    this.width,
    this.height,
  );

  String source;
  int width;
  int height;

  Thumbnail.fromMap(Map<String, dynamic> json){
    this.source =
    json["source"] == null ? null : json["source"];
    this.width = json["width"] == null ? null : json["width"];
    this.height = json["height"] == null ? null : json["height"];
  }

  Map<String, dynamic> toMap() => {
    "source": source == null ? null : source,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
  };
}

class Redirect {
  Redirect({
    this.index,
    this.from,
    this.to,
  });

  final int index;
  final String from;
  final String to;

  factory Redirect.fromMap(Map<String, dynamic> json) => Redirect(
    index: json["index"] == null ? null : json["index"],
    from: json["from"] == null ? null : json["from"],
    to: json["to"] == null ? null : json["to"],
  );

  Map<String, dynamic> toMap() => {
    "index": index == null ? null : index,
    "from": from == null ? null : from,
    "to": to == null ? null : to,
  };
}
