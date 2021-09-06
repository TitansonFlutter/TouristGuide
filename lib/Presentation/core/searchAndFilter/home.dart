import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:tourist_guide_app/Presentation/Models/Place.dart';
import 'package:tourist_guide_app/Presentation/components/app_bar.dart';
import 'package:tourist_guide_app/Presentation/components/hamburger_menu.dart';
import 'package:tourist_guide_app/Presentation/components/user_avatar.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/mainHome.dart';
import 'package:tourist_guide_app/Presentation/core/searchAndFilter/place_card.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: Body(),
    debugShowCheckedModeBanner: false,
  ));
}

class Body extends StatefulWidget {
  static final String routeName = "/filter";

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
        child: SearchResultsListView(
          searchTerm: selectedTerm,
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
        setState(() {
          filteredSearchHistory = filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          addSearchTerm(query);
          selectedTerm = query;
        });
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

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key key,
    @required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == '' || searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: HotelHomeScreen())
            // Icon(
            //   Icons.home,
            //   size: 64,
            // ),
            // Text(
            //   'Start searching',
            //   style: Theme.of(context).textTheme.headline5,
            // )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);

    return ListView(
      padding:
          EdgeInsets.only(top: fsb.value.height + fsb.value.margins.vertical),
      children: List.generate(
          10,
          (index) => Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  PlaceCard(
                    place: demoPlaces[0],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
    );
  }
}
