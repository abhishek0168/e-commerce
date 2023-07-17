class OrderModel {
  final String id;
  final String amount;
  final String date;
  final Map<dynamic, dynamic> address;
  final List<dynamic> cartDetails;
  final String discount;
  final String delivery;

  OrderModel({
    required this.discount,
    required this.delivery,
    required this.date,
    required this.id,
    required this.amount,
    required this.address,
    required this.cartDetails,
  });
}
