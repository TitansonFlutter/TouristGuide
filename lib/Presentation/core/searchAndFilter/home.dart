// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tourist_guide_app/Presentation/Models/Place.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/mainHome.dart';

import 'package:tourist_guide_app/bloc/FilterBloc/bloc/filterbloc_bloc.dart';

// void main(List<String> args) {
//   runApp(MaterialApp(
//     home: FilterScreenMain(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

class FilterScreenMain extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<FilterScreenMain> {
  static const historyLength = 5;
  final formKey = GlobalKey<FormState>();

  List<String> _searchHistory = [
    'Lalibela',
    'Axum',
    'Gondar Fasil',
    'Hammer',
  ];

  List<String> filteredSearchHistory;

  String selectedTerm;

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FilterblocBloc>(context);
    bloc.add(FetchAllTours());

    return Scaffold(
      body: FilterSearchBar(),
    );
  }

  Widget FilterSearchBar() {
    return FloatingSearchBar(
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(100),
      controller: controller,
      body: FloatingSearchBarScrollNotifier(
        child: BlocConsumer<FilterblocBloc, FilterblocState>(
          listener: (ctx, state) {
            print("state Consumer :" + state.toString());
          },
          builder: (context, state) {
            if (state is FilteredTours) {
              List<Tour> tours = state.tours;
              return FilterScreen(tours);
            }
            if (state is TourByNameFetched) {
              print(" STATE :" + state.toString());
              List<Tour> tours = state.tours;
              return FilterScreen(tours);
            }
            if (state is AllToursFetched) {
              return FilterScreen(state.tours);

              // searchTerm: selectedTerm,
            }
            if (state is Error) {
              // try {
              //   ScaffoldMessenger.of(context)
              //       .showSnackBar(SnackBar(content: Text(state.errorMsg)));
              // } catch (e) {}
              return Center(child: Text(state.errorMsg));
            }

            if (state is Loading) {
              print("Loading");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              );
            }

            return Center(child: Text("End of state"));
          },
        ),
      ),
      transition: CircularFloatingSearchBarTransition(),
      physics: BouncingScrollPhysics(),
      title: Text(
        selectedTerm ?? 'Search Tours',
        style: TextStyle(color: Colors.blue[900]),
      ),
      hint: 'Search and find out...',
      actions: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.blue[400],
          ),
          child: FloatingSearchBarAction.searchToClear(
            color: Colors.white,
          ),
        ),
      ],
      onQueryChanged: (query) {
        final bloc = BlocProvider.of<FilterblocBloc>(context);
        bloc.add(FetchTourByName(query));

        filteredSearchHistory = filterSearchTerms(filter: query);
      },
      onSubmitted: (query) {
        addSearchTerm(query);
        setState(() {
          selectedTerm = query;
        });
        final bloc = BlocProvider.of<FilterblocBloc>(context);
        bloc.add(FetchTourByName(selectedTerm));

        controller.close();
      },
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (filteredSearchHistory.isEmpty && controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'SEARCH FOR TOURS',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (filteredSearchHistory.isEmpty) {
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        addSearchTerm(controller.query);
                        selectedTerm = controller.query;
                        final bloc = BlocProvider.of<FilterblocBloc>(context);
                        bloc.add(FetchTourByName(selectedTerm));
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                deleteSearchTerm(term);
                              },
                            ),
                            onTap: () {
                              putSearchTermFirst(term);
                              selectedTerm = term;
                              final bloc =
                                  BlocProvider.of<FilterblocBloc>(context);
                              bloc.add(FetchTourByName(selectedTerm));

                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
