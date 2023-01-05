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
}
