import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/profile/profile.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/Login/login_page.dart';
import 'package:helpdesk_app/screens/PM/PMPage.dart';
import 'package:helpdesk_app/screens/Complaint/complaints.dart';
import 'qr_scanner_page.dart';
import 'Operation/operation.dart';
import 'package:helpdesk_app/utils/shift_config.dart'; // ShiftHelper
import 'dart:async';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // ------------------- HELPER FUNCTIONS -------------------
  double responsiveFont(BuildContext context, double multiplier) {
    double baseWidth = MediaQuery.of(context).size.width;
    return (baseWidth * multiplier).clamp(12.0, 32.0);
  }

  double responsiveRadius(BuildContext context, double multiplier) {
    double baseWidth = MediaQuery.of(context).size.width;
    return (baseWidth * multiplier).clamp(20.0, 50.0);
  }

  double responsiveSpacing(BuildContext context, double multiplier) {
    double baseHeight = MediaQuery.of(context).size.height;
    return (baseHeight * multiplier).clamp(8.0, 30.0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;  

    double baseWidth = size.width;
    if (baseWidth > 500) baseWidth = 390;
    
    final orientation = MediaQuery.of(context).orientation;
    final isTablet = size.width >= 600;

    final shiftHeight = isTablet
      ? 260.0
      : (size.height * 0.22).clamp(150.0, 200.0);

    final spacing = responsiveSpacing(context, 0.02);
    final avatarRadius = responsiveRadius(context, 0.08);
    final fontBase = responsiveFont(context, 0.04);

    final Map<String, String> timetables = {
      "Friday 30 Jan": "MC",
      "Saturday 31 Jan": "O",
      "Sunday 01 Feb": "PH",
      "Monday 02 Feb": "PH",
      "Tuesday 03 Feb": "B,OA,O",
    };

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // ---------------- HEADER ----------------
          Container(
            constraints: BoxConstraints(minHeight: size.height * 0.2),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              spacing,
              spacing,
              spacing,
              spacing * 2,
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: responsiveFont(context, 0.07),
                    ),
                    onPressed: () => _logout(context),
                  ),
                ),
                Text(
                  'HelpDesk',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsiveFont(context, 0.07),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: spacing),
                Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(avatarRadius),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black, size: avatarRadius * 1.1),
                      ),
                    ),
                    SizedBox(height: spacing * 0.6),
                    Text(
                      'Hi Syana 👋',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontBase + 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: spacing * 0.2),
                    Text(
                      'Today you check in at 11:49:25 AM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: fontBase - 1,
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
                    fontSize: responsiveFont(context, 0.05),
                  ),
                ),
              ],
            ),
          ),

          // ---------------- MAIN CONTENT ----------------
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                  },
                  // --- TUKAR WARNA ---
                  builder: (context, refreshState, pulledExtent, refreshTriggerPullDistance, refreshIndicatorExtent) {
                    return Center(
                      child: pulledExtent > 0 
                          ? CircularProgressIndicator(
                              value: refreshState == RefreshIndicatorMode.armed || refreshState == RefreshIndicatorMode.refresh
                                  ? null 
                                  : (pulledExtent / refreshTriggerPullDistance).clamp(0.0, 1.0),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00AEEF)),
                              strokeWidth: 3.0,
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: spacing),
                    child: Column(
                      children: [
                        //const SizedBox(height: 5),
                        // --- Floating Job Card ---
                        _buildSectionContainer(
                          context,
                          "",
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30.0),
                            child: Text(
                              'You finished 0 job today. \nWork Harder!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: responsiveFont(context, 0.05),
                                color: Colors.black,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),

                        //SizedBox(height: spacing),

                        // --- TASK SECTION ---
                        _buildSectionContainer(
                          context,
                          "TASK",
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: _taskItem(
                                  context,
                                  Icons.report,
                                  'Complaints',
                                  2,
                                  Colors.red,
                                  avatarRadius,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ComplaintsPage()),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: _taskItem(
                                  context,
                                  Icons.business_center,
                                  'Operation',
                                  0,
                                  Colors.blue,
                                  avatarRadius,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const OperationPage()),
                                    );
                                  },
                                ),
                              ),
                              Expanded(
                                child: _taskItem(
                                  context,
                                  Icons.settings,
                                  'PM',
                                  6,
                                  Colors.green,
                                  avatarRadius,
                                  () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PMPage()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        //SizedBox(height: spacing),

                        // --- SHIFT SCHEDULE SECTION ---
                        _buildSectionContainer(
                          context,
                          "SHIFT SCHEDULE",
                          SizedBox(
                            height: shiftHeight,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: timetables.length,
                              separatorBuilder: (_, __) => SizedBox(width: spacing * 0.6),
                              itemBuilder: (context, index) {
                                final entry = timetables.entries.elementAt(index);
                                return _shiftCard(context, entry.key, entry.value);
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: spacing * 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------------- BOTTOM NAV ----------------
          _buildBottomNavigationBar(context),
        ],
      ),
    );
  }

  // ----------------- REUSABLE WIDGETS -----------------
  Widget _buildSectionContainer(BuildContext context, String title, Widget content) {
  final size = MediaQuery.of(context).size;
  
  final bool isTablet = size.width >= 600;
  // Gunakan pengiraan spacing yang lebih stabil untuk semua device
  final double spacing = (size.width * 0.04).clamp(12.0, 20.0);

  final double titleFontSize = isTablet 
      ? (size.width * 0.035).clamp(20.0, 26.0) 
      : (size.width * 0.045).clamp(15.0, 18.0);
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: spacing, vertical: spacing * 0.5),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.only(top: spacing, bottom: spacing * 0.5),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[800],
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.fromLTRB(spacing, 0, spacing, spacing),
            child: content,
          ),
        ],
      ),
    ),
  );
}

 Widget _shiftCard(
      BuildContext context, String fullDate, String shiftCodes) {
    final size = MediaQuery.of(context).size;

    final isTablet = size.width >= 600;
    final isSmallPhone = size.width < 350;

    final cardWidth = isTablet
    ? 220.0
    : (size.width < 350 ? size.width * 0.45 : size.width * 0.42); // responsive width for phone


    List<String> dateParts = fullDate.split(' ');
    String dayName = dateParts[0];
    String dateNum = fullDate.substring(dayName.length).trim();
    List<String> codes = shiftCodes.split(',');

    return Container(
      width: cardWidth.toDouble(),
      //constraints: const BoxConstraints(minHeight: 10),
      padding: EdgeInsets.all(cardWidth * 0.08),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dayName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (cardWidth * 0.12).clamp(12, 24),
            ),
          ),
          Text(
            dateNum,
            maxLines: 1,
            style: TextStyle(
              fontSize: (cardWidth * 0.10).clamp(10, 20),
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: cardWidth * 0.08),

            Expanded( 
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true, 
                children: codes.map((code) {
                  final info = ShiftHelper.getInfo(code.trim());
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 6),
                    padding: EdgeInsets.symmetric(
                      vertical: isTablet ? 12 : 8,
                      horizontal: 4,
                    ),
                    decoration: ShapeDecoration(
                      color: info['color'],
                      shape: const StadiumBorder(),
                    ),
                    child: FittedBox( // Supaya teks panjang (e.g. "OFF DAY") tidak overflow
                      fit: BoxFit.scaleDown,
                      child: Text(
                        info['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: info['font'],
                          fontWeight: FontWeight.bold,
                          fontSize: (cardWidth * 0.09).clamp(9, 16),
                        ),
                      ),
                    ),
                  );
                }
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskItem(
  BuildContext context,
  IconData icon,
  String title,
  int badge,
  Color color,
  double radius, // avatar radius, boleh tetap
  VoidCallback onTap,
) {
  final size = MediaQuery.of(context).size;

  // Scaling factors
  final iconSize = radius * 1.1; // avatar icon
  final badgeSize = radius * 0.6;
  final fontSize = max(size.width * 0.035, 12).toDouble(); // responsive font
  final labelWidth = radius * 3.5;

  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(radius * 0.5),
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
                child: Icon(icon, color: Colors.white, size: iconSize),
              ),
            ),
            if (badge > 0)
              Positioned(
                top: -badgeSize * 0.25,
                right: -badgeSize * 0.25,
                child: Container(
                  padding: EdgeInsets.all(badgeSize * 0.25),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  constraints: BoxConstraints(
                    minWidth: badgeSize,
                    minHeight: badgeSize,
                  ),
                  child: Text(
                    '$badge',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: badgeSize * 0.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: radius * 0.3),
        SizedBox(
          width: labelWidth,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
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
  final size = MediaQuery.of(context).size;
  final spacing = size.height * 0.015;
  final isTablet = size.width >= 600;

  return Container(
    padding: EdgeInsets.symmetric(vertical: spacing, horizontal: isTablet ? 40 : 0),
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2)),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem(
          context,
          Icons.home_outlined,
          "Home",
          destination: const DashboardPage(),
          iconSize: isTablet ? 36 : 28,
          fontSize: isTablet ? 16 : 11,
        ),
        _buildQRItem(context, iconSize: isTablet ? 36 : 30),
        _buildNavItem(
          context,
          Icons.list_alt_rounded,
          "Options",
          destination: const ListOptionsPage(),
          iconSize: isTablet ? 36 : 28,
          fontSize: isTablet ? 16 : 11,
        ),
      ],
    ),
  );
}


 Widget _buildNavItem(BuildContext context, IconData icon, String label,
    {Widget? destination, double iconSize = 28, double fontSize = 11}) {
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
        Icon(icon, size: iconSize, color: Colors.grey),
        Text(label, style: TextStyle(fontSize: fontSize, color: Colors.grey)),
      ],
    ),
  );
}

Widget _buildQRItem(BuildContext context, {double iconSize = 30}) {
  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QRScannerPage()),
    ),
    child: Container(
      padding: EdgeInsets.all(iconSize * 0.4),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.qr_code_scanner, color: Colors.white, size: iconSize),
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
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
