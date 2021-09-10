import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/bloc/historyBloc/history_bloc.dart';
import 'package:tourist_guide_app/repository/history_repository.dart';

class MockHistoryRepository extends Mock implements HistoryRepository {}

void main() {
  MockHistoryRepository mockHistoryRepository;
  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
  });
  group("Get UpcomingEvents", () {
    List<Tour> tours = [
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
    ];
    int agentId = 1;
    blocTest<HistoryBloc, HistoryState>(
      'emits [AgentsLoading(),AgentOperationSuccess(agents)] when AgentsLoad is successful',
      build: () {
        when(mockHistoryRepository.fetchAllUpcomingHistory(agentId))
            .thenAnswer((_) async => tours);
        return HistoryBloc(mockHistoryRepository);
      },
      act: (bloc) {
        bloc.add(UpcomingEvent(agentId));
      },
      expect: () => [
        UpcomingState(tours),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'emits [UpcomingState(tours)] when AgentsLoad is unsuccessful',
      build: () {
        when(mockHistoryRepository.fetchAllUpcomingHistory(agentId))
            .thenThrow((_) async => HistoryFailure("Error"));
        return HistoryBloc(mockHistoryRepository);
      },
      act: (bloc) {
        bloc.add(UpcomingEvent(agentId));
      },
      expect: () => [HistoryFailure("Error")],
    );
  });

  group("Get PastEvents", () {
    List<Tour> tours = [
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
    ];
    int agentId = 1;
    Tour tour = Tour(
        1,
        "Lalibela",
        "lalibela.jpg",
        "Ethiopa",
        "Oromia",
        "Addis Ababa",
        "sth",
        "sth",
        "sth",
        "sth",
        "sth",
        3,
        "startingDate",
        200.00,
        true);
    blocTest<HistoryBloc, HistoryState>(
      'emits [AgentOperationSuccess(agents)] when AgentsLoad is successful',
      build: () {
        when(mockHistoryRepository.fetchAllPastHistory(agentId))
            .thenAnswer((_) async => tours);
        return HistoryBloc(mockHistoryRepository);
      },
      act: (bloc) {
        bloc.add(PastEvent(agentId));
      },
      expect: () => [
        PastState(tours),
      ],
    );

    blocTest<HistoryBloc, HistoryState>(
      'emits [AgentOperationFailure(agents)] when AgentsLoad is unsuccessful',
      build: () {
        when(mockHistoryRepository.fetchAllPastHistory(agentId))
            .thenThrow((_) async => HistoryFailure("Error"));
        return HistoryBloc(mockHistoryRepository);
      },
      act: (bloc) {
        bloc.add(PastEvent(agentId));
      },
      expect: () => [HistoryFailure("Error")],
    );
  });
}
