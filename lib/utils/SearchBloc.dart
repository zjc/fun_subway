import 'dart:async';

import 'package:fun_subway/business/beans/AssociationTagBean.dart';
import 'package:fun_subway/business/p/SearchPresenter.dart';
import 'package:fun_subway/utils/SearchState.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final Sink<String> onTextChanged;
  final Stream<SearchState> state;

  factory SearchBloc(SearchPresenter presenter) {
    final onTextChanged = PublishSubject<String>();
    final state = onTextChanged
        .distinct()
        .debounce(const Duration(milliseconds: 250))
        .switchMap<SearchState>((String term) {
          Stream<SearchState> stream = _search(term, presenter);
          return stream;
        })
        .startWith(SearchNoTerm())
        .onErrorResume((error) {
          print("rxdart on Error resume" + error.toString());
        });
    return SearchBloc._(onTextChanged, state);
  }

  SearchBloc._(this.onTextChanged, this.state);

  void dispose() {
    onTextChanged.close();
  }

  static Stream<SearchState> _search(
      String term, SearchPresenter presenter) async* {
    if (term.isEmpty) {
      yield SearchNoTerm();
    } else {
      yield SearchLoading();
      try {
        AssociationTagBean associationTagBean =
            await presenter.fetchAssociationByInputText(term);
        if (associationTagBean == null ||
            associationTagBean.tags == null ||
            associationTagBean.tags.isEmpty) {
          yield SearchEmpty();
        } else {
          yield SearchPopulated(associationTagBean.tags);
        }
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
