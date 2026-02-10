import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart';
import 'acknowledgeComplaintsPage.dart';
import '../dashboard_page.dart';
import '../qr_scanner_page.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/Complaint/detailComplaints.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<ComplaintsPage> {
  TextEditingController searchController = TextEditingController();
  List<Complaint> allData = [];
  List<Complaint> filteredData = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    var rawJson = [
      {
        "id": 6982,
        "task_id": "H202601300955310037",
        "task_type": "H",
        "problem_detail": "Printer Problem\r\n\r\nintest: mubin",
        "ticket_status": "PENDING",
        "name": "WAN NOR AZRIYANA BINTI WAN ALI",
        "terminal_id": "2333",
        "description": "<b>PRINTER / SCANNER</b>",
        "location": "11th Floor",
        "units": "UNIT PENGURUSAN PENGETAHUAN",
        "hp": "014 2615580",
        "assign_to": [
          {"name": "SHARIFFUDDIN BIN ALI BASHA", "status": "PENDING"},
          {"name": "MOHD NAZRIN BIN ABU HASSAN", "status": "NEW"},
        ],
      },
      {
        "id": 6983,
        "task_id": "H202601301020440099",
        "problem_detail": "Internet slow\r\n\r\nurgent",
        "ticket_status": "NEW",
        "name": "KAMAL AZUDIN BIN MD.YUSOF",
        "terminal_id": "1010",
        "description": "<b>INTERNET / WIRELESS</b>",
        "location": "15th Floor",
        "units": "UNIT TEKNOLOGI MAKLUMAT",
        "hp": "019 1234567",
        "assign_to": [
          {"name": "SHARIFFUDDIN BIN ALI BASHA", "status": "NEW"},
          {"name": "MOHD NAZRIN BIN ABU HASSAN", "status": "NEW"},
        ],
      },
    ];

    setState(() {
      allData = rawJson.map((item) => Complaint.fromJson(item)).toList();
      filteredData = allData;
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'NEW':
        return const Color(0xFFB73C3C);
      case 'PENDING':
        return Colors.orange;
      case 'COMPLETED':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ambil saiz screen
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Tentukan scale ikut device
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    double headerPaddingTop = isMobile ? 60 : 80;
    double headerPaddingBottom = isMobile ? 30 : 50;
    double avatarRadius = isMobile ? 28 : 40;
    double fontSizeName = isMobile ? 13 : 18;
    double fontSizeLocation = isMobile ? 10 : 14;
    double cardPadding = isMobile ? 12 : 20;
    double cardMargin = isMobile ? 12 : 20;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(headerPaddingTop, headerPaddingBottom, isMobile),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: cardMargin, vertical: 15),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return _buildOperationCard(
                  context,
                  filteredData[index],
                  avatarRadius,
                  fontSizeName,
                  fontSizeLocation,
                  cardPadding,
                  cardMargin,
                  isMobile,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader(double paddingTop, double paddingBottom, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00AEEF), Color(0xFF0089BB)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.report, size: isMobile ? 42 : 56, color: Colors.white),
              SizedBox(width: isMobile ? 12 : 20),
              Text(
                'Complaints',
                style: TextStyle(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 25 : 50),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filteredData = allData
                        .where((item) =>
                            item.name.toLowerCase().contains(value.toLowerCase()) ||
                            item.category.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search name / type',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationCard(
      BuildContext context,
      Complaint item,
      double avatarRadius,
      double fontSizeName,
      double fontSizeLocation,
      double cardPadding,
      double cardMargin,
      bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(bottom: cardMargin),
      child: GestureDetector(
        onTap: () {
          bool isAnyPending =
              item.assignTo?.any((a) => a.status.toUpperCase() == 'PENDING') ?? false;

          if (isAnyPending || item.status.toUpperCase() == 'PENDING') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Acknowlegecomplaints(
                  complaint: item,
                  terminal: item.terminalId,
                  location: item.location,
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailComplaintsPage(complaint: item),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(cardPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildChip(item.category, Colors.blue.shade50, Colors.blue.shade700, isMobile ? 1 : 1.5),
                    _buildChip(item.status,
                        _getStatusColor(item.status).withOpacity(0.1),
                        _getStatusColor(item.status), isMobile ? 1 : 1.5),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: cardPadding, vertical: 5),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(Icons.person_rounded, color: Colors.grey, size: 35),
                    ),
                    SizedBox(width: cardPadding),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeName,
                                color: Colors.black87),
                          ),
                          SizedBox(height: 4),
                          Text(
                            item.location.toUpperCase(),
                            style:
                                TextStyle(fontSize: fontSizeLocation, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(cardMargin),
                padding: EdgeInsets.all(cardPadding),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.problemDetail,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSizeName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color text, double scale) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 12 * scale,
      vertical: 6 * scale,
    ),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10 * scale),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: text,
        fontWeight: FontWeight.bold,
        fontSize: 10 * scale,
      ),
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
}
