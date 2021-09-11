import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/home_screen.dart';
import 'package:tourist_guide_app/Routes/routes.dart';
import 'package:tourist_guide_app/SharedSimplePreference.dart';
import 'package:tourist_guide_app/bloc/agentBloc/agentBloc/agent_bloc.dart';
import 'dart:io';

class TourAdd extends StatefulWidget {
  static const routeName = '/tourAdd';
  final TourArgument args;

  TourAdd(this.args);

  @override
  _TourAddState createState() => _TourAddState(args);
}

class _TourAddState extends State<TourAdd> {
  var _tourFormKey = GlobalKey<FormState>();

  final TourArgument editing;

  XFile _imageFile;

  dynamic photoError;

  final ImagePicker _picker = ImagePicker();

  _TourAddState(this.editing);

  @override
  void initState() {
    if (widget.args.edit) {
      tourNameController.text = widget.args.tour.tourName;
      countryController.text = widget.args.tour.country;
      regionController.text = widget.args.tour.region;
      cityController.text = widget.args.tour.city;
      dateController.text = widget.args.tour.startingDate;
      durationController.text = widget.args.tour.duration.toString();
      priceController.text = widget.args.tour.price.toString();
      tourDescriptionController.text = widget.args.tour.tourDescription;
      whatToIncludeController.text = widget.args.tour.whatToInclude;
      whatToExcludeController.text = widget.args.tour.whatToExclude;
      whatToBringController.text = widget.args.tour.whatToBring;
      itineraryController.text = widget.args.tour.itinerary;
    }

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('${widget.args.edit ? "Edit Tour" : "Add tour"}'),
        ),
        body: Form(
          key: _tourFormKey,
          child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    widget.args.edit
                        ? Text(
                            // widget.args.tour.tourName,
                            "",
                            style: TextStyle(fontSize: 30),
                          )
                        : imageProfile(),
                    _textField(
                      "Enter tour name",
                      tourNameController,
                      "TourName",
                    ),
                    _textField(
                      "Enter country name",
                      countryController,
                      "Country",
                    ),
                    _textField(
                      "Enter region name",
                      regionController,
                      "Region",
                    ),
                    _textField(
                      "Enter city name",
                      cityController,
                      "City",
                    ),
                    _textFieldWithCalendar(),
                    _textFieldWithNumberKeyboard(
                      "Duration",
                      durationController,
                    ),
                    _textFieldWithNumberKeyboard(
                      "Price",
                      priceController,
                    ),
                    _multiLineText(
                      tourDescriptionController,
                    ),
                    _textField(
                      "What to include",
                      whatToIncludeController,
                      "What To Include",
                    ),
                    _textField(
                      "What to exclude",
                      whatToExcludeController,
                      "What To Exclude",
                    ),
                    _textField(
                      "what to bring",
                      whatToBringController,
                      "What To Bring",
                    ),
                    _textField(
                      "Itinerary",
                      itineraryController,
                      "Itinerary",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (!_tourFormKey.currentState.validate()) {
                          return;
                        }

                        _tourFormKey.currentState.save();
                        final AgentEvent event = widget.args.edit
                            ? UpdateTour(
                                UserSimplePreferences.getUser().userId,
                                widget.args.tour.tourId,
                                Tour(
                                  UserSimplePreferences.getUser().userId,
                                  tourNameController.text,
                                  widget.args.tour.tourImage,
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
                              )
                            : CreateTour(
                                UserSimplePreferences.getUser().userId,
                                Tour(
                                  1,
                                  tourNameController.text,
                                  "${_imageFile.name}",
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
                                "${_imageFile.path}");

                        BlocProvider.of<AgentBloc>(context).add(event);

                        Navigator.pushNamed(context, AgentHome.routeName);
                      },
                      child: editing.edit ? Text("UPDATE") : Text("ADD"),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/images/avatar.png")
              : FileImage(File(_imageFile.path)),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    try {
      final XFile pickedFile = await _picker.pickImage(
        source: source,
      );
      print(pickedFile.name);

      setState(() {
        // print(Picked);
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        photoError = e;
      });
    }
  }

  Widget _textFieldWithCalendar() {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        // initialValue: editing.edit ? " " : name,
        controller: dateController,
        validator: (String value) {
          if (dateController.value.text.isEmpty) {
            return "Please insert date";
          }
          return null;
        },
        readOnly: true,
        decoration: InputDecoration(
          icon: Icon(Icons.calendar_today), //icon of text field
          labelText: "Enter Date",
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          )), //label text of field
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

  Widget _textFieldWithNumberKeyboard(
      String placeholder, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        // initialValue: editing.edit ? " " : name,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return "Can't be Empty";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "eg.10",
          labelText: placeholder,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          )),
        ),
      ),
    );
  }

  Widget _textField(
      String placeholder, TextEditingController controller, String label) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        // initialValue: editing.edit ? " " : name,
        validator: (value) {
          if (value.isEmpty) {
            return "Can't be Empty";
          }
          return null;
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          )),
          // prefixIcon: Icon(
          //   Icons.person,
          //   color: Colors.orange,
          // ),
          labelText: "$label",
          hintText: "$placeholder",
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
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Colors.teal,
          )),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
          ),
        ),
      ),
    );
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
}
