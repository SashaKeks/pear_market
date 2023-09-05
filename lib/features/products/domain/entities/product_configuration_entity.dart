import 'package:equatable/equatable.dart';

class ProductConfigurationEntity extends Equatable {
  const ProductConfigurationEntity({
    required this.color,
    required this.storage,
    required this.ram,
    required this.proc,
    required this.video,
  });

  final String color;
  final String storage;
  final String ram;
  final String proc;
  final String video;

  factory ProductConfigurationEntity.empty() {
    return const ProductConfigurationEntity(
      color: "",
      storage: "",
      ram: "",
      proc: "",
      video: "",
    );
  }

  @override
  List<Object?> get props => [
        color,
        storage,
        ram,
        proc,
        video,
      ];

  ProductConfigurationEntity copyWith({
    String? color,
    String? storage,
    String? ram,
    String? proc,
    String? video,
  }) {
    return ProductConfigurationEntity(
      color: color ?? this.color,
      storage: storage ?? this.storage,
      ram: ram ?? this.ram,
      proc: proc ?? this.proc,
      video: video ?? this.video,
    );
  }
}
