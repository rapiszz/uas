import 'package:flutter/material.dart';
import 'login.dart'; // Pastikan Login.dart diimport

class profile3 extends StatelessWidget {
  final int selectedWeight;

  const profile3({super.key, required this.selectedWeight});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Profile(),
          ],
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 414,
          height: 896,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Color(0xFF20223F)),
          child: Stack(
            children: [
              Positioned(
                left: 38,
                top: 452,
                child: GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman Login setelah Logout
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Container(
                    width: 330,
                    height: 50,
                    padding: const EdgeInsets.all(10),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFFBFBFB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Color(0xFF009090),
                            fontSize: 18,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 40,
                top: 284,
                child: Container(
                  width: 334,
                  height: 154,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 53,
                        top: 69,
                        child: Text(
                          'Terms & Conditions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 20,
                        child: Text(
                          'Detil profil',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 315.38,
                        top: 93.38,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-1.57),
                          child: Container(
                            width: 27.38,
                            height: 27.38,
                            child: Stack(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 55,
                        top: 116,
                        child: Text(
                          'Feedback',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 315.38,
                        top: 140.38,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-1.57),
                          child: Container(
                            width: 27.38,
                            height: 27.38,
                            child: Stack(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 22,
                        top: 118,
                        child: Container(
                          width: 16,
                          height: 16,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('images/pencil.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 315.38,
                        top: 43.38,
                        child: Transform(
                          transform: Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-1.57),
                          child: Container(
                            width: 27.38,
                            height: 27.38,
                            child: Stack(),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Container(
                          width: 20,
                          height: 20,
                          padding: const EdgeInsets.only(
                              top: 2, left: 2, right: 3, bottom: 3),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('images/UserWhite.png'),
                                    fit: BoxFit.fill,
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
              ),
              Positioned(
                left: 0,
                top: 826,
                child: Container(
                  width: 414,
                  height: 70,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFF272E49),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 44,
                        top: 43,
                        child: SizedBox(
                          width: 69,
                          child: Text(
                            'Jurnal Tidur',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF627EAE),
                              fontSize: 11,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 315,
                        top: 44,
                        child: SizedBox(
                          width: 49,
                          child: Text(
                            'Profile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 11,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 185,
                        top: 43,
                        child: SizedBox(
                          width: 43,
                          child: Text(
                            'Sleep',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF627EAE),
                              fontSize: 11,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 194,
                        top: 13,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('images/Sleep.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 66,
                        top: 15,
                        child: Container(
                          width: 26,
                          height: 21,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('images/Jurnal.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 327,
                        top: 13,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('images/UserYellow.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 43,
                top: 163,
                child: Container(
                  width: 331,
                  height: 112,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 331,
                          height: 112,
                          decoration: ShapeDecoration(
                            color: Color(0xFF272E49),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 194.04,
                        top: 78,
                        child: Container(
                          width: 124.51,
                          height: 20,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 124.51,
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF009090),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 7.26,
                                top: 3,
                                child: SizedBox(
                                  width: 108.95,
                                  child: Text(
                                    'Lihat profil tidur',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFFBFBFB),
                                      fontSize: 10,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.50,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 40.47,
                        top: 22,
                        child: SizedBox(
                          width: 265.63,
                          child: Text(
                            'Untuk hasil analisa yang lebih baik, akurat, dan bermanfaat. Profil tidur hanya bisa diakses setelah kamu melakukan pelacakan tidur paling tidak 30 hari. ',
                            style: TextStyle(
                              color: Color(0xFFFBFBFB),
                              fontSize: 12,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 167,
                top: 56,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('images/Mask-group.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 350,
                child: Container(
                  width: 17,
                  height: 22.67,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('images/notes.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
