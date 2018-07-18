class SearchState{

}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchNoTerm extends SearchState {}

class SearchPopulated extends SearchState {
  final List<String> result;

  SearchPopulated(this.result);
}

class SearchEmpty extends SearchState {}