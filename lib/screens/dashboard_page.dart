import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    final avatarRadius = size.width * 0.08; // responsive avatar
    final shiftRadius = size.width * 0.065; // responsive shift circle
    final spacing = size.height * 0.02; // responsive spacing

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: size.height - MediaQuery.of(context).padding.top),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // ---------------- HEADER ----------------
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(size.width * 0.05),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00AEEF),
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
                          icon: const Icon(Icons.logout, color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(height: spacing * 0.5),
                      Text(
                        'HelpDesk',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: avatarRadius,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.person, color: Colors.white, size: avatarRadius),
                          ),
                          SizedBox(width: size.width * 0.03),
                          Text(
                            'Hi Syana, today you check in at \n11:49:25 AM',
                            style: TextStyle(color: Colors.black, fontSize: size.width * 0.035),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing * 0.5),
                      Text(
                        'Thursday, 15 Jan',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                      SizedBox(height: spacing * 0.5),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(size.width * 0.04),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          'You finished 0 job today.\nWork Harder!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: size.width * 0.055),
                        ),
                      ),
                    ],
                  ),
                ),
      
                SizedBox(height: spacing),
      
                // ---------------- MAIN CONTENT (VERTICAL CENTER) ----------------
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // TASK SECTION
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        // --TASK CONTAINER--
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(size.width * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                  _taskItem(Icons.report, 'Complaints', 2, Colors.red, avatarRadius),
                                  _taskItem(Icons.print, 'Operation', 0, Colors.blue, avatarRadius),
                                  _taskItem(Icons.settings, 'PM', 6, Colors.green, avatarRadius),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
      
                      SizedBox(height: spacing),
      
                      // SHIFT SCHEDULE
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        // --SS CONTAINER--
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(size.width * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'SHIFT SCHEDULE',
                                style: TextStyle(
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: spacing * 0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _shiftCard('14 Jan', 'Morning', Colors.red, shiftRadius, size),
                                  _shiftCard('15 Jan', 'Morning', Colors.red, shiftRadius, size),
                                  _shiftCard('16 Jan', 'Afternoon', Colors.green, shiftRadius, size),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      
                // ---------------- BOTTOM NAVIGATION ----------------
                Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(Icons.home, size: 50, color: Colors.grey),
                    const Icon(
                      Icons.qr_code_scanner,
                      size: 55,
                      color: Colors.black,
                    ), // Ikon QR
                    const Icon(Icons.list_alt, size: 50, color: Colors.grey),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HELPER FUNCTIONS ----------------
  static Widget _taskItem(IconData icon, String title, int badge, Color color, double radius) {
    return Column(
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
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: radius * 0.3),
        Text(title),
      ],
    );
  }

  static Widget _shiftCard(String date, String shift, Color color, double radius, Size size) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: radius * 0.2),
          CircleAvatar(
            radius: radius,
            backgroundColor: color,
            child: Text(
              shift,
              style: TextStyle(color: Colors.white, fontSize: size.width * 0.03),
            ),
          ),
        ],
      ),
    );
  }
}
