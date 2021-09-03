import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/core/Auth/Screens/Components/body.dart';

import 'package:tourist_guide_app/bloc/auth_bloc.dart';
import 'package:tourist_guide_app/dataProvider/authProvider/auth_data_provider.dart';
import 'package:tourist_guide_app/repository/auth_repository.dart';

void main() {
  runApp(MyApp());
}

final authRepo = AuthRepository(AuthDataProvider());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (ctx) => AuthBloc(authRepo))],
      child: MaterialApp(
        title: 'Travel App UI',
        debugShowCheckedModeBanner: false,
        home: LogInBody(),
      ),
    );
  }
}
