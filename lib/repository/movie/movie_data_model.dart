// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'movie_data_model.g.dart';

@JsonSerializable()
class MovieDataModel {
  @JsonKey(name: 'backdrop_path')
  final String? thumb;
  @JsonKey(name: 'release_date')
  final String? date;
  final String? title;
  @JsonKey(name: 'vote_average')
  final double? point;
  MovieDataModel({
    required this.thumb,
    required this.date,
    required this.title,
    required this.point,
  });
  factory MovieDataModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataModelToJson(this);
}

@JsonSerializable()
class MovieResponseModel {
  final List<MovieDataModel>? results;
  @JsonKey(name: 'total_pages')
  final int totalPage;
  MovieResponseModel({
    this.results,
    required this.totalPage,
  });
  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseModelToJson(this);
}
