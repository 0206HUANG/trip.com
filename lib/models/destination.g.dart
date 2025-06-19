// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Destination _$DestinationFromJson(Map<String, dynamic> json) => Destination(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  rating: (json['rating'] as num).toDouble(),
  reviewCount: (json['reviewCount'] as num).toInt(),
  location: json['location'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  price: (json['price'] as num).toDouble(),
  currency: json['currency'] as String,
  highlights: (json['highlights'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  category: json['category'] as String,
);

Map<String, dynamic> _$DestinationToJson(Destination instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'price': instance.price,
      'currency': instance.currency,
      'highlights': instance.highlights,
      'category': instance.category,
    };
