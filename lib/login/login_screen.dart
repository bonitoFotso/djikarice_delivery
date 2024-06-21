import 'package:djikarice_delivery/login/loginformwidget.dart';
import 'package:djikarice_delivery/login/registerformwidget';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:djikarice_delivery/screens/home_screen.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  bool isLogin = true;
  String email = '';
  String password = '';
  String name = '';
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  void _toggleFormMode() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      try {
        if (isLogin) {
          await authProvider.login(email, password);
        } //else {
        //  await authProvider.register(email, password, name);
        //}

        if (authProvider.isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } catch (e) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Connexion' : 'Inscription'),
        backgroundColor: const Color(0xFF00695C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: isLogin
              ? LoginFormWidget(
                  onToggleFormMode: _toggleFormMode,
                ) as Widget // Cast LoginFormWidget to Widget
              : RegisterFormWidget(
                onToggleFormMode: _toggleFormMode,
              )
                  as Widget, // Cast RegisterFormWidget to Widget
        ),
      ),
    );
  }
}
