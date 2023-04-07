import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
  
  final String uid;
  final String name;
  final String profile_url;
  final String banner;
  final bool is_authenticated;
  final int karma;
  final List<String> awards;
  
  User({
    required this.uid,
    required this.name,
    required this.profile_url,
    required this.banner,
    required this.is_authenticated,
    required this.karma,
    required this.awards,
  });
  

  User copyWith({
    String? uid,
    String? name,
    String? profile_url,
    String? banner,
    bool? is_authenticated,
    int? karma,
    List<String>? awards,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profile_url: profile_url ?? this.profile_url,
      banner: banner ?? this.banner,
      is_authenticated: is_authenticated ?? this.is_authenticated,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'profile_url': profile_url,
      'banner': banner,
      'is_authenticated': is_authenticated,
      'karma': karma,
      'awards': awards,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      profile_url: map['profile_url'] ?? '',
      banner: map['banner'] ?? '',
      is_authenticated: map['is_authenticated'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      awards: List<String>.from(map['awards']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, profile_url: $profile_url, banner: $banner, is_authenticated: $is_authenticated, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.uid == uid &&
      other.name == name &&
      other.profile_url == profile_url &&
      other.banner == banner &&
      other.is_authenticated == is_authenticated &&
      other.karma == karma &&
      listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      profile_url.hashCode ^
      banner.hashCode ^
      is_authenticated.hashCode ^
      karma.hashCode ^
      awards.hashCode;
  }
}
