import 'package:flutter/material.dart';

class StatusColors {
  StatusColors._();

  static const Color success = Color(0xFF16A34A);
  static const Color danger = Color(0xFFDC2626);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF2563EB);
  static const Color purple = Color(0xFF7C3AED);
  static const Color neutral = Color(0xFF6B7280);
  static const Color teal = Color(0xFF0891B2);

  static Color getColor(String status) {
    switch (status.trim().toLowerCase()) {
      //Lead status
      case 'new':
        return purple;

      case 'assigned':
        return info;

      case 'contacted':
        return teal;

      case 'qualified':
        return info;

      case 'proposal send':
        return Color(0xFF0891B2);

      case 'negotiation':
        return warning;

      case 'won':
        return success;

      case 'lost':
        return danger;

        //follow up status
        case 'pending':
        return warning;

        case 'completed':
        return success;

        case 'cancelled':
        return neutral;

        //campaign status & employee
        case 'active':
        return success;

        case 'inactive':
        return neutral;

        default:
        return neutral;
        
    }
  }
}
