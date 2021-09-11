import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/Presentation/core/Agent/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/AuthMain/welcomePage.dart';
import 'package:tourist_guide_app/Presentation/core/admin/home_screen.dart';
import 'package:tourist_guide_app/Presentation/core/home/home.dart';
import 'package:tourist_guide_app/Routes/routes.dart';
import 'package:tourist_guide_app/SharedSimplePreference.dart';

import 'package:tourist_guide_app/bloc/auth_bloc.dart';
import 'package:tourist_guide_app/dataProvider/authProvider/auth_data_provider.dart';
import 'package:tourist_guide_app/dataProvider/history_data_provider.dart';
import 'package:tourist_guide_app/repository/adminRepository/admin_repository.dart';
import 'package:tourist_guide_app/repository/auth_repository.dart';
import 'package:tourist_guide_app/repository/features_repository.dart';
import 'package:tourist_guide_app/repository/filter_repository.dart';
import 'package:tourist_guide_app/repository/history_repository.dart';

import 'bloc/FilterBloc/bloc/filterbloc_bloc.dart';
import 'bloc/adminBlocs/admin_bloc_bloc.dart';
import 'bloc/agentBloc/agentBloc/agent_bloc.dart';
import 'bloc/featuresBloc/bloc.dart';
import 'bloc/historyBloc/history_bloc.dart';
import 'bloc/profile/profile_bloc.dart';
import 'dataProvider/adminDataProviders/admin_data_providers.dart';
import 'dataProvider/agentDataProviders/agentDataProviders/agent_data_provider.dart';
import 'dataProvider/featureDataProvider/features_data_provider.dart';
import 'dataProvider/filterDataProvider/filter_data_provider.dart';
import 'repository/agentRepository/agentRepository/agent_repository.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await UserSimplePreferences.init();
  runApp(MyApp());
}

final authRepo = AuthRepository(AuthDataProvider());
final filterRepo = FilterRepository(FilterDataProvider());
final historyRepo = HistoryRepository(HistoryDataProvider());
final adminRepo = AdminRepository(AdminDataProvider());
final agentRepo = AgentRepository(AgentDataProvider());
final featuresRepo = FeaturesRepository(FeaturesDataProvider());

class MyApp extends StatelessWidget {
  initRoute() {
    final user = UserSimplePreferences.getUser();
    if (user != null) {
      if (user.role == 0) {
        return HomeScreen.routeName;
      } else if (user.role == 1) {
        return AgentHome.routeName;
      } else if (user.role == -1) {
        return AdminHome.routeName;
      }
    } else {
      return '/';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => AuthBloc(authRepo)),
        BlocProvider(create: (ctx) => ProfileBloc(authRepo)),
        BlocProvider(create: (ctx) => FilterblocBloc(filterRepo)),
        BlocProvider(create: (ctx) => AdminBloc(adminRepo)),
        BlocProvider(create: (ctx) => AgentBloc(agentRepo)),
        BlocProvider(create: (ctx) => FeaturesBloc(featuresRepo)),
        BlocProvider(
            create: (ctx) => HistoryBloc(historyRepo)
              ..add(UpcomingEvent(UserSimplePreferences.getUser().userId))),
      ],
      child: MaterialApp(
        title: 'Travel App',
        debugShowCheckedModeBanner: false,
        initialRoute: initRoute(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
