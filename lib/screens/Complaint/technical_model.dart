class AssignTo {
  String name;
  String status;

  AssignTo({
    required this.name,
    required this.status,
  });

  factory AssignTo.fromJson(Map<String, dynamic> json) {
    return AssignTo(
      name: json['name'],
      status: json['status'],
    );
  }

  AssignTo copyWith({String? name, String? status}) {
    return AssignTo(
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}
