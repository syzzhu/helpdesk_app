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

    final headerHeight = size.height * 0.32;
    final minHeight = 120.0; // minimum height
    final maxHeight = 300.0; // maximum height

    final responsiveHeaderHeight = headerHeight.clamp(minHeight, maxHeight);
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
            //height: headerHeight,
            constraints: BoxConstraints(minHeight: size.height * 0.25),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              size.width * 0.05,
              size.width * 0.05,
              size.width * 0.05,
              size.width * 0.02, // Kurangkan padding bawah sedikit
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: size.width * 0.07,
                    ),
                    onPressed: () {
                      // CALL LOGOUT FUNCTION
                      _logout(context);
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ComplaintsPage(),
                                    ),
                                  );
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PMPage(),
                                    ),
                                  );
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
                                  [
                                    {'name': 'Morning', 'color': Colors.red},
                                    {
                                      'name': 'Afternoon',
                                      'color': Colors.green,
                                    },
                                    {'name': 'Night', 'color': Colors.purple},
                                  ],
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '15 Jan',
                                  [
                                    {'name': 'Morning', 'color': Colors.red},
                                    {
                                      'name': 'Afternoon',
                                      'color': Colors.green,
                                    },
                                    {'name': 'Night', 'color': Colors.purple},
                                  ],
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '16 Jan',
                                  [
                                    {
                                      'name': 'Afternoon',
                                      'color': Colors.green,
                                    },
                                  ],
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '17 Jan',
                                  [
                                    {'name': 'Evening', 'color': Colors.orange},
                                  ],
                                  shiftRadius,
                                  size,
                                ),
                                const SizedBox(width: 12),
                                _shiftCard(
                                  '18 Jan',
                                  [
                                    {'name': 'Night', 'color': Colors.purple},
                                  ],
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
                _buildNavItem(
                  context,
                  Icons.home_outlined,
                  "Home",
                  false,
                  size,
                ),
                _buildQRItem(context),
                _buildNavItem(
                  context,
                  Icons.list_alt_rounded,
                  "Options",
                  false,
                  size,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LOGOUT FUNCTION
  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Tambah fungsi logout di sini
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
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

  // SHFT CARD
  Widget _shiftCard(
    String date,
    //String shift,
    //Color color,
    List<Map<String, dynamic>> shifts, // List of shifts
    double radius,
    Size size,
  ) {
    //double cardWidth = size.width * 0.42; //adjust card width based on screen size
    double cardHeight = 180; //fixed height

    // Gunakan peratusan lebar skrin, tapi letakkan limit (min/max)
    double cardWidth = (size.width * 0.32).clamp(150.0, 200.0);

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // DATE
          Text(
            date,
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // ===== PILL (IKUT TEKS) =====
          Wrap(
            alignment: WrapAlignment.center, //center pill
            spacing: 6, // jarak antara pill
            runSpacing: 4,
            children: shifts.map((shift) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: ShapeDecoration(
                  color: shift['color'],
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  shift['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              );
            }).toList(),
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
    Size size, {
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
        child: Icon(
          Icons.qr_code_scanner,
          color: Colors.white,
          size: radius * 0.75,
        ),
      ),
    );
  }
}
