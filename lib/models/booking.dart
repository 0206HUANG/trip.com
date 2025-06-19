import 'package:json_annotation/json_annotation.dart';

part 'booking.g.dart';

@JsonSerializable()
class Booking {
  final String id;
  final String destinationId;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final DateTime travelDate;
  final int numberOfPeople;
  final double totalPrice;
  final String currency;
  final DateTime bookingDate;
  final BookingStatus status;
  final String? specialRequests;

  const Booking({
    required this.id,
    required this.destinationId,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.travelDate,
    required this.numberOfPeople,
    required this.totalPrice,
    required this.currency,
    required this.bookingDate,
    required this.status,
    this.specialRequests,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  completed
} 