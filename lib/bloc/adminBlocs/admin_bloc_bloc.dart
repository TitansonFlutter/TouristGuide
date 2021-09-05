import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';

import '../../repository/adminRepository/admin_repository.dart';

part 'admin_bloc_event.dart';
part 'admin_bloc_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final AdminRepository adminRepository;

  AdminBloc(this.adminRepository) : super(AgentsLoading());

  @override
  Stream<AdminState> mapEventToState(
    AdminEvent event,
  ) async* {
    if (event is Agentsload) {
      yield AgentsLoading();
      try {
        final agents = await adminRepository.fetchAllAgents();
        yield AgentOperationSuccess(agents);
      } catch (e) {
        yield AgentOperationFailure();
      }
    }
    if (event is CreateAgent) {
      try {
        await adminRepository.addAgent(event.agent);
        final agents = await adminRepository.fetchAllAgents();
        yield AgentOperationSuccess(agents);
      } catch (_) {
        yield AgentOperationFailure();
      }
    }
    if (event is DeleteAgent) {
      try {
        print(event.id);
        await adminRepository.deleteAgent(event.id);
        final agents = await adminRepository.fetchAllAgents();
        yield AgentOperationSuccess(agents);
      } catch (_) {
        yield AgentOperationFailure();
      }
    }
  }
}
