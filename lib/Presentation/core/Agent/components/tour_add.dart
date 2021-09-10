import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/home_screen.dart';
import 'package:tourist_guide_app/bloc/agentBloc/agentBloc/agent_bloc.dart';

class TourAdd extends StatefulWidget {
  static const routeName = '/tourAdd';

  @override
  _TourAddState createState() => _TourAddState();
}

class _TourAddState extends State<TourAdd> {
  var _tourFormKey = GlobalKey<FormState>();

  List<DynamicWidget> whatIsIncluded = [];
  List<DynamicWidget> whatIsExcluded = [];
  List<DynamicWidget> whatToBring = [];

  List<DynamicWidget> itinerary = [];
  addWhatIsIncluded() {
    whatIsIncluded.add(new DynamicWidget());
    setState(() {});
  }

  addWhatIsExcluded() {
    whatIsExcluded.add(new DynamicWidget());
    setState(() {});
  }

  addWhatToBring() {
    whatToBring.add(new DynamicWidget());
    setState(() {});
  }

  addItinerary() {
    itinerary.add(new DynamicWidget());
    setState(() {});
  }

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  TextEditingController tourNameController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController regionController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController tourDescriptionController = TextEditingController();

  TextEditingController whatToIncludeController = TextEditingController();

  TextEditingController whatToExcludeController = TextEditingController();

  TextEditingController whatToBringController = TextEditingController();

  TextEditingController itineraryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Add tours",
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add tour'),
        ),
        body: Form(
          key: _tourFormKey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                _textField("Enter tour name", tourNameController),
                _textField("Enter country name", countryController),
                _textField("Enter region name", regionController),
                _textField("Enter city name", cityController),
                _textFieldWithCalendar(),
                _textFieldWithNumberKeyboard(
                    "Enter duration", durationController),
                _textFieldWithNumberKeyboard("Enter price", priceController),
                _multiLineText(tourDescriptionController),
                _textField("What to include", whatToIncludeController),
                _textField("What to exclude", whatToExcludeController),
                _textField("what to bring", whatToBringController),
                _textField("Itinerary", itineraryController),
                ElevatedButton(
                  onPressed: () {
                    if (!_tourFormKey.currentState.validate()) {
                      return;
                    }

                    _tourFormKey.currentState.save();
                    final AgentEvent event = CreateTour(
                      1,
                      Tour(
                        2,
                        tourNameController.text,
                        "Image",
                        countryController.text,
                        regionController.text,
                        cityController.text,
                        whatToIncludeController.text,
                        whatToExcludeController.text,
                        tourDescriptionController.text,
                        whatToBringController.text,
                        itineraryController.text,
                        int.parse(durationController.text),
                        dateController.text,
                        double.parse(priceController.text),
                        false,
                      ),
                    );
                    BlocProvider.of<AgentBloc>(context).add(event);
                    Navigator.pushNamed(context, AgentHome.routeName)
                  },
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldWithCalendar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: dateController,
        validator: (String value) {
          if (dateController.value.text.isEmpty) {
            return "Please insert data";
          }
          return null;
        },
        readOnly: true,
        decoration: InputDecoration(
            icon: Icon(Icons.calendar_today), //icon of text field
            labelText: "Enter Date" //label text of field
            ),
        onTap: () async {
          DateTime pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            dateController.text =
                formattedDate; //set output date to TextField value.
          });
        },
      ),
    );
  }

  Widget _addTourListView(List current) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: current.length,
        itemBuilder: (_, index) => current[index]);
  }

  Widget _expandedFields(Function func, String value) {
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(width: 100),
        FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            func();
          },
        ),
      ],
    );
  }
}

Widget _textFieldWithNumberKeyboard(
    String placeholder, TextEditingController controller) {
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      controller: controller,
      validator: (placeholder) {
        if (controller.value.text.isEmpty) {
          return "Please " + "${placeholder}";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "eg.50",
        labelText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
      ),
    ),
  );
}

Widget _textField(String placeholder, TextEditingController controller) {
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
      controller: controller,
      validator: (placeholder) {
        if (controller.value.text.isEmpty) {
          return "Please ${placeholder}";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
      ),
    ),
  );
}

Widget _multiLineText(TextEditingController controller) {
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
      maxLines: 6,
      controller: controller,
      validator: (value) {
        if (controller.value.text.isEmpty) {
          return "Please enter tour description";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Tour description goes here",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
      ),
    ),
  );
}

class DynamicWidget extends StatelessWidget {
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TextFormField(
        controller: controller,
        validator: (placeholder) {
          if (controller.value.text.isEmpty) {
            return "Please enter data";
          }
          return null;
        },
        decoration: new InputDecoration(hintText: "Enter Data"),
      ),
    );
  }
}

Widget _card() {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40), // if you need this
      side: BorderSide(
        color: Colors.grey.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Container(
      color: Colors.white,
      width: 100,
      height: 100,
      child: Text('What to include'),
    ),
  );
}
