// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String,
  profileImage: json['profileImage'] as String,
  birthDate: DateTime.parse(json['birthDate'] as String),
  nationality: json['nationality'] as String,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'profileImage': instance.profileImage,
  'birthDate': instance.birthDate.toIso8601String(),
  'nationality': instance.nationality,
};
