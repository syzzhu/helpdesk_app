import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/profile/changepass.dart';
import 'package:helpdesk_app/screens/Login/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    // ===== Device type breakpoints =====
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1000;
    final isDesktop = width >= 1000;

    // ===== Sizing =====
    final horizontalPadding = isMobile
        ? 16.0
        : isTablet
            ? width * 0.15
            : width * 0.25;

    final headerPaddingTop = isMobile ? 40.0 : 50.0;
    final avatarRadius = isMobile
        ? 38.0
        : isTablet
            ? 50.0
            : 60.0;
    final headerFontSize = isMobile
        ? 20.0
        : isTablet
            ? 24.0
            : 28.0;
    final labelFontSize = isMobile
        ? 13.0
        : isTablet
            ? 14.0
            : 16.0;
    final buttonHeight = isMobile
        ? 48.0
        : isTablet
            ? 55.0
            : 60.0;
    final buttonFontSize = isMobile
        ? 14.0
        : isTablet
            ? 16.0
            : 18.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ===== HEADER =====
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16, headerPaddingTop, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00AEEF), Color(0xFF0089BB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, size: 30),
                      color: Colors.white,
                      onPressed: () => _logout(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: avatarRadius * 0.95,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'PROFILE',
                  style: TextStyle(
                    fontSize: headerFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== SCROLLABLE CONTENT =====
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 700 : double.infinity,
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _buildField(
                            label: 'NAME',
                            value: 'Syana Binti Ali',
                            fontSize: labelFontSize),
                        _buildField(
                            label: 'DEPARTMENT',
                            value: 'Teknologi Maklumat Komunikasi',
                            fontSize: labelFontSize),
                        _buildField(
                            label: 'DIVISION',
                            value: 'IT Division',
                            fontSize: labelFontSize),
                        _buildField(
                            label: 'LOCATION',
                            value: '4th Floor',
                            fontSize: labelFontSize),
                        _buildField(
                            label: 'EMAIL',
                            value: 'syana@gmail.com',
                            fontSize: labelFontSize),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00AEEF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ChangePasswordPage()),
                              );
                            },
                            child: Text(
                              'CHANGE PASSWORD',
                              style: TextStyle(
                                fontSize: buttonFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      {required String label, required String value, required double fontSize}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFDCDCDC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black54),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (_) => false,
              );
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
