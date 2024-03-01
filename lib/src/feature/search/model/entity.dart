import 'package:freezed_annotation/freezed_annotation.dart';
part 'entity.freezed.dart';
part 'entity.g.dart';

typedef ProductID = String;

@freezed
class SearchModel with _$SearchModel {
  const factory SearchModel({
    required List<CombinedData> combinedData,
    required List<CombinedData> favorites,
  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
}

@freezed
class People with _$People {
  const factory People({
    required ProductID name,
    required String gender,
    required List<String> starships,
    // required List<String> starshipsLink,
  }) = _People;

  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);
}

@freezed
class StarShip with _$StarShip {
  const factory StarShip({
    required ProductID name,
    required String manufacturer,
    required String passengers,
    // required List<String> pilotsLink,
  }) = _StarShip;

  factory StarShip.fromJson(Map<String, dynamic> json) =>
      _$StarShipFromJson(json);
}

@freezed
class CombinedData with _$CombinedData {
  const factory CombinedData({
    required ProductID? name,
    required String? gender,
    required List<String>? starships,
    required String? manufacturer,
    required String? passengers,
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
        passengers: starship?.passengers,
      );
}
