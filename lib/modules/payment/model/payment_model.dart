class PaymentModel {
  final String id;
  final String taskId;
  final String buyerId;
  final double amount;
  final String status;

  PaymentModel({
    required this.id,
    required this.taskId,
    required this.buyerId,
    required this.amount,
    required this.status,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json["id"],
      taskId: json["task_id"],
      buyerId: json["buyer_id"],
      amount: (json["amount"] as num).toDouble(),
      status: json["status"],
    );
  }
}
