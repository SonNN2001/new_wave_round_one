import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_wave_round_one/common/constant.dart';
import 'package:new_wave_round_one/repository/movie/movie_data_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

class API {
  static const Duration connectTimeOut = SIXTY_SEC;
  static const Duration sendTimeOut = SIXTY_SEC;
  static const Duration receiveTimeOut = SIXTY_SEC;

  static const String getListMovie = '3/discover/movie';
}

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
      receiveTimeout: API.receiveTimeOut,
      connectTimeout: API.connectTimeOut,
      sendTimeout: API.sendTimeOut,
    );

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        error: true,
        requestHeader: true,
        responseHeader: false,
        request: false,
        requestBody: true,
      ));
    }
    return _ApiService(dio, baseUrl: API_URL);
  }

  @GET(API.getListMovie)
  Future<MovieResponseModel> getListMovieWithPage(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );
}
