import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/auth/presentation/pages/auth/provider/auth_view_model.dart';
import 'package:pear_market/features/auth/presentation/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
          padding: EdgeInsets.all(AppDemensions.appSize50),
          child: Builder(
            builder: (context) {
              final authStatus = context.watch<AuthViewModel>().authStatus;
              switch (authStatus) {
                case AuthStatus.none:
                case AuthStatus.failed:
                  return const AuthForm();
                case AuthStatus.success:
                case AuthStatus.progress:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          )),
    );
  }
}

class AuthForm extends StatelessWidget {
  const AuthForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "SIGN IN",
            style: GoogleFonts.nanumGothic(fontSize: AppDemensions.appSize25),
          ),
          SizedBox(height: AppDemensions.appSize25),
          CustomTextFormField(
            iconData: Icons.person_outline_outlined,
            onChanged: context.read<AuthViewModel>().onLoginChange,
          ),
          SizedBox(height: AppDemensions.appSize20),
          CustomTextFormField(
            iconData: Icons.lock_open_rounded,
            onChanged: context.read<AuthViewModel>().onPasswordChange,
            isPassword: true,
            showPassIcon: Icons.lock_outline_rounded,
          ),
          SizedBox(height: AppDemensions.appSize20),
          Text(context.watch<AuthViewModel>().eror),
          SizedBox(height: AppDemensions.appSize20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(Theme.of(context).primaryColor),
              ),
              onPressed: context.read<AuthViewModel>().onLoginButtonPress,
              child: Padding(
                padding: EdgeInsets.all(AppDemensions.appSize20),
                child: Text(
                  "LOGIN",
                  style: GoogleFonts.nanumGothic(
                      textStyle: TextStyle(fontSize: AppDemensions.appSize20),
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
              ),
            ),
          ),
          SizedBox(height: AppDemensions.appSize20),
          !context.watch<AuthViewModel>().showBiometrickButton
              ? const SizedBox()
              : Center(
                  child: IconButton(
                    iconSize: AppDemensions.appSize50,
                    onPressed: context.read<AuthViewModel>().loginCheacker,
                    icon: const Icon(Icons.fingerprint),
                  ),
                ),
        ],
      ),
    );
  }
}
