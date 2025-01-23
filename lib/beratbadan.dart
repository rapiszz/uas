import 'package:flutter/material.dart';
import 'profile1.dart'; // Import file profile1.dart

void main() {
  runApp(const BeratBadanApp());
}

class BeratBadanApp extends StatelessWidget {
  const BeratBadanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          BeratBadanForm(),
        ]),
      ),
    );
  }
}

class BeratBadanForm extends StatefulWidget {
  const BeratBadanForm({super.key});

  @override
  _BeratBadanFormState createState() => _BeratBadanFormState();
}

class _BeratBadanFormState extends State<BeratBadanForm> {
  int _selectedWeight = 50; // Set default weight to 50 kg

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => profile1(selectedWeight: _selectedWeight), // Kirim data berat badan
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToProfile();
      },
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
                      'Berapa berat badanmu?',
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
                    'Terakhir, ',
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
                          _selectedWeight = index + 1; // Weights range from 1 to 300 kg
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          int weight = index + 1; // Weights from 1 to 300 kg
                          return Center(
                            child: Text(
                              '$weight',
                              style: TextStyle(
                                color: weight == _selectedWeight
                                    ? const Color(0xFFFBFBFB)
                                    : const Color(0xFFFBFBFB), // Highlight selected weight
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                          );
                        },
                        childCount: 300, // Generate 300 weight options (1-300 kg)
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
                      'Kg',
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
