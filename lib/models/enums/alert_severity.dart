import 'package:flutter/material.dart';

enum AlertSeverity {
  advisory('주의보', Colors.orange, Icons.warning_amber),
  warning('경보', Colors.deepOrange, Icons.warning),
  emergency('긴급', Colors.red, Icons.crisis_alert);

  const AlertSeverity(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;
}
