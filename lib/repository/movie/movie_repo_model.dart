// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:new_wave_round_one/presentation/movie/model/movie_presentation_model.dart';

class MovieRepoModel {
  final List<MoviePresentationModel> items;
  final int totalPage;
  MovieRepoModel({
    required this.items,
    required this.totalPage,
  });
}
