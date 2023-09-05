import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/admin/presentation/providers/admin_panel_view_model.dart';
import 'package:provider/provider.dart';

class UserButtonDetail extends StatelessWidget {
  final int index;
  const UserButtonDetail({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AdminPanelViewModel>().userList[index];
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) =>
                context.read<AdminPanelViewModel>().deleteUser(index),
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            flex: 2,
            onPressed: (context) =>
                context.read<AdminPanelViewModel>().updateUser(index),
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDemensions.appSize10,
        ),
        child: InkWell(
          onTap: context.read<AdminPanelViewModel>().openUserDetail,
          child: Container(
            height: AppDemensions.appSize100,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(20.0)),
            child: Center(
              child: Text(
                user.fullName.toUpperCase(),
                style: GoogleFonts.nanumGothic(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 27,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
