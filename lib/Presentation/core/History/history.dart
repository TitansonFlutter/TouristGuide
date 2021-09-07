import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/bloc/historyBloc/bloc.dart';

class HistoryPage extends StatelessWidget {
  static final String routeName = "/history";
  final index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Text(
              "Trips",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.black,
            indicatorWeight: 5.0,
            onTap: (index) {
              index = index;
              if (index == 0) {
                final historyBloc = BlocProvider.of<HistoryBloc>(context);
                historyBloc.add(UpcomingEvent(1));
              }
              if (index == 1) {
                final historyBloc = BlocProvider.of<HistoryBloc>(context);
                historyBloc.add(PastEvent(1));
              }
            },
            tabs: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Tab(
                  child: Container(
                    child: Text(
                      'UPCOMING',
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 30),
                child: Tab(
                  child: Container(
                    child: Text(
                      'PAST',
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocConsumer<HistoryBloc, HistoryState>(
                listener: (ctx, historySate) {},
                builder: (ctx, historySate) {
                  if (historySate is UpcomingState) {
                    final temp = historySate.tours;
                    return _buildListView(temp);
                  }
                  return Container();
                }),
            BlocConsumer<HistoryBloc, HistoryState>(
                listener: (ctx, historySate) {},
                builder: (ctx, historySate) {
                  if (historySate is PastState) {
                    final temp = historySate.tours;
                    return _buildListView(temp);
                  }
                  return Container();
                }),
          ],
        ),
      ),
    );
  }
}

ListView _buildListView(Iterable<Tour> tours) {
  return ListView.builder(
    itemCount: tours.length,
    itemBuilder: (BuildContext context, int index) {
      // return ListTile(
      //   title: Text("${agents.elementAt(index).username}"),
      //   subtitle: Text("${agents.elementAt(index).email}"),
      //   onTap: () {},
      return ListTile(
          leading: Icon(Icons.landscape),
          title: Text("${tours.elementAt(index).tourName}"),
          subtitle: Text("${tours.elementAt(index).tourDescription}"),
          trailing: Icon(Icons.favorite));
    },
  );
}
