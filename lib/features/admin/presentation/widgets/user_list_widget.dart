import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/util/enums/data_status_enum.dart';
import 'package:pear_market/features/admin/presentation/providers/admin_panel_view_model.dart';
import 'package:pear_market/features/admin/presentation/widgets/user_button_detail.dart';
import 'package:provider/provider.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    switch (context.watch<AdminPanelViewModel>().dataIsLoad) {
      case DataStatusEnum.progress:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case DataStatusEnum.success:
      case DataStatusEnum.none:
        return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => UserButtonDetail(index: index),
            separatorBuilder: (context, index) => SizedBox(
                  height: AppDemensions.appSize10,
                ),
            itemCount: context.watch<AdminPanelViewModel>().userCount);
      default:
        return const SizedBox();
    }
  }
}
