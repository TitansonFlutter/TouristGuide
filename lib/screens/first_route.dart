import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide_app/screens/second_route.dart';

class FirstRoute extends StatelessWidget {
  static const routeName = '/';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('First Route'),
        ),
        body:
            ElevatedButton(
              child: Text('Todo1'),
              onPressed: () async {
                final String result =
                    await Navigator.push(ctx, MaterialPageRoute(builder: (ctx) {
                  return TodoOne();
                }));
                final snackBar = SnackBar(content: Text(result));
                _scaffoldKey.currentState!.showSnackBar(snackBar);
              },
            ),
          
        
        );
  }
}
