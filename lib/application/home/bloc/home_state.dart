part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required bool isLoading,
    required bool isError,
    required List<Home> news,
    required Option<Either<MainFailure, List<Home>>> newsFailureOrSuccessOption,
  }) = _HomeState;

  factory HomeState.initial() {
    return HomeState(
      isLoading: false,
      news: [],
      newsFailureOrSuccessOption: none(),
      isError: false,
    );
  }
}
