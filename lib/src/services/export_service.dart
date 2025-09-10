import 'dart:convert';
import '../state/orders_state.dart';

class ExportService {
  static String ordersToCsv(List<Order> orders) {
    final sb = StringBuffer();
    sb.writeln('order_id,user_email,total,status,created_at,address');
    for (final o in orders) {
      final user = ''; // no user tracking per order in this mock (could extend)
      final created = o.createdAt.toIso8601String();
      final line = [o.id, user, o.total.toStringAsFixed(0), o.status, created, o.address].map((e) => '"${e.toString().replaceAll('"', '""')}"').join(',');
      sb.writeln(line);
    }
    return sb.toString();
  }
}