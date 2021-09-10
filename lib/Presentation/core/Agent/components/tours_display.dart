import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/components/tour_add.dart';
import 'package:tourist_guide_app/appConstants.dart';
import 'package:tourist_guide_app/bloc/agentBloc/agentBloc/agent_bloc.dart';

class ToursDisplay extends StatelessWidget {
  // static const routName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Color(0xFF545D68)),
          onPressed: () {},
        ),
        title: Text(
          'Welcome Agent',
          style: TextStyle(
              fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<AgentBloc, AgentState>(
        builder: (context, state) {
          if (state is TourOperationFailure) {
            return Text("Could Not Load Agents");
          }
          if (state is TourOperationSuccess) {
            final tours = state.tours;
            return ListView.builder(
              itemCount: tours.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildCard(
                    "${tours.elementAt(index).tourName}",
                    "${tours.elementAt(index).tourDescription}",
                    "$url/agents/images/${tours.elementAt(index).tourImage}",
                    // "assets/images/main_top.png",
                    tours.elementAt(index).tourId,
                    context);
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, TourAdd.routeName);
        },
        backgroundColor: Color(0xFFF17532),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(
      String name, String email, String imgPath, int id, context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0)
              ],
              color: Colors.white),
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: imgPath,
                    child: Container(
                      height: 90.0,
                      width: 75.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(imgPath), fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(height: 7.0),
                        Text(name,
                            style: TextStyle(
                                color: Color(0xFF575E67),
                                fontFamily: 'Varela',
                                fontSize: 14.0)),
                        Text(email,
                            style: TextStyle(
                                color: Color(0xFFCC8053),
                                fontFamily: 'Varela',
                                fontSize: 14.0)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // set up the buttons
                        Widget cancelButton = TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        Widget continueButton = TextButton(
                          child: Text("Continue"),
                          onPressed: () {
                            BlocProvider.of<AgentBloc>(context)
                              ..add(DeleteTour(2, id));
                            Navigator.pop(context);
                          },
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Accept"),
                          content: Text(
                              "Are You sure you want to delete this Tour?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );

                        // show the dialog
                        showDialog(
                            context: context,
                            builder: (_) => alert,
                            barrierDismissible: false);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
