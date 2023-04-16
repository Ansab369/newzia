import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:newzia/domain/core/failures/main_failures.dart';
import 'package:newzia/domain/home/home_services.dart';
import 'package:newzia/domain/home/model/home.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsServices newsServices;
  HomeBloc(this.newsServices) : super(HomeState.initial()) {
    on<_GetNews>((event, emit) async {
      emit(
        state.copyWith(isLoading: true, newsFailureOrSuccessOption: none()),
      );
      final _result = await newsServices.getNews();
      log(_result.toString());
      final _state = _result.fold((l) {
        return HomeState(
          isLoading: false,
          news: [],
          newsFailureOrSuccessOption: some(left(l)),
          isError: true,
        );
      }, (r) {
        return HomeState(
            isLoading: false,
            isError: false,
            news: r,
            newsFailureOrSuccessOption: some(right(r)));
      });
      log(_state.toString());
      emit(_state);
    });
  }
}
