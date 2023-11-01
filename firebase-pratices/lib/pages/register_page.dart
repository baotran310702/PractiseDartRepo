import 'package:advancedlessons/components/my_button.dart';
import 'package:advancedlessons/components/my_text_fields.dart';
import 'package:advancedlessons/services/auth/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign up user

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password doesn't match"),
        ),
      );

      return;
    }

    //get auth services
    final authServices = Provider.of<AuthServices>(context, listen: false);

    try {
      await authServices.signUpWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //Logo
                const Icon(
                  Icons.message,
                  size: 100,
                ),
                //Welcome message
                const Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 25),

                //Email field
                MyTextFields(
                    controller: emailController,
                    hintText: "Email",
                    obscureText: false),

                const SizedBox(height: 10),
                //Password field
                MyTextFields(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true),

                const SizedBox(height: 10),
                //Confirm password field
                MyTextFields(
                    controller: confirmPasswordController,
                    hintText: "Confirm your password",
                    obscureText: true),
                const SizedBox(height: 25),
                //not a member? register now

                MyButton(onTap: signUp, text: "Sign Up"),
                const SizedBox(height: 50),

                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already a member?"),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Login now",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
