import 'package:pear_market/core/util/enums.dart';

class Generation {
  final String generation;
  final ProductType? type;

  Generation({
    this.type,
    required this.generation,
  });

  Generation copyWith({
    String? generation,
    ProductType? type,
  }) {
    return Generation(
      generation: generation ?? this.generation,
      type: type ?? this.type,
    );
  }
}
