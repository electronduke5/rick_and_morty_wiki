part of 'location_cubit.dart';


class LocationState {
  final ApiState<List<Location>> getLocationsState;
  final ApiState<Location> getLocationState;

  const LocationState({
    this.getLocationsState = const IdleState(),
    this.getLocationState = const IdleState(),
  });

  LocationState copyWith({
    ApiState<List<Location>>? getLocationsState,
    ApiState<Location>? getLocationState,
  }) =>
      LocationState(
        getLocationsState: getLocationsState ?? this.getLocationsState,
        getLocationState: getLocationState ?? this.getLocationState,
      );

}
