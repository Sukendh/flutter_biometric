import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinput/pinput.dart';

void main(List<String> args) {
  runApp(BiometricApp());
}

class BiometricApp extends StatelessWidget {
  const BiometricApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      home: AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final String pin = '1234';
  final TextEditingController controller = TextEditingController();
  bool biometricAvaialable = false;
  bool isLoading = false;

  @override
  void initState() {
    _checkBiometricAvailable();
    super.initState();
  }

  Future<void> _checkBiometricAvailable() async {
    try {
      bool available = await auth.canCheckBiometrics;
      setState(() {
        biometricAvaialable = available;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0),
              const Text(
                "Enter PIN",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              const Text(
                "Please enter the 4 digit PIN to continue",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 10.0),
              Pinput(
                controller: controller,
                onCompleted: (value) => _onPinputComplete(value),
              ),
              Spacer(),
              biometricAvaialable
                  ? Column(
                      children: [
                        Text('or'),
                        SizedBox(height: 10),
                        Text(
                          'Please authenticate using biometrics',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: Icon(Icons.fingerprint),
                          label: Text('Login with Biometrics'),
                          onPressed: isLoading
                              ? null
                              : _biometricAuthentication,
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  void _biometricAuthentication() async {
    setState(() {
      isLoading = true;
    });

    if (biometricAvaialable) {
      try {
        bool authenticate = await auth.authenticate(
          localizedReason: 'Authenticate',
          options: AuthenticationOptions(biometricOnly: true, stickyAuth: true),
        );

        if (authenticate) {
          _navigateToSecondScreen();
        } else {}
      } catch (e) {
        print(e.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      return;
    }
  }

  void _onPinputComplete(String enteredPin) {
    if (enteredPin == pin) {
      _navigateToSecondScreen();
    }
  }

  void _navigateToSecondScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return SecondScreen();
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: const Center(
        child: Text(
          "Success",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
