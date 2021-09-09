import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/Models/review_model.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/bloc/featuresBloc/bloc.dart';
import 'package:tourist_guide_app/dataProvider/featureDataProvider/features_data_provider.dart';
import 'package:tourist_guide_app/repository/features_repository.dart';
import 'tour_app_theme.dart';

class TourInfoScreen extends StatefulWidget {
  final Tour tour;
  TourInfoScreen(this.tour);
  static final String routeName = "/tourDetail";

  @override
  _TourInfoScreenState createState() => _TourInfoScreenState(tour);
}

class _TourInfoScreenState extends State<TourInfoScreen>
    with TickerProviderStateMixin {
  final Tour tour;
  bool reviewed = false;
  bool booked = false;

  TextEditingController _comment = TextEditingController();

  _TourInfoScreenState(this.tour);
  final double infoHeight = 700.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  final FeaturesRepository featuresRepository =
      FeaturesRepository(FeaturesDataProvider());
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.featuresRepository,
      child: BlocProvider(
        create: (context) => FeaturesBloc(this.featuresRepository)
          ..add(LoadReviews(tour.tourId, 2)),
        child: Container(
          color: TourAppTheme.nearlyWhite,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.network(
                          "http://10.6.250.16:5000/api/agents/images/${tour.tourImage}"),
                    ),
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: TourAppTheme.nearlyWhite,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: TourAppTheme.grey.withOpacity(0.2),
                            offset: const Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: IntrinsicHeight(
                          // constraints: BoxConstraints(
                          //     minHeight: infoHeight,
                          //     maxHeight: tempHeight > infoHeight
                          //         ? tempHeight
                          //         : infoHeight),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 32.0, left: 18, right: 16),
                                child: Text(
                                  tour.tourName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    letterSpacing: 0.27,
                                    color: TourAppTheme.darkerText,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 8, top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '\$${tour.price}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 22,
                                        letterSpacing: 0.27,
                                        color: TourAppTheme.nearlyBlue,
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            '${tour.price}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 22,
                                              letterSpacing: 0.27,
                                              color: TourAppTheme.grey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: TourAppTheme.nearlyBlue,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Center(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        getFlatLabels('${tour.city}', 'City'),
                                        getFlatLabels(
                                            '${tour.duration} Days', 'Time'),
                                        getFlatLabels(
                                            '${tour.country}', 'Country'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'Description',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.25,
                                        color: TourAppTheme.darkerText,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      '${tour.tourDescription}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: TourAppTheme.grey,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'What To Include',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 22,
                                        letterSpacing: 0.25,
                                        color: TourAppTheme.darkerText,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      '${tour.whatToInclude}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: TourAppTheme.grey,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'Image: ${tour.tourImage}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: TourAppTheme.grey,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 8, bottom: 8),
                                    child: Text(
                                      'Date: ${tour.startingDate.split(" ")[0]}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        fontSize: 14,
                                        letterSpacing: 0.27,
                                        color: TourAppTheme.grey,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 500),
                                  opacity: opacity2,
                                  child: Center(
                                    child: Text(
                                      'Reviews',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        letterSpacing: 0.25,
                                        color: TourAppTheme.darkerText,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                              BlocBuilder<FeaturesBloc, FeaturesState>(
                                  builder: (context, state) {
                                print("State: $state");
                                if (state is FeaturesOperationFailure) {
                                  return Center(
                                    child: Text(
                                      "No Reiews Yet",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15),
                                    ),
                                  );
                                }
                                if (state is BookStatusSuccess) {
                                  booked = true;
                                  return Container();
                                }
                                if (state is ReviewOperationSuccess) {
                                  int user = 2;
                                  final reviews = state.reviews;
                                  for (var i = 0; i < reviews.length; i++) {
                                    if (reviews.elementAt(i).userId == user) {
                                      reviewed = true;
                                    }
                                  }
                                  List<Item> data =
                                      getReviewList(reviews.length, reviews);
                                  return ExpansionPanelList(
                                    expansionCallback:
                                        (int index, bool isExpanded) {
                                      setState(() {
                                        data[index].isExpanded = !isExpanded;
                                      });
                                    },
                                    animationDuration: Duration(seconds: 1),
                                    dividerColor: Colors.teal,
                                    elevation: 2,
                                    children:
                                        data.map<ExpansionPanel>((Item item) {
                                      return ExpansionPanel(
                                          headerBuilder:
                                              (context, bool isExpanded) {
                                            return ListTile(
                                                leading: Icon(Icons.person),
                                                title: Text(item.headerValue));
                                          },
                                          // canTapOnHeader: true,
                                          body: ListTile(
                                            title: Text(
                                                "Comment: ${item.expandedValue}"),
                                            subtitle:
                                                Text("Rating: ${item.rating}"),
                                          ),
                                          isExpanded: item.isExpanded);
                                    }).toList(),
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
                              SizedBox(
                                height: 16,
                              ),
                              Center(
                                child: booked & !reviewed
                                    ? Form(
                                        child: Column(
                                          children: [
                                            aboutTextField(),
                                            ElevatedButton(
                                              child: Text('Review'),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                      )
                                    : Text(""),
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: opacity3,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 16, right: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Center(
                                        child: booked & reviewed
                                            ? Container(
                                                child: Text(
                                                  "Already Reviewed",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 17),
                                                ),
                                              )
                                            : Container(child: Text("")),
                                      ),
                                      Center(
                                        child: !booked & !reviewed
                                            ? ElevatedButton.icon(
                                                icon: Icon(Icons.bookmark),
                                                label: Text('Book'),
                                                onPressed: () {
                                                  if (reviewed) {}
                                                },
                                              )
                                            : Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).padding.bottom,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 20.0 - 20,
                  right: 35,
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: CurvedAnimation(
                        parent: animationController,
                        curve: Curves.fastOutSlowIn),
                    child: Card(
                      color: TourAppTheme.nearlyBlack,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)),
                      elevation: 8.0,
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Center(
                          child: Icon(
                            Icons.push_pin,
                            color: TourAppTheme.nearlyWhite,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                            AppBar().preferredSize.height),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: TourAppTheme.nearlyBlack,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Item> getReviewList(int len, Iterable<Review> reviews) {
    return List.generate(len, (index) {
      return Item(
        headerValue: "${reviews.elementAt(index).name}",
        expandedValue: "${reviews.elementAt(index).comment}",
        rating: reviews.elementAt(index).rate,
      );
    });
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _comment,
      validator: (value) {
        if (value.isEmpty) return "Review can't be empty";

        return null;
      },
      maxLines: 3,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: TourAppTheme.nearlyBlack,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: TourAppTheme.nearlyBlue,
          width: 2,
        )),
        labelText: "Leave Your Review Here",
        helperText: "What Do You thik",
        hintText: "It was an awsome trip",
      ),
    );
  }

  Widget getFlatLabels(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: TourAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: TourAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: TourAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: TourAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  double rating;
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Item(
      {this.expandedValue,
      this.headerValue,
      this.rating,
      this.isExpanded = true});
}
