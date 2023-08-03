import 'package:flutter/material.dart';
import 'package:pear_market/core/resources/demencions.dart';
import 'package:pear_market/core/service/service_navigation.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppDemensions.appSize50),
        child: Form(
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
              ),
              SizedBox(height: AppDemensions.appSize20),
              CustomTextFormField(
                iconData: Icons.lock_open_rounded,
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
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppNavigationNames.homePage, (route) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(AppDemensions.appSize20),
                    child: const Text("LOGIN"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final IconData iconData;
  const CustomTextFormField({super.key, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(prefixIcon: Icon(iconData)),
    );
  }
}
