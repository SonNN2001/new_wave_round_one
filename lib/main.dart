import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_wave_round_one/common/api_service.dart';
import 'package:new_wave_round_one/presentation/movie/movie_view.dart';

import 'presentation/movie/bloc/movie_bloc.dart';
import 'repository/movie/movie_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>
            MovieBloc(MovieFromWebApi(apiService: ApiService(Dio()))),
        child: const MovieView(),
      ),
    );
  }
}
