import 'package:flutter/material.dart';
import 'package:trip_plannerx/db/db_function.dart';
import 'package:trip_plannerx/model/model.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:trip_plannerx/model/model.dart';
import 'package:trip_plannerx/screens/loginscreen.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/img3.jpg'),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.black45, BlendMode.colorDodge)),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Form(
                    key: formKey,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: usernameController,
                              decoration: InputDecoration(
                                  hintText: 'UserName',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 228, 223, 223),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              validator: validateUSerName,
                              style: TextStyle(
                                  color: formKey.currentState?.validate() == false
                                      ? Colors.red
                                      : Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 228, 223, 223),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              validator: validatePassword,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 228, 223, 223),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              validator: validateEmail,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                final String username = usernameController.text;
                                final String password = passwordController.text;
                                final String email = emailController.text;
                    
                                final login = Login(
                                    username: username,
                                    password: password,
                                    email: email);
                                addUser(login);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              }
                            },
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(225, 228, 223, 223),
                                ),
                                foregroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 102, 98, 98),
                                ),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(140, 40))),
                            child: const Text('Create Account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

String? validateUSerName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter UserName';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter Password';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter Email';
  }
  if (!value.contains('@')) {
    return 'Invalid Email format';
  }
  return null;
}

void addUser(Login login) async {
    await DatabaseHelper.addUSer(login);
  }
