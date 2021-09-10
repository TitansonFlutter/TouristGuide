import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/Presentation/core/admin/home_screen.dart';

import '../../../../bloc/adminBlocs/bloc.dart';

class AgentAdd extends StatelessWidget {
  static const String routeName = '/agentAdd';

  // const AgentCardView({ Key? key }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Demo")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildEmail(),
                _buildPassword(),
                // _builURL(),
                // _buildPhoneNumber(),
                // _buildCalories(),
                SizedBox(height: 100),
                ElevatedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    final AdminEvent event = CreateAgent(
                      User(
                        0,
                        emailController.text,
                        userNameController.text,
                        1,
                        passwordController.text,
                      ),
                    );
                    Navigator.pushNamed(context, AdminHome.routeName);

                    BlocProvider.of<AdminBloc>(context).add(event);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildCard(String name, String price, String imgPath, bool added,
  //     bool isFavorite, context) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),

  //       child: Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(15.0),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.grey.withOpacity(0.2),
  //                   spreadRadius: 3.0,
  //                   blurRadius: 5.0)
  //             ],
  //             color: Colors.white),
  //         child: Column(
  //           children: [
  //             Padding(
  //                 padding: EdgeInsets.all(5.0),
  //                 child:
  //                     Row(mainAxisAlignment: MainAxisAlignment.end, children: [
  //                   isFavorite
  //                       ? Icon(Icons.favorite, color: Color(0xFFEF7532))
  //                       : Icon(Icons.favorite_border, color: Color(0xFFEF7532))
  //                 ])),
  //             Hero(
  //                 tag: imgPath,
  //                 child: Container(
  //                     height: 75.0,
  //                     width: 75.0,
  //                     decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                             image: AssetImage(imgPath),
  //                             fit: BoxFit.contain)))),
  //             SizedBox(height: 7.0),
  //             Text(price,
  //                 style: TextStyle(
  //                     color: Color(0xFFCC8053),
  //                     fontFamily: 'Varela',
  //                     fontSize: 14.0)),
  //             Text(name,
  //                 style: TextStyle(
  //                     color: Color(0xFF575E67),
  //                     fontFamily: 'Varela',
  //                     fontSize: 14.0)),
  //             Padding(
  //                 padding: EdgeInsets.all(8.0),
  //                 child: Container(color: Color(0xFFEBEBEB), height: 1.0)),
  //             Padding(
  //               padding: EdgeInsets.only(left: 5.0, right: 5.0),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   if (!added) ...[
  //                     Icon(Icons.shopping_basket,
  //                         color: Color(0xFFD17E50), size: 12.0),
  //                     Text('Add to cart',
  //                         style: TextStyle(
  //                             fontFamily: 'Varela',
  //                             color: Color(0xFFD17E50),
  //                             fontSize: 12.0))
  //                   ],
  //                   if (added) ...[
  //                     Icon(Icons.remove_circle_outline,
  //                         color: Color(0xFFD17E50), size: 12.0),
  //                     Text('3',
  //                         style: TextStyle(
  //                             fontFamily: 'Varela',
  //                             color: Color(0xFFD17E50),
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 12.0)),
  //                     Icon(Icons.add_circle_outline,
  //                         color: Color(0xFFD17E50), size: 12.0),
  //                   ]
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      maxLength: 10,
      validator: (String value) {
        if (value.isEmpty && value != null) {
          return 'Name is Required';
        }

        return null;
      },
      controller: userNameController,
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      controller: emailController,
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }

        return null;
      },
      controller: passwordController,
    );
  }

  // Widget _builURL() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Url'),
  //     keyboardType: TextInputType.url,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'URL is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _url = value;
  //     },
  //   );
  // }

  // Widget _buildPhoneNumber() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Phone number'),
  //     keyboardType: TextInputType.phone,
  //     validator: (String value) {
  //       if (value.isEmpty) {
  //         return 'Phone number is Required';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _url = value;
  //     },
  //   );
  // }

  // Widget _buildCalories() {
  //   return TextFormField(
  //     decoration: InputDecoration(labelText: 'Calories'),
  //     keyboardType: TextInputType.number,
  //     validator: (String value) {
  //       int calories = int.tryParse(value);

  //       if (calories == null || calories <= 0) {
  //         return 'Calories must be greater than 0';
  //       }

  //       return null;
  //     },
  //     onSaved: (String value) {
  //       _calories = value;
  //     },
  //   );
  // }
}
