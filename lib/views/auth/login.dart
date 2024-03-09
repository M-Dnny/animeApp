import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_app/utils/extentions.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Hero(
                    tag: "logo",
                    child: FlutterLogo(size: 150),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: context.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      color: Colors.cyan.shade200,
                      borderRadius: BorderRadius.circular(20)),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text('Login', style: context.textTheme.headlineMedium),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                              controller: usernameController,
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                } else if (value.length <= 2) {
                                  return "Please enter valid username";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text("Username"),
                                isDense: true,
                                border: UnderlineInputBorder(),
                              )),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                              controller: passwordController,
                              textInputAction: TextInputAction.done,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                label: Text("Password"),
                                isDense: true,
                                border: UnderlineInputBorder(),
                              )),
                        ),
                        const SizedBox(height: 50),
                        FilledButton(
                          style: FilledButton.styleFrom(
                              fixedSize: Size(context.width, 50)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //
                            }
                          },
                          child: const Text('Login',
                              style: TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
