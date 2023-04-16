import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:newzia/core/strings.dart';
import 'package:newzia/domain/core/failures/main_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:newzia/domain/home/home_services.dart';
import 'package:newzia/domain/home/model/home.dart';

@LazySingleton(as: NewsServices)
class NewsRepository implements NewsServices {
  @override
  Future<Either<MainFailure, List<Home>>> getNews() async {
    try {
      final Response response = await Dio(BaseOptions()).get(ApiEndPoints.news);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // log(response.data.toString());
        // final newsList = [];
        final newsList = (response.data['articles'] as List).map((e) {
          return Home.fromJson(e);
        }).toList();
        print(newsList);
        return Right(newsList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (error) {
      log(error.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
