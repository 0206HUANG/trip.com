// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
  id: json['id'] as String,
  destinationId: json['destinationId'] as String,
  customerName: json['customerName'] as String,
  customerEmail: json['customerEmail'] as String,
  customerPhone: json['customerPhone'] as String,
  travelDate: DateTime.parse(json['travelDate'] as String),
  numberOfPeople: (json['numberOfPeople'] as num).toInt(),
  totalPrice: (json['totalPrice'] as num).toDouble(),
  currency: json['currency'] as String,
  bookingDate: DateTime.parse(json['bookingDate'] as String),
  status: $enumDecode(_$BookingStatusEnumMap, json['status']),
  specialRequests: json['specialRequests'] as String?,
);

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
  'id': instance.id,
  'destinationId': instance.destinationId,
  'customerName': instance.customerName,
  'customerEmail': instance.customerEmail,
  'customerPhone': instance.customerPhone,
  'travelDate': instance.travelDate.toIso8601String(),
  'numberOfPeople': instance.numberOfPeople,
  'totalPrice': instance.totalPrice,
  'currency': instance.currency,
  'bookingDate': instance.bookingDate.toIso8601String(),
  'status': _$BookingStatusEnumMap[instance.status]!,
  'specialRequests': instance.specialRequests,
};

const _$BookingStatusEnumMap = {
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.completed: 'completed',
};
