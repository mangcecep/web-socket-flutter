import 'package:flutter/material.dart';
import 'package:web_socket_flutter/view/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Color.fromARGB(255, 2, 39, 69)),
        ),
      ),
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterView()),
              ),
              child: Text(
                "register",
                selectionColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
