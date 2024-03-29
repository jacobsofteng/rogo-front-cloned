import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/language.dart';
import '../../../domain/usecases/get_all_languages_usecase.dart';

part 'languages_state.dart';

class LanguagesCubit extends Cubit<LanguagesState> {
  final GetAllLanguagesUseCase _getAllLanguagesUseCase;
  LanguagesCubit({
    required GetAllLanguagesUseCase getAllLanguagesUseCase,
  })  : _getAllLanguagesUseCase = getAllLanguagesUseCase,
        super(LanguagesState());

  void fetchLanguages() async {
    emit(state.copyWith(isLoading: true));
    final countriesResult = await _getAllLanguagesUseCase.call(LanguagesParams());
    countriesResult.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      final topLanguages = List<Language>.from(r.results.where((l) => l.isTop));
      emit(state.copyWith(languages: r.results, topLanguages: topLanguages, filteredLanguages: r.results));
    });
  }

  void selectUnselectLanguage(int languageId) {
    final language = state.languages.firstWhere((l) => l.id == languageId);
    List<Language> newSelectedLanguages = List.from(state.selectedLanguages);
    List<Language> newTopLanguages = List.from(state.topLanguages);
    if (state.selectedLanguages.contains(language)) {
      newSelectedLanguages.remove(language);
    } else {
      newSelectedLanguages.add(language);
      if (!state.topLanguages.contains(language)) {
        newTopLanguages.add(language);
      }
    }
    emit(state.copyWith(selectedLanguages: newSelectedLanguages, topLanguages: newTopLanguages));
  }

  void updateSearchPhrase(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(filteredLanguages: state.languages));
    } else {
      List<Language> newFilteredLanguages =
          List.from(state.languages.where((l) => l.name.toLowerCase().startsWith(value.toLowerCase())));
      emit(state.copyWith(searchPhrase: value, filteredLanguages: newFilteredLanguages));
    }
  }

  void clearSearch() {
    emit(state.copyWith(filteredLanguages: state.languages, searchPhrase: ''));
  }
}
