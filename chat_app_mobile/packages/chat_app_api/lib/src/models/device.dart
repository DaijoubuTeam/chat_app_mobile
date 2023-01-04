import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  final String id;
  final String? name;

  Device({required this.id, this.name});

  Device copyWith({
    String? id,
    String? name,
  }) =>
      Device(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static final empty = Device(id: '');

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
