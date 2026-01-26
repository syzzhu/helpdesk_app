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
                        icon: Icon(Icons.logout, color: Colors.white, size: size.width * 0.07),
                        onPressed: () {
                          // Tambah fungsi logout di sini
                        },
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
                          Wrap(
                            alignment: WrapAlignment.spaceAround,
                            runSpacing: spacing,
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
            padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
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
                _buildNavItem(context, Icons.home_outlined, "Home", false, size),
                _buildQRItem(context),
                _buildNavItem(context, Icons.list_alt_rounded, "Options", false, size),
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
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: SizedBox(
      width: radius * 3.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: EdgeInsets.all(radius * 0.18),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$badge',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: radius * 0.45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: radius * 0.35),
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: radius * 0.5,
              fontWeight: FontWeight.w600,
            ),
          ),
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

    final cardWidth = radius * 3.5; //kawal 

    return Container(
      width: cardWidth,
      padding: EdgeInsets.symmetric(vertical: radius * 0.9, horizontal: radius * 0.6),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Sama macam OperationPage
        borderRadius: BorderRadius.circular(radius * 0.8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: radius * 0.55, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: radius * 0.5),

          Container(
            constraints: BoxConstraints(minWidth: radius * 2.2),
            padding: EdgeInsets.symmetric(horizontal: radius * 0.6, vertical: radius * 0.45),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Text(
              shift,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: radius * 0.45,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- NAV ITEM RESPONSIVE ----------------
  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    bool isActive, 
    Size size,{
    Widget? destination,
  }) {
    //final double iconSize = size.width * 0.07; //responsive icon size
    //final double fontSize = size.width * 0.03; //responsive font size

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
            size: size.width * 0.07, // responsive ikut screen
            color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: size.width * 0.035, // responsive
              color: isActive ? const Color(0xFF00AEEF) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRItem(BuildContext context) {
    // get the size of the screen
    final size = MediaQuery.of(context).size;

    // Base size for circle and icon
    final double radius = size.width * 0.07; //responsive size
    //final double iconSize = radius * 0.8; 
    //final double padding = radius * 0.5;
    final double translationY = -radius * 0.2; //transform radius

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
        transform: Matrix4.translationValues(0, translationY, 0),
        padding: EdgeInsets.all(radius * 0.35),
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: radius * 0.3,
              offset: Offset(0, radius * 0.2),
            ),
          ],
        ),
        child: Icon(Icons.qr_code_scanner, color: Colors.white, size: radius * 0.75),
      ),
    );
  }
}
