import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class AppPlatform {

  const AppPlatform({
    required this.platform,
    required this.version,
    required this.downloadurl,
    required this.comment,
  });

  final String platform;
  final String version;
  final String downloadurl;
  final String comment;

  factory AppPlatform.fromJson(Map<String,dynamic> json) => AppPlatform(
    platform: json['platform'].toString(),
    version: json['version'].toString(),
    downloadurl: json['downloadurl'].toString(),
    comment: json['comment'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'platform': platform,
    'version': version,
    'downloadurl': downloadurl,
    'comment': comment
  };

  AppPlatform clone() => AppPlatform(
    platform: platform,
    version: version,
    downloadurl: downloadurl,
    comment: comment
  );


  AppPlatform copyWith({
    String? platform,
    String? version,
    String? downloadurl,
    String? comment
  }) => AppPlatform(
    platform: platform ?? this.platform,
    version: version ?? this.version,
    downloadurl: downloadurl ?? this.downloadurl,
    comment: comment ?? this.comment,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AppPlatform && platform == other.platform && version == other.version && downloadurl == other.downloadurl && comment == other.comment;

  @override
  int get hashCode => platform.hashCode ^ version.hashCode ^ downloadurl.hashCode ^ comment.hashCode;
}
