import 'package:flutter/material.dart';
import 'package:pear_market/core/service/navigation_service/navigation_names.dart';
import 'package:pear_market/core/util/enums/product_type_enum.dart';
import 'package:pear_market/core/widgets/snackbar/show_snackbar_error.dart';
import 'package:pear_market/features/menu/domain/entities/generation_entity.dart';
import 'package:pear_market/features/menu/domain/usecase/get_generations_usecase.dart';

class SubMenuViewModel with ChangeNotifier {
  SubMenuViewModel(
    this._generationsUseCase,
    this._context, {
    required this.subMenuType,
  }) {
    getTypeGenerations();
  }

  final BuildContext _context;

  final ProductTypeEnum subMenuType;

  final GetGenerationsUseCase _generationsUseCase;

  List<GenerationEntity> generationList = [];

  Future<void> getTypeGenerations() async {
    final result = await _generationsUseCase(params: subMenuType);

    result.fold(
      (l) => showSnackbarError(_context, l.errorMessage),
      (r) => generationList = r.reversed.toList(),
    );

    notifyListeners();
  }

  void onSubMenuItemButtonPress(GenerationEntity generation) {
    Navigator.pushNamed(_context, AppNavigationNames.productList,
        arguments: generation.copyWith(type: subMenuType));
  }
}
