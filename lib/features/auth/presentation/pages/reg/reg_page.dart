import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/admin_panel/domain/entity/custom_user.dart';
import 'package:pear_market/features/auth/presentation/pages/reg/provider/reg_view_model.dart';
import 'package:provider/provider.dart';

class RegPage extends StatelessWidget {
  const RegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDemensions.appSize20),
          child: Form(
            key: context.read<RegViewModel>().formKey,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.watch<RegViewModel>().userForUpdate != null
                        ? "UPDATE USER"
                        : "REGISTRATION USER",
                    style: GoogleFonts.nanumGothic(
                        fontSize: AppDemensions.appSize25),
                  ),
                  TextFormField(
                    initialValue:
                        context.watch<RegViewModel>().userForUpdate?.name ?? "",
                    decoration: const InputDecoration(
                        labelText: "Name",
                        errorStyle: TextStyle(color: Colors.cyan),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan)),
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter name";
                      }
                      return null;
                    },
                    onChanged: context.read<RegViewModel>().onChangeName,
                  ),
                  SizedBox(height: AppDemensions.appSize20),
                  TextFormField(
                    initialValue:
                        context.watch<RegViewModel>().userForUpdate?.surname ??
                            "",
                    decoration: const InputDecoration(labelText: "Surname"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter surname";
                      }
                      return null;
                    },
                    onChanged: context.read<RegViewModel>().onChangeSurname,
                  ),
                  SizedBox(height: AppDemensions.appSize20),
                  TextFormField(
                    initialValue:
                        context.watch<RegViewModel>().userForUpdate?.phone ??
                            "",
                    decoration:
                        const InputDecoration(labelText: "Phone number"),
                    validator: (value) {
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(patttern);
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter mobile number';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                      }
                      return null;
                    },
                    onChanged: context.read<RegViewModel>().onChangePhone,
                  ),
                  SizedBox(height: AppDemensions.appSize20),
                  TextFormField(
                    initialValue:
                        context.watch<RegViewModel>().userForUpdate?.email ??
                            "",
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) {
                      String patttern =
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                      RegExp regExp = RegExp(patttern);
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Please enter email';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid email';
                        }
                      }
                      return null;
                    },
                    onChanged: context.read<RegViewModel>().onChangeEmail,
                  ),
                  SizedBox(height: AppDemensions.appSize20),
                  TextFormField(
                    initialValue:
                        context.watch<RegViewModel>().userForUpdate?.password ??
                            "",
                    decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: IconButton(
                            onPressed: context
                                .read<RegViewModel>()
                                .changeShowPasswordButtonPress,
                            icon: Icon(
                                context.watch<RegViewModel>().hidePassword
                                    ? Icons.lock
                                    : Icons.lock_open))),
                    obscureText: context.watch<RegViewModel>().hidePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      } else if (value.length < 6) {
                        return 'Please enter valid password, min 6 characters';
                      }
                      return null;
                    },
                    onChanged: context.read<RegViewModel>().onChangePassword,
                  ),
                  SizedBox(height: AppDemensions.appSize20),
                  DropdownButtonFormField(
                    value:
                        context.watch<RegViewModel>().userForUpdate?.access ??
                            Access.user,
                    key: key,
                    hint: const Text("User access"),
                    borderRadius:
                        BorderRadius.circular(AppDemensions.appSize20),
                    icon: const Icon(
                      Icons.keyboard_double_arrow_down_sharp,
                    ),
                    items: Access.values
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text(e.name)))
                        .toList(),
                    onChanged: context.read<RegViewModel>().onChangeAccess,
                  ),
                  SizedBox(height: AppDemensions.appSize20),
                  InkWell(
                    onTap: context.read<RegViewModel>().onValidateButtonPress,
                    child: Container(
                      padding: EdgeInsets.all(AppDemensions.appSize10),
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Text(
                              context.watch<RegViewModel>().userForUpdate !=
                                      null
                                  ? "UPDATE"
                                  : "REGISTER")),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
