import 'package:flutter/material.dart';
import 'package:sleepypandaapp/beratbadan.dart';
import 'tanggallahir.dart';

void main() {
  runApp(const TinggiBadanApp());
}

class TinggiBadanApp extends StatelessWidget {
  const TinggiBadanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          TinggiBadanForm(),
        ]),
      ),
    );
  }
}

class TinggiBadanForm extends StatefulWidget {
  const TinggiBadanForm({super.key});

  @override
  _TinggiBadanFormState createState() => _TinggiBadanFormState();
}

class _TinggiBadanFormState extends State<TinggiBadanForm> {
  int _selectedHeight = 170; // Set default height to 170 cm

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BeratBadanApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToNextPage,
      child: Column(
        children: [
          Container(
            width: 414,
            height: 896,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFF20223F)),
            child: Stack(
              children: [
                const Positioned(
                  left: 27,
                  top: 98,
                  child: SizedBox(
                    width: 354,
                    child: Text(
                      'Berapa tinggi badan mu?',
                      style: TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 18,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 26,
                  top: 49,
                  child: Text(
                    'Selanjutnya, ',
                    style: TextStyle(
                      color: Color(0xFFFBFBFB),
                      fontSize: 24,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.24,
                    ),
                  ),
                ),
                Positioned(
                  left: 124,
                  top: 423,
                  child: Container(
                    width: 85,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF272E49),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: ListWheelScrollView.useDelegate(
                      itemExtent: 40,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _selectedHeight = index + 1; // Heights range from 1 to 300
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          int height = index + 1; // Heights from 1 to 300
                          return Center(
                            child: Text(
                              '$height',
                              style: TextStyle(
                                color: height == _selectedHeight
                                    ? const Color(0xFFFBFBFB)
                                    : const Color(0xFFFBFBFB), // Highlight selected height
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                          );
                        },
                        childCount: 300, // Generate 300 height options (1-300 cm)
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 221,
                  top: 435,
                  child: SizedBox(
                    width: 72,
                    height: 31,
                    child: Text(
                      'Cm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 24,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}