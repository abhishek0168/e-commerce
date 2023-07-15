class OrderModel {
  final String id;
  final String amount;
  final String date;
  final Map<dynamic, dynamic> address;
  final List<dynamic> cartDetails;

  OrderModel({
    required this.date,
    required this.id,
    required this.amount,
    required this.address,
    required this.cartDetails,
  });
}
