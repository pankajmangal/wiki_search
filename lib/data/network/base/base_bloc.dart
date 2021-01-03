import '../repository.dart';

abstract class BaseBloc {
  final repository = Repository();

  void dispose() {}
}