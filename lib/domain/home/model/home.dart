import 'package:freezed_annotation/freezed_annotation.dart';
part 'home.freezed.dart';
part 'home.g.dart';

@freezed
class Home with _$Home {
  const factory Home({
    required String? urlToImage,
    required String? title,
    required String? publishedAt,
    required String? name,
    required String? id,
    required String? description,
    required String? author,
  }) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);
}
