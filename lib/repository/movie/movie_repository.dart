// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:new_wave_round_one/common/api_service.dart';
import 'package:new_wave_round_one/common/constant.dart';
import 'package:new_wave_round_one/presentation/movie/model/movie_presentation_model.dart';
import 'package:new_wave_round_one/repository/movie/movie_data_model.dart';

import 'movie_repo_model.dart';

abstract class MovieRepository {
  Future<Either<String, MovieRepoModel>> getListMovieWithPage(int page);
}

class MovieFromWebApi implements MovieRepository {
  final ApiService apiService;
  MovieFromWebApi({
    required this.apiService,
  });
  @override
  Future<Either<String, MovieRepoModel>> getListMovieWithPage(int page) async {
    try {
      MovieResponseModel result =
          await apiService.getListMovieWithPage(API_KEY, page);
      if (result.results != null) {
        return Right(MovieRepoModel(
            items: result.results!
                .map((e) => MoviePresentationModel.fromDataModel(e))
                .toList(),
            totalPage: result.totalPage));
      } else {
        return const Left('Movie not found!!!');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
