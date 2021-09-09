import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TourAdd extends StatefulWidget {

  @override
  _TourAddState createState() => _TourAddState();
}

class _TourAddState extends State<TourAdd> {

    var _tourFormKey = GlobalKey<FormState>();

    List<DynamicWidget> WhatIsIncluded  = [];
    List<DynamicWidget> WhatIsExcluded  = [];
    List<DynamicWidget> WhatToBring  = [];

    List<DynamicWidget> Itinerary  = [];
    addWhatIsIncluded(){
      WhatIsIncluded.add(new DynamicWidget());
      setState(() {
      });
    }
    addWhatIsExcluded(){
      WhatIsExcluded.add(new DynamicWidget());
      setState(() {
      });
    }
    addWhatToBring(){
      WhatToBring.add(new DynamicWidget());
      setState(() {
      });
    }
    addItinerary(){
      Itinerary.add(new DynamicWidget());
      setState(() {
      });
    }

  
  TextEditingController tourNameController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController regionController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController durationController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController tourDescriptionController = TextEditingController();


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
              
                  _textField("Enter tour name",tourNameController),
                  _textField("Enter country name",countryController),
                  _textField("Enter region name",regionController),
                  _textField("Enter city name",cityController),
                  _textFieldWithNumberKeyboard("Enter duration",durationController),
                  _textFieldWithNumberKeyboard("Enter price",priceController),
                  _multiLineText(tourDescriptionController),
                  _expandedFields(addWhatIsIncluded,"What to include"),
                 
                  _addTourListView(WhatIsIncluded),
                  _expandedFields(addWhatIsExcluded,"What to exclude"),
                  _addTourListView(WhatIsExcluded),
                  _expandedFields(addWhatToBring,"What to bring"),
                  _addTourListView(WhatToBring),
                  _expandedFields(addItinerary,"Itinerary"),
                  _addTourListView(Itinerary),
                  ElevatedButton(
                      onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (!_tourFormKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                      }_tourFormKey.currentState.save();
                      },
                      child: Text("Submit"),
                    ),
                              
                  
                  
              ],
            ),
          ),
        ),
        
      ),
    );
  }

  // Widget _tourSubmit(){
  //   List tour = [];
  // }

  Widget _addTourListView(List current){
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: current.length,
      itemBuilder: (_, index) => current[index]
    );
  }
  Widget _expandedFields(Function func,String value){
  return Row(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 25),
          ),
        SizedBox(width: 100),
        FloatingActionButton(
            child: Icon(
              Icons.add
        ),
        onPressed: () {
          func();
        },
      ),
        
      ],
    );
}

  
}
Widget _textFieldWithNumberKeyboard(String placeholder,TextEditingController controller){
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
        inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
            ],
        controller: controller,
        validator: (placeholder){
          if(controller.value.text.isEmpty){
            return "Please " + "${placeholder}";
          }
        },
        decoration: InputDecoration(
          hintText: "eg.50",
          labelText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35)
          ),
        ),
      ),
  );
}
Widget _textField(String placeholder,TextEditingController controller){
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
        controller: controller,
        validator: (placeholder){
          if(controller.value.text.isEmpty){
            return "Please ${placeholder}";
          }
          
        },
        decoration: InputDecoration(
          labelText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35)
          ),
        ),
      ),
  );
}
Widget _multiLineText(TextEditingController controller){
  return Container(
    padding: EdgeInsets.all(10),
    child: TextFormField(
      maxLines: 6,
        controller: controller,
        validator: (value){
          if(controller.value.text.isEmpty){
            return "Please enter tour description";
          }
        },
        decoration: InputDecoration(
          labelText: "Tour description goes here",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35)
          ),
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
        validator: (placeholder){
          if(controller.value.text.isEmpty){
            return "Please enter data";
          }
        },
        decoration: new InputDecoration(hintText: "Enter Data"),
      ),
      
    );
  }
}

// child: Icon(Icons.android,size: 60, color: Colors.grey[800]),
// decoration: BoxDecoration(
//   colors: Colors.grey[300],
//   shape: BoxShape.circle,
//   boxShadow: [
//     BoxShadow(
//       color: Offset(4.0,4.0),
//       blurRadius: 15.0,
//       spreadRadius: 1.0),
//     BoxShadow(
//       color: Colors.white,
//       offset: Offset(-4.0,-4.0),
//       blurRadius: 15.0,
//       spreadRadius: 1.0),
    
//   ],
// ),
Widget _card(){
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


