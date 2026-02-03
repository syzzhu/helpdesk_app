import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/Login/login_page.dart';
import 'package:helpdesk_app/screens/PM/PMPage.dart';
import 'package:helpdesk_app/screens/Complaint/complaints.dart';
import 'qr_scanner_page.dart';
import 'Operation/operation.dart';
import 'package:helpdesk_app/utils/shift_config.dart'; // Pastikan ShiftHelper ada dalam fail ini
import 'dart:async';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // SEMUA DATA & VARIABLE LETAK DI SINI (Sebelum return)
    final size = MediaQuery.of(context).size;
    final spacing = size.height * 0.02;
    final avatarRadius = size.width * 0.08;

    final Map<String, String> timetables = {
      "Friday 30 Jan": "MC",
      "Saturday 31 Jan": "O",
      "Sunday 01 Feb": "PH",
      "Monday 02 Feb": "PH",
      "Tuesday 03 Feb": "B,OA",
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // ---------------- HEADER ----------------
          Container(
            constraints: BoxConstraints(minHeight: size.height * 0.25),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              size.width * 0.05,
              0,
              size.width * 0.05,
              size.width * 0.04,
            ),
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
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: (size.width * 0.07).clamp(24.0, 32.0),
                      ),
                      onPressed: () => _logout(context),
                    ),
                  ),
                  Text(
                    'HelpDesk',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      SizedBox(width: size.width * 0.03),
                      // Guna Flexible di sini
                      Flexible(
                        child: Text(
                          'Hi Syana, today you check in at 11:49:25 AM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.035,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Text(
                    'Thursday, 15 Jan',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------------- MAIN CONTENT ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: spacing),
              child: Column(
                children: [
                  // Floating Job Card
                  _buildSectionContainer(
                    size,
                    "",
                    Text(
                      'You finished 0 job today. \nWork Harder!!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: spacing),

                  // TASK SECTION
                  _buildSectionContainer(
                    size,
                    "TASK",
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _taskItem(
                            Icons.report,
                            'Complaints',
                            2,
                            Colors.red,
                            avatarRadius,
                            () {
                              // Mesti ada Navigator.push di sini
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ComplaintsPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: _taskItem(
                            Icons.business_center,
                            'Operation',
                            0,
                            Colors.blue,
                            avatarRadius,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OperationPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: _taskItem(
                            Icons.settings,
                            'PM',
                            6,
                            Colors.green,
                            avatarRadius,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PMPage(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: spacing),

                  // SHIFT SCHEDULE SECTION
                  _buildSectionContainer(
                    size,
                    "SHIFT SCHEDULE",
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: timetables.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: _shiftCard(entry.key, entry.value, size),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing * 2),
                ],
              ),
            ),
          ),

          // ---------------- BOTTOM NAV ----------------
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  // --- REUSABLE WIDGETS ---

  Widget _buildSectionContainer(Size size, String title, Widget content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.width * 0.05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
            ],
            content,
          ],
        ),
      ),
    );
  }

  Widget _shiftCard(String fullDate, String shiftCodes, Size size) {
    List<String> dateParts = fullDate.split(' ');
    String dayName = dateParts[0];
    String dateNum = dateParts.length > 1
        ? fullDate.substring(dayName.length).trim()
        : "";
    List<String> codes = shiftCodes.split(',');

    return Container(
      width: (size.width * 0.38),
      // Ganti height tetap kepada constraints supaya ia boleh memanjang jika perlu
      constraints: const BoxConstraints(minHeight: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ikut saiz kandungan
        children: [
          Text(
            dayName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.035,
            ),
          ),
          Text(
            dateNum,
            style: TextStyle(
              fontSize: size.width * 0.032,
              color: Colors.grey[800],
            ),
          ),
          const Divider(height: 18),
          // Guna Column biasa, jangan guna ListView di sini untuk elak ralat height
          ...codes.map((code) {
            final info = ShiftHelper.getInfo(code.trim());
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: ShapeDecoration(
                color: info['color'],
                shape: const StadiumBorder(),
              ),
              child: Text(
                info['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: info['font'],
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _taskItem(
    IconData icon,
    String title,
    int badge,
    Color color,
    double radius,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: radius,
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white, size: radius * 1.1),
                ),
              ),
              if (badge > 0)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: Text(
                      '$badge',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // GUNAKAN FITTEDBOX supaya teks mengecil automatik jika ruang sempit
          SizedBox(
            width: radius * 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: radius * 0.45,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home_outlined, "Home",
              destination: const DashboardPage()),
          _buildQRItem(context),
          _buildNavItem(context, Icons.list_alt_rounded, "Options",
              destination: const ListOptionsPage()),
        ],
      ),
    );
  }


  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label, {
    Widget? destination,
  }) {
    return InkWell(
      onTap: () {
        if (destination != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28, color: Colors.grey),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QRScannerPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
      ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (r) => false,
            ),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
