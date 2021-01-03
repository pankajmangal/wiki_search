
import 'package:rxdart/rxdart.dart';
import 'package:wikipedia_search/data/network/base/base_bloc.dart';
import 'package:wikipedia_search/modal/search_result.dart';

class SearchResultBloc extends BaseBloc {
  final _signUpStream = PublishSubject<SearchResults>();
  final _loadingStream = PublishSubject<bool>();
  final _errorStream = PublishSubject<Error>();

  Stream<SearchResults> get signUpStream => _signUpStream.stream;

  Stream<bool> get loadingStream => _loadingStream.stream;

  Stream<Error> get errorStream => _errorStream.stream;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _signUpStream?.close();
    _loadingStream?.close();
    _errorStream?.close();
  }

  void searchReasultsFromWiki(String searching) async {
    print("calling");
    if (isLoading) return;
    isLoading = true;
    _loadingStream.sink.add(true);
    SearchResults searchResults = await repository.getSearchResults(searching);
    isLoading = false;
    _loadingStream.sink.add(isLoading);
    _signUpStream.sink.add(searchResults);
  }
}
