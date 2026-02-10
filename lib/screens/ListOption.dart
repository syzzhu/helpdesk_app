import 'package:flutter/material.dart';
import 'package:helpdesk_app/screens/Complaint/detailComplaintsPage.dart';
import 'package:helpdesk_app/screens/Operation/detailOperation.dart';
import 'package:helpdesk_app/screens/PM/PMPage.dart';
import 'package:helpdesk_app/screens/PM/detailPM.dart';
import 'package:helpdesk_app/screens/dashboard_page.dart';
import 'package:helpdesk_app/screens/qr_scanner_page.dart';
import 'package:helpdesk_app/screens/test.dart';
import 'package:helpdesk_app/model/complaints_model.dart';

class ListOptionsPage extends StatefulWidget {
  const ListOptionsPage({super.key});

  @override
  State<ListOptionsPage> createState() => _ListOptionsState();
}

class _ListOptionsState extends State<ListOptionsPage> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> allData = [];
  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    allData = [
      {
        'name': 'AZUDIN BIN MD.YUSOF\nPENYIARAN (TV & RADIO)',
        'dept': '15th Floor - BERNAMA RADIO',
        'type': 'INTERNET / WIRELESS',
        'status': 'NEW',
        'desc': 'Can’t access internet',
        'color': Colors.redAccent,
      },
    ];
    filteredData = allData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildHeader(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  _buildSectionContainer(
                    context: context,
                    title: "Complaints",
                    dataList: filteredData,
                    enableCardTap: true,
                  ),

                  _buildSectionContainer(
                    context: context,
                    title: "Operations",
                    dataList: filteredData,
                    enableCardTap: true,
                    destinationBuilder: (item) => DetailOperationPage(
                      status: item['status'],
                      name: item['name'],
                      department: item['dept'],
                    ),
                  ),

                  _buildSectionContainer(
                    context: context,
                    title: "PM",
                    dataList: filteredData,
                    enableCardTap: true,
                    destinationBuilder: (item) => DetailPM(
                      status: item['status'],
                      name: item['name'],
                      department: item['dept'],
                    ),
                  ),
                  SizedBox(height: 20),
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
                  //false,
                  //size,
                  destination: const DashboardPage(),
                ),
                _buildQRItem(context),
                _buildNavItem(
                  context,
                  Icons.list_alt_rounded,
                  "Options",
                  //false,
                  //size,
                  destination: const ListOptionsPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00AEEF), Color(0xFF0089BB)],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list_alt_rounded, color: Colors.white, size: 40),
              SizedBox(width: 10),
              Text(
                "List Options",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    String query = value.toLowerCase();
                    filteredData = allData.where((item) {
                      bool matchesName = item['name'].toLowerCase().contains(
                        query,
                      );
                      bool matchesType = item['type'].toLowerCase().contains(
                        query,
                      );
                      return matchesName || matchesType;
                    }).toList();
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search name / type',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Color(0xFF00AEEF)),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= SECTION CONTAINER =================
  Widget _buildSectionContainer({
    required BuildContext context,
    required String title,
    required List<Map<String, dynamic>> dataList,
    Widget? destination,
    Widget Function(Map<String, dynamic> item)? destinationBuilder,
    required bool enableCardTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 15),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Column(
            children: dataList.take(2).map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: _buildOperationCard(
                  context,
                  type: item['type'],
                  status: item['status'],
                  statusColor: item['color'],
                  name: item['name'],
                  department: item['dept'],
                  description: item['desc'],
                  onTap: enableCardTap
                      ? () {
                          if (title == "Complaints") {
                            // Buat objek complaint di sini supaya senang debug ralat
                            final complaintObj = Complaint(
                              id: 0,
                              taskId:
                                  "REQ-${item['status'] == 'NEW' ? '2026001' : '2026002'}",
                              status: item['status'],
                              name: item['name'].toString().split('\n')[0],
                              department: item['dept'] ?? "",
                              terminalId: "NB-0292",
                              location: item['dept'] ?? "",
                              category: item['type'] ?? "UNKNOWN",
                              problemDetail: item['desc'] ?? "",
                              units: "",
                              hp: "",
                              assignTo: [],
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailComplaintsPage(
                                  //data: item,
                                  complaint: complaintObj,
                                ),
                              ),
                            );
                          } else if (destinationBuilder != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => destinationBuilder(item),
                              ),
                            );
                          }
                        }
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ================= CARD =================
  Widget _buildOperationCard(
    BuildContext context, {
    required String type,
    required String status,
    required Color statusColor,
    required String name,
    required String department,
    required String description,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                  _buildChip(type, Colors.blue.shade50, Colors.blue.shade700),
                  _buildChip(status, statusColor.withOpacity(0.1), statusColor),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          department,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
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
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                textAlign: TextAlign.center,
                description,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black,
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  // ================= BOTTOM BAR =================
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
}
