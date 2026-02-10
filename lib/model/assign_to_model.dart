class AssignTo {
  final String name;
  final String status;

  AssignTo({required this.name, required this.status});

  // Function untuk tukar JSON jadi objek Dart
  factory AssignTo.fromJson(Map<String, dynamic> json) {
    return AssignTo(name: json['name'] ?? "", status: json['status'] ?? "");
  }
}
