import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class Config {

  const Config({
    required this.apps,
  });

  final List<AppInfo> apps;

  factory Config.fromJson(Map<String,dynamic> json) => Config(
    apps: (json['apps'] as List? ?? []).map((e) => AppInfo.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'apps': apps.map((e) => e.toJson()).toList()
  };

  Config clone() => Config(
    apps: apps.map((e) => e.clone()).toList()
  );


  Config copyWith({
    List<AppInfo>? apps
  }) => Config(
    apps: apps ?? this.apps,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Config && apps == other.apps;

  @override
  int get hashCode => apps.hashCode;
}
