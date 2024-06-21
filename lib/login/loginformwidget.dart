import 'package:djikarice_delivery/provider/auth_provider.dart';
import 'package:djikarice_delivery/screens/hscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFormWidget extends StatefulWidget {
  final Function() onToggleFormMode;

  const LoginFormWidget({
    super.key,
    required this.onToggleFormMode,
  });

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMessage = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      try {
        await authProvider.login(email, password);

        if (authProvider.isAuthenticated) {
          // Navigate to the home screen
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
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xFF00695C)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00695C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00695C)),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer votre email';
                }
                return null;
              },
              onSaved: (value) => email = value!,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: Color(0xFF00695C)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00695C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00695C)),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez entrer votre mot de passe';
                }
                return null;
              },
              onSaved: (value) => password = value!,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: const Color(0xFF00695C),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: _submitForm,
              child: const Text('Connexion'),
            ),
            TextButton(
              onPressed: widget.onToggleFormMode,
              child: const Text(
                'Créer un compte',
                style: TextStyle(color: Color(0xFF00695C)),
              ),
            ),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
