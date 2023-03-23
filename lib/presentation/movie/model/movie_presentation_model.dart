// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:new_wave_round_one/common/app_helper.dart';
import 'package:new_wave_round_one/repository/movie/movie_data_model.dart';

class MoviePresentationModel {
  final int year;
  final String name;
  final double point;
  final String thumb;
  const MoviePresentationModel({
    required this.year,
    required this.name,
    required this.point,
    required this.thumb,
  });
  static MoviePresentationModel fromDataModel(MovieDataModel model) {
    return MoviePresentationModel(
        year: int.parse(model.date != null
            ? model.date!.substring(0, 4)
            : DateTime.now().year.toString()),
        name: model.title ?? '',
        point: model.point ?? 0,
        thumb: fullUrlImage(model.thumb ?? ''));
  }

  @override
  String toString() {
    return 'MoviePresentationModel(year: $year, name: $name, point: $point, thumb: $thumb)';
  }
}
