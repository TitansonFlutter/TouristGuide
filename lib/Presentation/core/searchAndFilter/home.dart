import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Body(),
    debugShowCheckedModeBanner: false,
  ));
}

class Body extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Body> {
  static const historyLength = 5;

  List<String> _searchHistory = [
    'Lalibela',
    'Axum',
    'Gondar Fasil',
    'Hammer',
  ];

  late List<String> filteredSearchHistory;

  String selectedTerm = '';

  List<String> filterSearchTerms({
    @required String? filter,
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

  FloatingSearchBarController? controller;

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FloatingSearchBar(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(100),
          controller: controller,
          body: FloatingSearchBarScrollNotifier(
            child: SearchResultsListView(
              searchTerm: selectedTerm,
            ),
          ),
          transition: CircularFloatingSearchBarTransition(),
          physics: BouncingScrollPhysics(),
          title: Text(
            selectedTerm ?? 'Search Toursss',
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
            setState(() {
              filteredSearchHistory = filterSearchTerms(filter: query);
            });
          },
          onSubmitted: (query) {
            setState(() {
              addSearchTerm(query);
              selectedTerm = query;
            });
            controller!.close();
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4,
                child: Builder(
                  builder: (context) {
                    if (filteredSearchHistory!.isEmpty &&
                        controller!.query.isEmpty) {
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
                    } else if (filteredSearchHistory!.isEmpty) {
                      return ListTile(
                        title: Text(controller!.query),
                        leading: const Icon(Icons.search),
                        onTap: () {
                          setState(() {
                            addSearchTerm(controller!.query);
                            selectedTerm = controller!.query;
                          });
                          controller!.close();
                        },
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredSearchHistory!
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
                                    setState(() {
                                      deleteSearchTerm(term);
                                    });
                                  },
                                ),
                                onTap: () {
                                  setState(() {
                                    putSearchTermFirst(term);
                                    selectedTerm = term;
                                  });
                                  controller!.close();
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
        ),
      ),
    );
  }
}
