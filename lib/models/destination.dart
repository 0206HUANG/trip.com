import 'package:json_annotation/json_annotation.dart';

part 'destination.g.dart';

@JsonSerializable()
class Destination {
  final String id;
  final String name;
  final String description;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final String location;
  final double latitude;
  final double longitude;
  final double price;
  final String currency;
  final List<String> highlights;
  final String category;

  const Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.price,
    required this.currency,
    required this.highlights,
    required this.category,
  });

  factory Destination.fromJson(Map<String, dynamic> json) =>
      _$DestinationFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationToJson(this);
} 