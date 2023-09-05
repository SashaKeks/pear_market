import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/admin/presentation/widgets/add_user_button.dart';
import 'package:pear_market/features/admin/presentation/widgets/user_list_widget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDemensions.appSize10),
        child: Column(
          children: [
            SizedBox(height: AppDemensions.appSize10),
            const UserListWidget(),
            SizedBox(height: AppDemensions.appSize20),
            const AddUserButton(),
          ],
        ),
      ),
    );
  }
}
