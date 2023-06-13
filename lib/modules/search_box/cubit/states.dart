abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class SearchLoadingState extends SearchStates{}

class SearchSuccessState  extends SearchStates{}

class SearchErrorState extends SearchStates{}

class SearchDeleteCurrentResultsState extends SearchStates{}

class SearchForEmptyTextState extends SearchStates{}

class CheckForSearchResultsState extends SearchStates{}