import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfimation = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(4.0),
                hintText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(4.0),
                hintText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4.0), hintText: "Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordConfimation,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(4.0),
                  hintText: "Password Confirmation"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                elevation: 0,
              ),
              onPressed: () => {},
              child: Text(
                "Submit",
                selectionColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
