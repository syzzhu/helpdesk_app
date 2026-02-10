import 'dart:convert';

import 'package:helpdesk_app/screens/Complaint/technical_model.dart';

class Complaint {
  final String name;
  final String status;
  final String department;
  final String taskId;
  final String terminalId;
  final String location;
  final String category;
  final String problemDetail;
  final String units;
  final String hp;
  final List<Map<String, String>> assignTo;

  //List<AssignTo> assignTo = [];

  Complaint({
    required this.name,
    required this.status,
    required this.department,
    required this.taskId,
    required this.terminalId,
    required this.location,
    required this.category,
    required this.problemDetail,
    required this.units,
    required this.hp,
    required this.assignTo,
  });

  /*factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        name: json['name'] ?? '',
        status: json['ticket_status'] ?? '',
        department: json['department'] ?? '',
        taskId: json['task_id'] ?? '',
        terminalId: json['terminal_id'] ?? '',
        location: json['location'] ?? '',
        category: json['description'] ?? '',
        problemDetail: json['problem_detail'] ?? '',
        units: json['units'] ?? '',
        hp: json['hp'] ?? '',
      );*/

  Complaint complaintFromJson(Map<String, dynamic> json) {
    // pastikan assign_to sentiasa list
    final assignData = (json['assign_to'] ?? []) as List<dynamic>;

    final List<Map<String, String>> assignList = assignData.map((item) {
      return {
        "name": (item["name"] ?? "-").toString(),
        "status": (item["status"] ?? "-").toString(),
      };
    }).toList();

    return Complaint(
      name: (json["name"] ?? "-").toString(),
      status: (json["status"] ?? "NEW").toString(),
      department: (json["DEPT"] ?? "-").toString(),
      taskId: (json["taskId"] ?? "-").toString(),
      terminalId: (json["terminal_id"] ?? "-").toString(),
      location: (json["location"] ?? "-").toString(),
      category: (json["category"] ?? "-").toString(),
      problemDetail: (json["problem_detail"] ?? "-").toString(),
      assignTo: assignList,
      units: '',
      hp: '',
    );
  }

  /*Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
      'department': department,
      'taskId': taskId,
      'terminalId': terminalId,
      'location': location,
      'category': category,
      'problemDetail': problemDetail,
      'units': units,
      'hp': hp,
      'assignTo': (json['assign_to'] as List)
          .map((e) => AssignTo.fromJson(e))
          .toList(),
    };*/
}

extension on JsonCodec {
  void operator [](String other) {}
}
