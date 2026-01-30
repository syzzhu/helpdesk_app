import 'package:flutter/material.dart';

class ShiftHelper {
  static const Map<String, Map<String, dynamic>> config = {
    // --- STANDARD SHIFT ---
    "A": {"name": "Morning", "color": Color(0xFFCB4E4E), "font": Colors.black},
    "B": {"name": "Morning", "color": Color(0xFFCB4E4E), "font": Colors.black},
    "C": {"name": "Morning", "color": Color(0xFFCB4E4E), "font": Colors.black},
    "D": {"name": "Morning", "color": Color(0xFFCB4E4E), "font": Colors.black},
    "E": {"name": "Morning", "color": Color(0xFFCB4E4E), "font": Colors.black},
    "P": {"name": "Morning", "color": Color(0xFFCB4E4E), "font": Colors.black},
    "F": {
      "name": "Afternoon",
      "color": Color(0xFF6C954D),
      "font": Colors.black,
    },
    "N": {"name": "Night", "color": Color(0xFF8D5BA9), "font": Colors.black},
    "OM": {
      "name": "OT Morning",
      "color": Color(0xFFaf5928),
      "font": Colors.white,
    },
    "OA": {
      "name": "OT Afternoon",
      "color": Color(0xFFaf5928),
      "font": Colors.white,
    },
    "ON": {
      "name": "OT Night",
      "color": Color(0xFFaf5928),
      "font": Colors.white,
    },
    "O": {"name": "Off Day", "color": Colors.black, "font": Colors.white},
    "PH": {
      "name": "Public Holiday",
      "color": Colors.black,
      "font": Color(0xFFE5B420),
    },

    // --- LEAVE TYPE ---
    "AL": {
      "name": "Annual Leave",
      "color": Color(0xFF022263),
      "font": Colors.white,
    },
    "EL": {
      "name": "Emergency",
      "color": Color(0xFFD5AA1B),
      "font": Colors.white,
    },
    "OF": {"name": "Off Day", "color": Color(0xFF043B2A), "font": Colors.white},
    "MC": {"name": "MC", "color": Color(0xFFC60909), "font": Colors.white},
    "TR": {
      "name": "Training",
      "color": Color(0xFFB44786),
      "font": Colors.white,
    },
    "OS": {
      "name": "Outstation",
      "color": Color(0xFF683AA2),
      "font": Colors.white,
    },
    "UL": {
      "name": "Unrecorded",
      "color": Color(0xFF039fc2),
      "font": Colors.white,
    },
    "WFH": {"name": "WFH", "color": Color(0xFF009f79), "font": Colors.white},
  };

  static Map<String, dynamic> getInfo(String code) {
    return config[code] ??
        {"name": code, "color": Colors.grey, "font": Colors.white};
  }
}
