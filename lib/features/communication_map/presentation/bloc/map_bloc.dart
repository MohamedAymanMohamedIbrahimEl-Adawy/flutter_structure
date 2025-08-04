import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:cleanarchitecture/features/communication_map/domain/use_case/map_use_case.dart';
import 'package:cleanarchitecture/features/communication_map/presentation/bloc/map_event.dart';

class MapBloc extends Bloc<MapEvent, BaseState> {
  final MapUseCase mapUseCase;

  MapBloc({required this.mapUseCase}) : super(const InitialState()) {
    on<FetchPointsEvent>(onGetPoints);
  }

  Future<void> onGetPoints(
    FetchPointsEvent event,
    Emitter<BaseState> emit,
  ) async {
    emit(LoadingState());
    final events = await mapUseCase.getPoints();
    events.fold((l) => emit(ErrorState(l)), (r) => emit(LoadedState(r)));
  }
}
