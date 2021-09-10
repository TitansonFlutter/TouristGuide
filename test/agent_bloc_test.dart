import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tourist_guide_app/Presentation/Models/tour_list.dart';
import 'package:tourist_guide_app/bloc/agentBloc/agentBloc/agent_bloc.dart';
import 'package:tourist_guide_app/repository/agentRepository/agentRepository/agent_repository.dart';

class MockAgentRepository extends Mock implements AgentRepository {}

void main() {
  MockAgentRepository mockAgentRepository;
  setUp(() {
    mockAgentRepository = MockAgentRepository();
  });
  group("Get Tours", () {
    List<Tour> tours = [
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
    ];
    int agentId = 1;
    blocTest<AgentBloc, AgentState>(
      'emits [ToursLoading(),TourOperationSuccess(tours)] when ToursLoad is successful',
      build: () {
        when(mockAgentRepository.fetchAllTours(agentId))
            .thenAnswer((_) async => tours);
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(ToursLoad(agentId));
      },
      expect: () => [
        TourLoading(),
        TourOperationSuccess(tours),
      ],
    );

    blocTest<AgentBloc, AgentState>(
      'emits [TourLoading(),TourOperationFailure(tours)] when Toursload is unsuccessful',
      build: () {
        when(mockAgentRepository.fetchAllTours(agentId))
            .thenThrow((_) async => TourOperationFailure());
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(ToursLoad(agentId));
      },
      expect: () => [TourLoading(), TourOperationFailure()],
    );
  });

  group("Create Tours", () {
    List<Tour> tours = [
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
    ];
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

    int agentId = 1;
    blocTest<AgentBloc, AgentState>(
      'emits [TourOperationSuccess(tours)] when Toursload is successful',
      build: () {
        when(mockAgentRepository.addTour(agentId, tour)).thenAnswer((_) async {
          tours.add(tour);
        });

        when(mockAgentRepository.fetchAllTours(agentId))
            .thenAnswer((_) async => tours);
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(CreateTour(agentId, tour));
      },
      expect: () => [
        TourOperationSuccess(tours),
      ],
    );

    blocTest<AgentBloc, AgentState>(
      'emits [TourOperationFailure(tours)] when Toursload is unsuccessful',
      build: () {
        when(mockAgentRepository.addTour(agentId, tour)).thenAnswer((_) async {
          tours.add(tour);
        });

        when(mockAgentRepository.fetchAllTours(agentId))
            .thenThrow((_) async => TourOperationFailure());
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(CreateTour(agentId, tour));
      },
      expect: () => [TourOperationFailure()],
    );
  });

  group("Update Tours", () {
    List<Tour> tours = [
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
    ];
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

    int agentId = 1;
    int tId = 1;
    blocTest<AgentBloc, AgentState>(
      'emits [TourOperationSuccess(tours)] when Toursload is successful',
      build: () {
        when(mockAgentRepository.updateTour(agentId, tId, tour))
            .thenAnswer((_) async {
          for (var atour in tours) {
            if (atour.tourId == tId) {
              tours.remove(atour);
            }
          }
          tours.add(tour);
        });

        when(mockAgentRepository.fetchAllTours(agentId))
            .thenAnswer((_) async => tours);
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(CreateTour(agentId, tour));
      },
      expect: () => [
        TourOperationSuccess(tours),
      ],
    );

    blocTest<AgentBloc, AgentState>(
      'emits [TourOperationFailure(tours)] when Toursload is unsuccessful',
      build: () {
        when(mockAgentRepository.updateTour(agentId, tId, tour))
            .thenAnswer((_) async {
          for (var atour in tours) {
            if (atour.tourId == tId) {
              tours.remove(atour);
            }
          }
          tours.add(tour);
        });

        when(mockAgentRepository.fetchAllTours(agentId))
            .thenThrow((_) async => TourOperationFailure());
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(CreateTour(agentId, tour));
      },
      expect: () => [TourOperationFailure()],
    );
  });

  group("Delete Tours", () {
    List<Tour> tours = [
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
      Tour(1, "Lalibela", "lalibela.jpg", "Ethiopa", "Oromia", "Addis Ababa",
          "sth", "sth", "sth", "sth", "sth", 3, "startingDate", 200.00, true),
    ];

    int agentId = 1;
    int tourtobeDeletedUserId = 2;
    blocTest<AgentBloc, AgentState>(
      'emits [TourOperationSuccess(tours)] when Toursload is successful',
      build: () {
        when(mockAgentRepository.deleteTour(agentId, tourtobeDeletedUserId))
            .thenAnswer((_) async {
          for (var atour in tours) {
            if (atour.tourId == tourtobeDeletedUserId) {
              tours.remove(atour);
            }
          }
        });

        when(mockAgentRepository.fetchAllTours(agentId))
            .thenAnswer((_) async => tours);
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(DeleteTour(agentId, tourtobeDeletedUserId));
      },
      expect: () => [
        TourOperationSuccess(tours),
      ],
    );

    blocTest<AgentBloc, AgentState>(
      'emits [TourOperationFailure(tours)] when Toursload is unsuccessful',
      build: () {
        when(mockAgentRepository.deleteTour(agentId, tourtobeDeletedUserId))
            .thenAnswer((_) async {
          for (var atour in tours) {
            if (atour.tourId == tourtobeDeletedUserId) {
              tours.remove(atour);
              print(atour);
            }
          }
        });

        when(mockAgentRepository.fetchAllTours(agentId))
            .thenThrow((_) async => TourOperationFailure());
        return AgentBloc(mockAgentRepository);
      },
      act: (bloc) {
        bloc.add(DeleteTour(agentId, tourtobeDeletedUserId));
      },
      expect: () => [TourOperationFailure()],
    );
  });
}
