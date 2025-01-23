import 'package:flutter/material.dart';
import 'profile3.dart'; // Import profile2.dart

class profile2 extends StatelessWidget {
  final int selectedWeight;
  const profile2({super.key, required this.selectedWeight});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF20223F),
      ),
      home: ProfileScreen(selectedWeight: selectedWeight),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final int selectedWeight;

  const ProfileScreen({super.key, required this.selectedWeight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileForm(selectedWeight: selectedWeight),
                  const SizedBox(height: 20),
                  SaveButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              profile3(selectedWeight: selectedWeight),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const BottomNavigationWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 61, bottom: 30),
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Mask-group.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileForm extends StatelessWidget {
  final int selectedWeight;

  const ProfileForm({super.key, required this.selectedWeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormField(
          label: 'Nama',
          value: 'Ariane',
          icon: 'UserWhite.png',
          showEditIcon: true,
        ),
        const SizedBox(height: 20),
        const FormField(
          label: 'Email',
          value: 'ariane@mail.com',
          icon: 'Gmail.png',
          showEditIcon: true,
        ),
        const SizedBox(height: 20),
        const FormField(
          label: 'Gender',
          value: 'Female',
          icon: 'Gender.png',
        ),
        const SizedBox(height: 20),
        const FormField(
          label: 'Date of birth',
          value: '30 May 1994',
          icon: 'calendar-event.png',
        ),
        const SizedBox(height: 20),
        const FormField(
          label: 'Height',
          value: '165 Cm',
          icon: 'Rectangle.png',
        ),
        const SizedBox(height: 20),
        FormField(
          label: 'Weight',
          value: '$selectedWeight Kg',
          icon: 'Rectangle.png',
        ),
      ],
    );
  }
}

class FormField extends StatelessWidget {
  final String label;
  final String value;
  final String icon;
  final bool showEditIcon;

  const FormField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.showEditIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: ShapeDecoration(
            color: const Color(0xFF272E49),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Image.asset(
                'images/$icon',
                width: 16,
                height: 16,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported,
                      color: Colors.white, size: 16);
                },
              ),
              const SizedBox(width: 16),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showEditIcon) ...[
                const Spacer(),
                Image.asset(
                  'images/pen.png',
                  width: 15,
                  height: 15,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.edit,
                        color: Colors.white, size: 15);
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: ShapeDecoration(
          color: const Color(0xFF009090),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Center(
          child: Text(
            'Save',
            style: TextStyle(
              color: Color(0xFFFBFBFB),
              fontSize: 18,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF272E49),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 40,
            top: 20,
            child: _buildNavItem(
                'Jurnal Tidur', 'Jurnal.png', const Color(0xFF627EAE)),
          ),
          Positioned(
            left: 190,
            top: 20,
            child: _buildNavItem('Sleep', 'Sleep.png', const Color(0xFF627EAE)),
          ),
          Positioned(
            left: 340,
            top: 20,
            child: _buildNavItem(
                'Profile', 'UserYellow.png', const Color(0xFFFBFBFB)),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String icon, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/$icon',
          width: 25,
          height: 25,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image, size: 25, color: Colors.white);
          },
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 11,
            fontFamily: 'Urbanist',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
