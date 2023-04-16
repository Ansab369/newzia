import 'package:dartz/dartz.dart';
import 'package:newzia/domain/core/failures/main_failures.dart';
import 'package:newzia/domain/home/model/home.dart';

abstract class NewsServices {
  Future<Either<MainFailure, List<Home>>> getNews();
}
