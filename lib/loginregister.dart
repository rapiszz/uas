import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart'; // Pastikan Anda mengimpor file register.dart

class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool _isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF20223F),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 197,
              left: 143,
              child: Image.asset(
                'images/panda.png',
                width: 128,
                height: 128,
              ),
            ),
            const Positioned(
              top: 308,
              left: 77,
              child: Text(
                'Sleepy Panda',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFBFBFB),
                  shadows: [
                    Shadow(
                        offset: Offset(1, 1),
                        color: Colors.black,
                        blurRadius: 2),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 580,
              left: 92,
              child: Text(
                'Mulai dengan masuk atau',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
            const Positioned(
              top: 605,
              left: 63,
              child: Text(
                'mendaftar untuk melihat Analisa',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
            const Positioned(
              top: 630,
              left: 170,
              child: Text(
                'tidur mu.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFFBFBFB),
                ),
              ),
            ),
            Positioned(
              top: 691,
              left: 55,
              child: SizedBox(
                width: 306,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF009090),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Navigasi ke halaman register
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login()), // Halaman Register
                    );
                  },
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFBFBFB),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 756,
              left: 55,
              child: SizedBox(
                width: 306,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBFBFB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: Color(0xFF009090)),
                    ),
                  ),
                  onPressed: () {
                    // Navigasi ke halaman register
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Register()), // Halaman Register
                    );
                  },
                  child: const Text(
                    'Daftar',
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF009090),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginRegister(),
  ));
}
