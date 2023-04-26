import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_learning_website/providers/auth_provider.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({super.key});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {

    final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return GestureDetector(
      onTap: () async {
        await authProvider.signInWithGoogle();
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          width: 415,
          height: 100,
          decoration: BoxDecoration(
            color: _isHovered ? Colors.black12 : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/google.png",
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 40),
              const Text("以 Google 帳戶登入", style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
