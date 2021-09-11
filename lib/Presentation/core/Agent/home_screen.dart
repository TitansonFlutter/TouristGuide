import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide_app/SharedSimplePreference.dart';
import 'package:tourist_guide_app/bloc/agentBloc/agentBloc/agent_bloc.dart';
import 'package:tourist_guide_app/dataProvider/agentDataProviders/agentDataProviders/agent_data_provider.dart';
import 'package:tourist_guide_app/repository/agentRepository/agentRepository/agent_repository.dart';

import 'components/tours_display.dart';

class AgentHome extends StatelessWidget {
  static final String routeName = "/agents";
  final AgentRepository agentRepository = AgentRepository(AgentDataProvider());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.agentRepository,
      child: BlocProvider(
        create: (context) => AgentBloc(this.agentRepository)
          ..add(ToursLoad(UserSimplePreferences.getUser().userId)),
        child: ToursDisplay(),
      ),
    );
  }
}
