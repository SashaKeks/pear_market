import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/failure.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';

class GenerationSource {
  Future<List<Generation>> getGenerations({required ProductType type}) async {
    DocumentReference? docRef = FirebaseFirestore.instance
        .collection(AppConstants.generationDB)
        .doc(type.name);

    final result = docRef.get().then((value) async {
      final product = value.data() as Map<String, dynamic>;
      final list = (product[type.name] as List)
          .map((e) => Generation(generation: e as String))
          .toList();
      return list;
    }).catchError((e) => throw ServerFailure(e.toString()));
    docRef = null;
    return result;
  }
}
