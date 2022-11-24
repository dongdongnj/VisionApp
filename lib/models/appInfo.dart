import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class AppInfo {

  const AppInfo({
    required this.name,
    required this.homePage,
    required this.platform,
  });

  final String name;
  final String homePage;
  final List<AppPlatform> platform;

  factory AppInfo.fromJson(Map<String,dynamic> json) => AppInfo(
    name: json['name'].toString(),
    homePage: json['homePage'].toString(),
    platform: (json['platform'] as List? ?? []).map((e) => AppPlatform.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'homePage': homePage,
    'platform': platform.map((e) => e.toJson()).toList()
  };

  AppInfo clone() => AppInfo(
    name: name,
    homePage: homePage,
    platform: platform.map((e) => e.clone()).toList()
  );


  AppInfo copyWith({
    String? name,
    String? homePage,
    List<AppPlatform>? platform
  }) => AppInfo(
    name: name ?? this.name,
    homePage: homePage ?? this.homePage,
    platform: platform ?? this.platform,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AppInfo && name == other.name && homePage == other.homePage && platform == other.platform;

  @override
  int get hashCode => name.hashCode ^ homePage.hashCode ^ platform.hashCode;
}
