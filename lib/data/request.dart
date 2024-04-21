import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'request.freezed.dart';
part 'request.g.dart';

enum RequestStatus {
  @JsonValue("accepted")
  accepted("Accepté", Colors.green),
  @JsonValue("pending")
  pending("En cours", Colors.orange),
  @JsonValue("rejected")
  rejected("Rejetée", Colors.red);

  final String title;
  final Color color;

  const RequestStatus(this.title, this.color);
}

@freezed
class Request with _$Request {
  const factory Request({
    required String id,
    required String title,
    required String description,
    required String createdAt,
    @LatLngConverter() required LatLng latLng,
    required RequestStatus status,
    required List<String> images,
    required List<String> documents,
  }) = _Request;

  factory Request.fromJson(Map<String, Object?> json) => _$RequestFromJson(json);
}

class LatLngConverter implements JsonConverter<LatLng, Map<String, double>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, double> json) => LatLng(json["latitude"]!, json["longitude"]!);

  @override
  Map<String, double> toJson(LatLng latLng) => {"latitude": latLng.latitude, "longitude": latLng.longitude};
}
