part of 'filterbloc_bloc.dart';

@immutable
abstract class FilterblocEvent {}

//Filter events

class FetchAllTours extends FilterblocEvent {}

class FetchTourByName extends FilterblocEvent {}

class Filter extends FilterblocEvent {}
