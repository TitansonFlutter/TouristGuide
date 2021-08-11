import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: ElevatedButton(
        onPressed: () {
// Navigate back to first route when tapped.
          Navigator.pop(ctx, 'Data from Second Route');
        },
        child: Text('Go back!'),
      ),
    );
  }
}

class TodoOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("this is the first to do"),
      ),
      body: Text("this is the first to do"),
    );
  }
}

class TodoTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("this is the second to do"),
      ),
      body: Text("this is the second to do lorem epsou jdjdj"),
    );
  }
}
