import 'package:freezed_annotation/freezed_annotation.dart';
part 'entity.freezed.dart';
part 'entity.g.dart';

@freezed
class SearchModel with _$SearchModel {
  const factory SearchModel({
    // required List<People> peoples,
    // required List<StarShip> starships,
    required List<CombinedData> combinedData,
  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
}

@freezed
class People with _$People {
  const factory People({
    required String name,
    required String gender,
    required List<StarShip> starships,
    // required List<String> starshipsLink,
  }) = _People;

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);
}

@freezed
class StarShip with _$StarShip {
  const factory StarShip({
    required String name,
    required String manufacturer,
    required List<People> pilots,
    // required List<String> pilotsLink,
  }) = _StarShip;

  factory StarShip.fromJson(Map<String, dynamic> json) =>
      _$StarShipFromJson(json);
}

@freezed
class CombinedData with _$CombinedData {
  const factory CombinedData({
    required String? name,
    required String? gender,
    required List<StarShip>? starships,
    required String? manufacturer,
    required List<People>? pilots,
  }) = _CombinedData;
  factory CombinedData.fromJson(Map<String, dynamic> json) =>
      _$CombinedDataFromJson(json);

  factory CombinedData.fromPeopleAndStarship(
    People? people,
    StarShip? starship,
  ) =>
      CombinedData(
        name: people == null ? starship?.name : people.name,
        gender: people?.gender,
        starships: people?.starships,
        manufacturer: starship?.manufacturer,
        pilots: starship?.pilots,
      );
}
