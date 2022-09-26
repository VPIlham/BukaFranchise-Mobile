import 'package:equatable/equatable.dart';

class Dashboard extends Equatable {
  final int? id;
  final int? totalProducts;
  final int? totalOrders;
  final int? totalIncome;

  const Dashboard(
      {required this.id,
      required this.totalProducts,
      required this.totalOrders,
      required this.totalIncome});

  factory Dashboard.initialDashboard() {
    return const Dashboard(
      id: 0,
      totalProducts: 0,
      totalOrders: 0,
      totalIncome: 0,
    );
  }

  @override
  String toString() {
    return 'Dashboard(id: $id, totalProducts: $totalProducts, totalOrders: $totalOrders, totalIncome: $totalIncome)';
  }

  @override
  List<Object?> get props => [id, totalProducts, totalOrders, totalIncome];
}
