import 'package:flutter/material.dart';
import 'package:helpdesk_app/model/complaints_model.dart';
import 'detailComplaintsPage.dart';
import '../dashboard_page.dart';
import '../qr_scanner_page.dart';
import 'package:helpdesk_app/screens/ListOption.dart';
import 'package:helpdesk_app/screens/Complaint/acknowlegeComplaints.dart';
import 'package:helpdesk_app/model/assign_to_model.dart';

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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return _buildOperationCard(context, filteredData[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30),
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.report, size: 42, color: Colors.white),
              SizedBox(width: 12),
              Text(
                'Complaints',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                        .where(
                          (item) =>
                              item.name.toLowerCase().contains(
                                value.toLowerCase(),
                              ) ||
                              item.category.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                        )
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

  Widget _buildOperationCard(BuildContext context, Complaint item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: GestureDetector(
        onTap: () {
          String currentStatus = item.status.toUpperCase().trim();
          // Cek jika ada sesiapa dalam senarai assignTo yang statusnya PENDING
          bool isAnyPending =
              item.assignTo?.any(
                (a) => a.status.toUpperCase().trim() == 'PENDING',
              ) ??
              false;

          if (isAnyPending || item.status.toUpperCase() == 'PENDING') {
            // TERUS KE PAGE ACKNOWLEDGE
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
            // KE PAGE DETAIL (Untuk status NEW atau lain-lain)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailComplaintsPage(complaint: item),
              ),
            );
          }
        },
        child: Container(
          // ... rest of your code
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
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildChip(
                      item.category,
                      Colors.blue.shade50,
                      Colors.blue.shade700,
                    ),
                    _buildChip(
                      item.status,
                      _getStatusColor(item.status).withOpacity(0.1),
                      _getStatusColor(item.status),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    // Avatar Pemohon
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.grey[200],
                      child: const Icon(
                        Icons.person_rounded,
                        color: Colors.grey,
                        size: 35,
                      ),
                    ),
                    const SizedBox(width: 15),

                    // Maklumat Teks Pemohon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // NAMA
                          Text(
                            item.name.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),

                          // LOKASI
                          Text(
                            item.location.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.problemDetail,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: text,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            Icons.home_outlined,
            "Home",
            destination: const DashboardPage(),
          ),
          _buildQRItem(context),
          _buildNavItem(
            context,
            Icons.list_alt_rounded,
            "Options",
            destination: const ListOptionsPage(),
          ),
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
        if (destination != null)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
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
}
