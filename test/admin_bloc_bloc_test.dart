import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tourist_guide_app/Presentation/Models/User.dart';
import 'package:tourist_guide_app/bloc/adminBlocs/admin_bloc_bloc.dart';
import 'package:tourist_guide_app/repository/adminRepository/admin_repository.dart';
import 'package:mockito/mockito.dart';

class MockAdminRepository extends Mock implements AdminRepository {}

void main() {
  MockAdminRepository mockAdminRepository;
  setUp(() {
    mockAdminRepository = MockAdminRepository();
  });
  group("Get Agents", () {
    List<User> agents = [
      User(1, "Abeni@email.com", "Abeni", 2, "password", 1),
      User(1, "Abeni@email.com", "Abeni", 2, "password", 1)
    ];
    blocTest<AdminBloc, AdminState>(
      'emits [AgentsLoading(),AgentOperationSuccess(agents)] when AgentsLoad is successful',
      build: () {
        when(mockAdminRepository.fetchAllAgents())
            .thenAnswer((_) async => agents);
        return AdminBloc(mockAdminRepository);
      },
      act: (bloc) {
        bloc.add(Agentsload());
      },
      expect: () => [
        AgentsLoading(),
        AgentOperationSuccess(agents),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [AgentsLoading(),AgentOperationFailure(agents)] when AgentsLoad is unsuccessful',
      build: () {
        when(mockAdminRepository.fetchAllAgents())
            .thenThrow((_) async => AgentOperationFailure());
        return AdminBloc(mockAdminRepository);
      },
      act: (bloc) {
        bloc.add(Agentsload());
      },
      expect: () => [AgentsLoading(), AgentOperationFailure()],
    );
  });

  group("Create Agents", () {
    List<User> agents = [
      User(1, "Abeni@email.com", "Abeni", 2, "password", 1),
      User(1, "Abeni@email.com", "Abeni", 2, "password", 1)
    ];
    User agent = User(1, "Biruk@email.com", "Biruk", 2, "password", 1);
    blocTest<AdminBloc, AdminState>(
      'emits [AgentOperationSuccess(agents)] when AgentsLoad is successful',
      build: () {
        when(mockAdminRepository.addAgent(agent)).thenAnswer((_) async {
          agents.add(agent);
        });

        when(mockAdminRepository.fetchAllAgents())
            .thenAnswer((_) async => agents);
        return AdminBloc(mockAdminRepository);
      },
      act: (bloc) {
        bloc.add(CreateAgent(agent));
      },
      expect: () => [
        AgentOperationSuccess(agents),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [AgentOperationFailure(agents)] when AgentsLoad is unsuccessful',
      build: () {
        when(mockAdminRepository.addAgent(agent)).thenAnswer((_) async {
          agents.add(agent);
        });

        when(mockAdminRepository.fetchAllAgents())
            .thenThrow((_) async => AgentOperationFailure());
        return AdminBloc(mockAdminRepository);
      },
      act: (bloc) {
        bloc.add(CreateAgent(agent));
      },
      expect: () => [AgentOperationFailure()],
    );
  });

  group("Delete Agents", () {
    List<User> agents = [
      User(1, "Abeni@email.com", "Abeni", 2, "password", 1),
      User(1, "Abeni@email.com", "Abeni", 2, "password", 1)
    ];
    int usertobeDeletedUserId = 2;
    blocTest<AdminBloc, AdminState>(
      'emits [AgentOperationSuccess(agents)] when AgentsLoad is successful',
      build: () {
        when(mockAdminRepository.deleteAgent(usertobeDeletedUserId))
            .thenAnswer((_) async {
          for (var user in agents) {
            if (user.userId == usertobeDeletedUserId) {
              agents.remove(user);
            }
          }
        });

        when(mockAdminRepository.fetchAllAgents())
            .thenAnswer((_) async => agents);
        return AdminBloc(mockAdminRepository);
      },
      act: (bloc) {
        bloc.add(DeleteAgent(usertobeDeletedUserId));
      },
      expect: () => [
        AgentOperationSuccess(agents),
      ],
    );

    blocTest<AdminBloc, AdminState>(
      'emits [AgentOperationFailure(agents)] when AgentsLoad is unsuccessful',
      build: () {
        when(mockAdminRepository.deleteAgent(usertobeDeletedUserId))
            .thenAnswer((_) async {
          for (var user in agents) {
            if (user.userId == usertobeDeletedUserId) {
              agents.remove(user);
              print(user);
            }
          }
        });

        when(mockAdminRepository.fetchAllAgents())
            .thenThrow((_) async => AgentOperationFailure());
        return AdminBloc(mockAdminRepository);
      },
      act: (bloc) {
        bloc.add(DeleteAgent(usertobeDeletedUserId));
      },
      expect: () => [AgentOperationFailure()],
    );
  });
}
