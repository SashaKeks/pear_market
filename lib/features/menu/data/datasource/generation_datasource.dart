import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pear_market/core/error/exception.dart';
import 'package:pear_market/core/resources/app_constants.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/features/menu/data/models/generation_model.dart';

class GenerationDataSource {
  Future<List<GenerationModel>> getGenerations(
      {required ProductTypeEnum type}) async {
    DocumentReference? generationRef = FirebaseFirestore.instance
        .collection(AppConstants.generationDB)
        .doc(type.name);

    return generationRef.get().then((value) async {
      final generationData = value.data() as Map<String, dynamic>;
      final generationList = (generationData[type.name] as List)
          .map((e) => GenerationModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return generationList;
    }).catchError((_) => throw LoadDataFromFireBaseException());
  }
}
