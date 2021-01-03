
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:wikipedia_search/modal/search_detail.dart';
import 'package:wikipedia_search/modal/search_result.dart';

class ApiProvider{

  final Dio _dioClient = Dio(
      BaseOptions(
          baseUrl: "https://en.wikipedia.org//w/api.php",
          headers: {
            'Appversion': '1.0',
            'Ostype': Platform.isAndroid ? 'ANDRIOD' : 'ios'
          }))..interceptors.add(PrettyDioLogger());

  Future<SearchResults> searchResultFromWiki(String search) async {

    final map = {
      "action": "query",
      "format": "json",
      "prop": "pageimages%7Cpageterms",
      "generator": "prefixsearch",
      "redirects": "1",
      "formatversion": "2",
      "piprop": "thumbnail",
      "pithumbsize": "50",
      "pilimit": "10",
      "wbptterms": "description",
      "gpssearch": search,
      "gpslimit": "10"
    };

    print("register -> $map");
    try {
      Response response = await _dioClient.get("", queryParameters: map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['batchcomplete']}");
        if (json['batchcomplete'] == true)
          return SearchResults.fromMap(json);
        else
          return SearchResults.fromError(json['message'], response.statusCode);
      } else {
        return SearchResults.fromError("No data", 396);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return SearchResults.fromError("$e", 397);
    }
  }

  //https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&titles=Stack%20Overflow
  Future<SearchDetail> searchDetailFromWiki(String searchResult) async {

    final map = {
      "action": "query",
      "format": "json",
      "prop": "extracts",
      "redirects": "1",
      "exintro": "",
      "explaintext": "",
      "titles": searchResult,
    };

    print("register -> $map");
    try {
      Response response = await _dioClient.get("", queryParameters: map);
      dynamic json = jsonDecode(response.toString());
      print(response.data);
      if (response.data != "") {
        print("dataValue :- ${json['batchcomplete']}");
        if (json['batchcomplete'] == "")
          return SearchDetail.fromMap(json);
        else
          return SearchDetail.fromError(json['message'], response.statusCode);
      } else {
        return SearchDetail.fromError("No data", 396);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      var e = error;
      if (error is DioError) {
        e = getErrorMsg(e.type);
      }
      return SearchDetail.fromError("$e", 397);
    }
  }

  String getErrorMsg(DioErrorType type) {
    switch (type) {
      case DioErrorType.CONNECT_TIMEOUT:
        return "Connection timeout";
        break;
      case DioErrorType.SEND_TIMEOUT:
        return "Send timeout";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        return "Receive timeout";
        break;
      case DioErrorType.RESPONSE:
        return "Response timeout";
        break;
      case DioErrorType.CANCEL:
        return "Request has been cancelled";
        break;
      case DioErrorType.DEFAULT:
        return "Could not connect";
        break;
      default:
        return "Something went wrong";
        break;
    }
  }
}