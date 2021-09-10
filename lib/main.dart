import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/welcomePage.dart';
import 'package:tourist_guide_app/Presentation/core/admin/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Routes/routes.dart';

import 'package:tourist_guide_app/bloc/auth_bloc.dart';
import 'package:tourist_guide_app/dataProvider/authProvider/auth_data_provider.dart';
import 'package:tourist_guide_app/dataProvider/history_data_provider.dart';
import 'package:tourist_guide_app/repository/adminRepository/admin_repository.dart';
import 'package:tourist_guide_app/repository/auth_repository.dart';
import 'package:tourist_guide_app/repository/filter_repository.dart';
import 'package:tourist_guide_app/repository/history_repository.dart';

import 'bloc/FilterBloc/bloc/filterbloc_bloc.dart';
import 'bloc/adminBlocs/admin_bloc_bloc.dart';
import 'bloc/historyBloc/history_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'dataProvider/adminDataProviders/admin_data_providers.dart';
import 'dataProvider/filterDataProvider/filter_data_provider.dart';

void main() {
  runApp(MyApp());
}

final authRepo = AuthRepository(AuthDataProvider());
final filterRepo = FilterRepository(FilterDataProvider());
final historyRepo = HistoryRepository(HistoryDataProvider());
final adminRepo = AdminRepository(AdminDataProvider());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthBloc(authRepo)),
        BlocProvider(create: (ctx) => ProfileBloc(authRepo)),
        BlocProvider(create: (ctx) => FilterblocBloc(filterRepo)),
        BlocProvider(create: (ctx) => AdminBloc(adminRepo)),
        BlocProvider(
            create: (ctx) => HistoryBloc(historyRepo)..add(UpcomingEvent(2))),
      ],
      child: MaterialApp(
        title: 'Travel App UI',
        debugShowCheckedModeBanner: false,
        home: AdminHome(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
