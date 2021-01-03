import 'package:wikipedia_search/modal/search_detail.dart';
import 'package:wikipedia_search/modal/search_result.dart';

import 'api_provider.dart';

class Repository{

  final apiProvider = ApiProvider();

  Future<SearchResults> getSearchResults(String search) =>
      apiProvider.searchResultFromWiki(search);

  Future<SearchDetail> getSearchDetails(String searchResult) =>
      apiProvider.searchDetailFromWiki(searchResult);

}