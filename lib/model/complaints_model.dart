import 'package:flutter/material.dart';
import 'assign_to_model.dart';

class Complaint {
  final int id;
  final String taskId;
  final String name;
  final String hp;
  final String problemDetail;
  final String category;
  final String status;
  final String location;
  final String terminalId;
  final String units;
  final String department;
  final List<AssignTo> assignTo;

  Complaint({
    required this.id,
    required this.taskId,
    required this.name,
    required this.hp,
    required this.problemDetail,
    required this.category,
    required this.status,
    required this.location,
    required this.terminalId,
    required this.units,
    required this.department,
    required this.assignTo,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    // 1. Proses Problem Detail
    String rawProblem = json['problem_detail'] ?? "";
    String cleanProblem = rawProblem.split('\r\n\r\n').first;

    // 2. Proses Kategori
    String rawDesc = json['description'] ?? "";
    String cleanCategory = "GENERAL";
    if (rawDesc.contains('<b>')) {
      cleanCategory = rawDesc.split('<b>')[1].split('</b>')[0];
    }

    // 3. Proses List AssignTo (PENTING: Gunakan map)
    var list = json['assign_to'] as List?;
    List<AssignTo> assignList = list != null
        ? list.map((i) => AssignTo.fromJson(i)).toList()
        : [];

    return Complaint(
      id: json['id'] ?? 0,
      taskId: json['task_id'] ?? "",
      name: json['name'] ?? json['own_name'] ?? "UNKNOWN",
      problemDetail: cleanProblem,
      category: cleanCategory,
      status: json['tstatus'] ?? json['ticket_status'] ?? "",
      units: json['units'] ?? "",
      hp: json['hp'] ?? "",
      location: json['location'] ?? "",
      terminalId: json['terminal_id'] ?? "",
      department: json['department'] ?? '',
      assignTo: assignList, // GUNAKAN assignList yang kita dah proses kat atas!
    );
  }
}
