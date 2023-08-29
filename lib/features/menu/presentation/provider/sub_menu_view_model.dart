import 'package:flutter/material.dart';
import 'package:pear_market/core/util/enums.dart';
import 'package:pear_market/features/menu/domain/entities/generation.dart';
import 'package:pear_market/features/menu/domain/usecase/get_generations_usecase.dart';
import 'package:pear_market/features/products/presentation/widgets/show_snackbar_info.dart';

class SubMenuViewModel with ChangeNotifier {
  final ProductType subMenuType;
  final BuildContext context;
  List<Generation> generationList = [];
  final GetGenerationsUseCase _generationsUseCase;
  SubMenuViewModel(this._generationsUseCase,
      {required this.subMenuType, required this.context}) {
    getTypeGenerations();
  }

  Future<void> getTypeGenerations() async {
    final result = await _generationsUseCase(type: subMenuType);
    result.fold((l) => showSnackbarInfo(context, l.errorMessage.toString()),
        (r) => generationList = r.reversed.toList());
    notifyListeners();
  }
}
