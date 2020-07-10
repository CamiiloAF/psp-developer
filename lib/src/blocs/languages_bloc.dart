import 'package:psp_developer/src/models/languages_model.dart';
import 'package:psp_developer/src/repositories/languages_repository.dart';
import 'package:psp_developer/src/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

class LanguagesBloc {
  final _languagesRepository = LanguagesRepository();

  final _languagesController =
      BehaviorSubject<Tuple2<int, List<LanguageModel>>>();

  Stream<Tuple2<int, List<LanguageModel>>> get languagesStream =>
      _languagesController.stream;

  Tuple2<int, List<LanguageModel>> get lastValueLanguagesController =>
      _languagesController.value;

  void getLanguages(bool isRefreshing) async {
    final languagesWithStatusCode =
        await _languagesRepository.getAllLanguages(isRefreshing);
    _languagesController.sink.add(languagesWithStatusCode);
  }

  String getLanguageNameById(int languageId) {
    final languages = lastValueLanguagesController.item2;

    if (isNullOrEmpty(languages)) return '';

    final language = languages.firstWhere((element) => element.id == languageId,
        orElse: () => LanguageModel());

    return language.name ?? '';
  }

  void dispose() => _languagesController.sink.add(null);
}
