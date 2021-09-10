import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/bloc/profile/bloc.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  static final String routeName = '/profile';
}

class _ProfileState extends State<Profile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool isObscurePassword = true;
  var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: FormKey,
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1)),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("../assets/images/avatar.png")),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: Colors.blue),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                buildTextField(
                    "User Name", "Biruk Ayalew", false, userNameController),
                buildEmailField("Email", "se.biruk.ayalew@gmail.com", false,
                    emailController),
                buildTextField(
                    "Password", "********", true, passwordController),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: Colors.black)),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (ctx, state) {
                        if (state is ProfileSuccess) {
                          try {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Successfully updated")));
                          } catch (e) {}
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                      builder: (ctx, state) {
                        return ElevatedButton(
                          onPressed: () {
                            if (!FormKey.currentState.validate()) {
                              return;
                            }
                            FormKey.currentState.save();
                            BlocProvider.of<ProfileBloc>(context).add(
                                EditProfile(User(
                                    0,
                                    emailController.text,
                                    userNameController.text,
                                    0,
                                    passwordController.text)));
                          },
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String Placeholder,
      bool isPAsswrodTextField, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
          controller: controller,
          obscureText: isPAsswrodTextField ? isObscurePassword : false,
          decoration: InputDecoration(
            suffixIcon: isPAsswrodTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 30),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: Placeholder,
            hintStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          validator: (String value) {
            if (value.isEmpty) {
              return "$labelText is Required";
            }
            if (labelText == "Password" && value.length < 8) {
              return "Password should be greater than 8";
            }
            return null;
          }),
    );
  }

  Widget buildEmailField(String labelText, String Placeholder,
      bool isPAsswrodTextField, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
          controller: controller,
          obscureText: isPAsswrodTextField ? isObscurePassword : false,
          decoration: InputDecoration(
            suffixIcon: isPAsswrodTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        isObscurePassword = !isObscurePassword;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 30),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: Placeholder,
            hintStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
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
          }),
    );
  }
}
