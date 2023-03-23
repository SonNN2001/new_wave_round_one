// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDataModel _$MovieDataModelFromJson(Map<String, dynamic> json) =>
    MovieDataModel(
      thumb: json['backdrop_path'] as String?,
      date: json['release_date'] as String?,
      title: json['title'] as String?,
      point: (json['vote_average'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MovieDataModelToJson(MovieDataModel instance) =>
    <String, dynamic>{
      'backdrop_path': instance.thumb,
      'release_date': instance.date,
      'title': instance.title,
      'vote_average': instance.point,
    };

MovieResponseModel _$MovieResponseModelFromJson(Map<String, dynamic> json) =>
    MovieResponseModel(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPage: json['total_pages'] as int,
    );

Map<String, dynamic> _$MovieResponseModelToJson(MovieResponseModel instance) =>
    <String, dynamic>{
      'results': instance.results,
      'total_pages': instance.totalPage,
    };
