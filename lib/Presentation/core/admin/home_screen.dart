import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/adminBlocs/bloc.dart';
import '../../../dataProvider/adminDataProviders/admin_data_providers.dart';
import '../../../repository/adminRepository/admin_repository.dart';
import 'components/agent_display.dart';

class AdminHome extends StatelessWidget {
  static final String routeName = '/admin';

  final AdminRepository adminRepository = AdminRepository(AdminDataProvider());

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.adminRepository,
      child: BlocProvider(
        create: (context) => AdminBloc(this.adminRepository)..add(Agentsload()),
        child: AgentsDisplay(),
      ),
    );
  }
}
