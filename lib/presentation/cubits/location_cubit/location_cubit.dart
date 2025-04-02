import 'package:rick_and_morty_wiki/data/models/location.dart';
import 'package:rick_and_morty_wiki/presentation/cubits/api_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/app_module.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(const LocationState());

  final _repository = AppModule.getLocationRepository();

  Future<void> loadAllLocations() async {
    emit(state.copyWith(getLocationsState: LoadingState()));
    try {
      List<Location> locations = await _repository.getLocations();
      emit(state.copyWith(getLocationsState: LoadedState(locations)));
    } catch (e) {
      emit(state.copyWith(getLocationsState: FailedState(e.toString())));
    }
  }

  Future<void> loadLocation(int id) async {
    emit(state.copyWith(getLocationState: LoadingState()));
    try {
      Location location = await _repository.getLocation(id);
      emit(state.copyWith(getLocationState: LoadedState(location)));
    } catch (e) {
      emit(state.copyWith(getLocationState: FailedState(e.toString())));
    }
  }
}
