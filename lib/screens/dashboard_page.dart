import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/PMPage.dart';
import 'package:helpdesk_app/screens/complaints.dart';
import 'qr_scanner_page.dart';
import 'dashboard_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'operation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Width = size.width;
    final Height = size.height;

    //Scalling factors
    final avatarRadius = size.width * 0.08;
    final shiftRadius = size.width * 0.065;
    final spacing = size.height * 0.02;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // ---------------- HEADER ----------------
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.05),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: spacing),
                    Text(
                      'HelpDesk',
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
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: avatarRadius,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Text(
                          'Hi Syana, today you check in at \n11:49:25 AM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: spacing * 0.5),
                    Text(
                      'Thursday, 15 Jan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                      ),
                    ),
                    SizedBox(height: spacing * 0.05),
                  ],
                ),
              ),

          // ---------------- MAIN CONTENT ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: spacing),
              child: Column(
                children: [
                  // FLOATING CARD (warna sama macam OperationPage)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width * 0.04),
                      decoration: BoxDecoration(
                        color: Colors.white, // Sama macam OperationPage
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Text(
                        'You finished 0 job today. \nWork Harder!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: size.width * 0.055,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: spacing),

                  // TASK SECTION
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white, // Sama macam OperationPage
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
                          Text(
                            'TASK',
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spacing * 0.5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _taskItem(
                                Icons.report,
                                'Complaints',
                                2,
                                Colors.red,
                                avatarRadius,
                                () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintsPage()));
                                },
                              ),
                              _taskItem(
                                Icons.print,
                                'Operation',
                                0,
                                Colors.blue,
                                avatarRadius,
                                () {
                                  // Navigate ke OperationPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const OperationPage(),
                                    ),
                                  );
                                },
                              ),
                              _taskItem(
                                Icons.settings,
                                'PM',
                                6,
                                Colors.green,
                                avatarRadius,
                                () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PMPage()));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: spacing),

                  // SHIFT SCHEDULE
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(size.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white, // Sama macam OperationPage
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
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // center text
                        children: [
                          Text(
                            'SHIFT SCHEDULE',
                            style: TextStyle(
                              fontSize: size.width * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: spacing * 0.5),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _shiftCard(
                                  '14 Jan',
                                  'Morning',
                                  Colors.red,
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '15 Jan',
                                  'Morning',
                                  Colors.red,
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '16 Jan',
                                  'Afternoon',
                                  Colors.green,
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '17 Jan',
                                  'Evening',
                                  Colors.orange,
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '18 Jan',
                                  'Night',
                                  Colors.purple,
                                  shiftRadius,
                                  size,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: spacing * 2),
                ],
              ),
            ),
          ),

          // ---------------- BOTTOM NAV ----------------
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, Icons.home_outlined, "Home", false),
                _buildQRItem(context),
                _buildNavItem(
                  context,
                  Icons.list_alt_rounded,
                  "Options",
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- HELPER FUNCTIONS ----------------
  Widget _taskItem(
    IconData icon,
    String title,
    int badge,
    Color color,
    double radius,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap, // Fungsi ni akan dipanggil bila user tekan
      borderRadius: BorderRadius.circular(
        10,
      ), // Supaya kesan tekan tu tak petak sangat
      child: Padding(
        padding: const EdgeInsets.all(
          8.0,
        ), // Tambah sikit padding supaya senang nak tekan
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: radius,
                  backgroundColor: color,
                  child: Icon(icon, color: Colors.white, size: radius),
                ),
                if (badge > 0)
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badge',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: radius * 0.3),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _shiftCard(
    String date,
    String shift,
    Color color,
    double radius,
    Size size,
  ) {
    return Container(
      width: size.width * 0.28,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Sama macam OperationPage
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Container(
            constraints: const BoxConstraints(minWidth: 70),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              shift,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive, {
    Widget? destination,
  }) {
    return GestureDetector(
      onTap: () {
        if (destination != null && !isActive) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final String? qrResult = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const QRScannerPage()),
        );

        if (qrResult != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Hasil Scan: $qrResult')));
        }
      },
      child: Container(
        transform: Matrix4.translationValues(0, -5, 0),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30),
      ),
    );
  }
}
