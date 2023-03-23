// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:new_wave_round_one/presentation/movie/model/movie_presentation_model.dart';
import 'package:new_wave_round_one/repository/movie/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieFromWebApi movieFromWebApi;
  MovieBloc(
    this.movieFromWebApi,
  ) : super(const MovieState()) {
    on<MovieLoadMorePageEvent>(_onMovieLoadMorePageEvent);
  }

  _onMovieLoadMorePageEvent(MovieLoadMorePageEvent event, Emitter emit) async {
    if (state.totalPage != null && state.currentPage == state.totalPage) {
      return;
    }
    log(state.currentPage.toString());
    if (state.currentPage == 0) {
      emit(state.copyWith(status: MovieStatus.loading));
    }
    var result =
        await movieFromWebApi.getListMovieWithPage(state.currentPage + 1);
    result.fold(
        (l) =>
            emit(state.copyWith(error: l, status: MovieStatus.loadedFailure)),
        (r) {
      List<MoviePresentationModel> newItems = [];
      if (state.items == null) {
        newItems = r.items;
      } else {
        newItems = state.items! + r.items;
      }

      emit(state.copyWith(
          status: MovieStatus.loadedSuccess,
          items: newItems,
          currentPage: state.currentPage + 1,
          totalPage: r.totalPage));
    });
  }
}
