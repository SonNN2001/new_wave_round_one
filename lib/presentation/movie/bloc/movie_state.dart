// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movie_bloc.dart';

enum MovieStatus { init, loading, loadedSuccess, loadedFailure }

extension MovieStatusX on MovieStatus {
  bool get isLoading => this == MovieStatus.loading;
  bool get isSuccess => this == MovieStatus.loadedSuccess;
  bool get isFailure => this == MovieStatus.loadedFailure;
}

class MovieState extends Equatable {
  final MovieStatus status;
  final String? error;
  final int currentPage;
  final int? totalPage;
  final List<MoviePresentationModel>? items;
  const MovieState({
    this.status = MovieStatus.init,
    this.error,
    this.currentPage = 0,
    this.totalPage,
    this.items,
  });

  @override
  List<Object?> get props => [status, error, currentPage, totalPage, items];

  MovieState copyWith({
    MovieStatus? status,
    String? error,
    int? currentPage,
    int? totalPage,
    List<MoviePresentationModel>? items,
  }) {
    return MovieState(
      status: status ?? this.status,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      items: items ?? this.items,
    );
  }
}
