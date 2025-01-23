import 'package:flutter/material.dart';
import 'tinggibadan.dart'; // Pastikan halaman TinggiBadanApp sudah dibuat
import 'package:http/http.dart' as http;
import 'dart:convert';  // Untuk mengolah JSON

void main() {
  runApp(const TanggalLahirApp());
}

class TanggalLahirApp extends StatelessWidget {
  const TanggalLahirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: const Scaffold(
        body: GenderFilled(),
      ),
    );
  }
}

class GenderFilled extends StatefulWidget {
  const GenderFilled({super.key});

  @override
  _GenderFilledState createState() => _GenderFilledState();
}

class _GenderFilledState extends State<GenderFilled> {
  int _selectedDay = 1;
  int _selectedMonth = 1;
  int _selectedYear = DateTime.now().year;

  final List<int> _days = List.generate(31, (index) => index + 1);
  final List<int> _months = List.generate(12, (index) => index + 1);
  final List<int> _years = List.generate(
      DateTime.now().year - 1900 + 1, (index) => DateTime.now().year - index);

  String _formatDate(int value, int digitCount) {
    return value.toString().padLeft(digitCount, '0');
  }

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TinggiBadanApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToNextPage,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF20223F)),
        child: Stack(
          children: [
            const Positioned(
              left: 20,
              top: 70,
              child: Text(
                'Terima kasih!',
                style: TextStyle(
                  color: Color(0xFFFBFBFB),
                  fontSize: 24,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.24,
                ),
              ),
            ),
            const Positioned(
              left: 20,
              top: 115,
              child: SizedBox(
                width: 354,
                child: Text(
                  'Sekarang, kapan tanggal lahir mu?',
                  style: TextStyle(
                    color: Color(0xFFFBFBFB),
                    fontSize: 18,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 57,
              top: 423,
              child: Container(
                width: 300,
                height: 50,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF272E49),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Day Picker
                    Container(
                      width: 50,
                      height: 50,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedDay = _days[index];
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Center(
                              child: Text(
                                _formatDate(_days[index], 2),
                                style: TextStyle(
                                  color: _days[index] == _selectedDay
                                      ? const Color(0xFFFBFBFB)
                                      : const Color(0xFFFBFBFB),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                          childCount: _days.length,
                        ),
                      ),
                    ),
                    const Text(
                      '/',
                      style: TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 24,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    // Month Picker
                    Container(
                      width: 50,
                      height: 50,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedMonth = _months[index];
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Center(
                              child: Text(
                                _formatDate(_months[index], 2),
                                style: TextStyle(
                                  color: _months[index] == _selectedMonth
                                      ? const Color(0xFFFBFBFB)
                                      : const Color(0xFFFBFBFB),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                          childCount: _months.length,
                        ),
                      ),
                    ),
                    const Text(
                      '/',
                      style: TextStyle(
                        color: Color(0xFFFBFBFB),
                        fontSize: 24,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    // Year Picker
                    Container(
                      width: 80,
                      height: 50,
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 40,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            _selectedYear = _years[index];
                          });
                        },
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            return Center(
                              child: Text(
                                _years[index].toString(),
                                style: TextStyle(
                                  color: _years[index] == _selectedYear
                                      ? const Color(0xFFFBFBFB)
                                      : const Color(0xFFFBFBFB),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                            );
                          },
                          childCount: _years.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
