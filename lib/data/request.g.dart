// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Request _$$_RequestFromJson(Map<String, dynamic> json) => _$_Request(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: json['createdAt'] as String,
      latLng: const LatLngConverter()
          .fromJson(json['latLng'] as Map<String, double>),
      status: $enumDecode(_$RequestStatusEnumMap, json['status']),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      documents:
          (json['documents'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_RequestToJson(_$_Request instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'latLng': const LatLngConverter().toJson(instance.latLng),
      'status': _$RequestStatusEnumMap[instance.status]!,
      'images': instance.images,
      'documents': instance.documents,
    };

const _$RequestStatusEnumMap = {
  RequestStatus.accepted: 'accepted',
  RequestStatus.pending: 'pending',
  RequestStatus.rejected: 'rejected',
};
