import 'package:freezed_annotation/freezed_annotation.dart';
part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class SearchModel with _$SearchModel {
  const factory SearchModel({
    required List<People> peoples,
    required List<StarShip> starships,
  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
}

@freezed
class People with _$People {
  const factory People({
    required String name,
    required String gender,
    required List<String> starships,
  }) = _People;

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);
}

@freezed
class StarShip with _$StarShip {
  const factory StarShip({
    required String name,
    required String manufacturer,
    required List<String> pilots,
  }) = _StarShip;

  factory StarShip.fromJson(Map<String, dynamic> json) =>
      _$StarShipFromJson(json);
}
