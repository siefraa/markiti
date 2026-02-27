class Order {
  final String id;
  final String customerId;
  final String customerName;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final String deliveryAddress;
  final String phone;
  final PaymentMethod paymentMethod;
  final PaymentStatus paymentStatus;
  final DateTime createdAt;
  final DateTime? deliveredAt;

  Order({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.phone,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.createdAt,
    this.deliveredAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      totalAmount: json['totalAmount'].toDouble(),
      status: OrderStatus.values.firstWhere((e) => e.name == json['status']),
      deliveryAddress: json['deliveryAddress'],
      phone: json['phone'],
      paymentMethod: PaymentMethod.values
          .firstWhere((e) => e.name == json['paymentMethod']),
      paymentStatus: PaymentStatus.values
          .firstWhere((e) => e.name == json['paymentStatus']),
      createdAt: DateTime.parse(json['createdAt']),
      deliveredAt: json['deliveredAt'] != null
          ? DateTime.parse(json['deliveredAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status.name,
      'deliveryAddress': deliveryAddress,
      'phone': phone,
      'paymentMethod': paymentMethod.name,
      'paymentStatus': paymentStatus.name,
      'createdAt': createdAt.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
    };
  }
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final String vendorId;
  final String vendorName;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.vendorId,
    required this.vendorName,
  });

  double get total => price * quantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      productName: json['productName'],
      productImage: json['productImage'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      vendorId: json['vendorId'],
      vendorName: json['vendorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'vendorId': vendorId,
      'vendorName': vendorName,
    };
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled,
  refunded,
}

enum PaymentMethod {
  mpesa,
  cash,
  card,
}

enum PaymentStatus {
  pending,
  completed,
  failed,
  refunded,
}
