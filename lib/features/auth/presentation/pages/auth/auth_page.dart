import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/features/auth/presentation/pages/auth/provider/auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(AppDemensions.appSize50),
          child: Builder(
            builder: (context) {
              final authStatus = context.watch<AuthViewModel>().authStatus;
              switch (authStatus) {
                case AuthStatus.none:
                  return const AuthForm();
                case AuthStatus.success:
                case AuthStatus.progress:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );

                case AuthStatus.failed:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.watch<AuthViewModel>().eror),
                        SizedBox(height: AppDemensions.appSize25),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () => context
                              .read<AuthViewModel>()
                              .changeAuthStatus(AuthStatus.none),
                          child: Padding(
                            padding: EdgeInsets.all(AppDemensions.appSize20),
                            child: const Text("TRY AGAIN"),
                          ),
                        ),
                      ],
                    ),
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
            style: TextStyle(fontSize: AppDemensions.appSize25),
          ),
          SizedBox(height: AppDemensions.appSize20),
          CustomTextFormField(
            iconData: Icons.person_outline_outlined,
            onChanged: context.read<AuthViewModel>().onLoginChange,
          ),
          SizedBox(height: AppDemensions.appSize20),
          CustomTextFormField(
            iconData: Icons.lock_open_rounded,
            onChanged: context.read<AuthViewModel>().onPasswordChange,
          ),
          SizedBox(height: AppDemensions.appSize20),
          Text(""),
          SizedBox(height: AppDemensions.appSize20),
          Container(
            width: AppDemensions.appSize200,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: context.read<AuthViewModel>().onLoginButtonPress,
              child: Padding(
                padding: EdgeInsets.all(AppDemensions.appSize20),
                child: const Text("LOGIN"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final IconData iconData;
  final void Function(String)? onChanged;
  const CustomTextFormField(
      {super.key, required this.iconData, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(prefixIcon: Icon(iconData)),
      onChanged: onChanged,
    );
  }
}
