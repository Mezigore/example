// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionData _$AppVersionDataFromJson(Map<String, dynamic> json) {
  return AppVersionData(
    appStore: json['app_store'] as String,
    playMarket: json['play_market'] as String,
  );
}

Map<String, dynamic> _$AppVersionDataToJson(AppVersionData instance) =>
    <String, dynamic>{
      'app_store': instance.appStore,
      'play_market': instance.playMarket,
    };
