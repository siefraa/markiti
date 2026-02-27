class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final String vendorId;
  final String vendorName;
  final int stock;
  final ProductStatus status;
  final double rating;
  final int reviewCount;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.vendorId,
    required this.vendorName,
    required this.stock,
    this.status = ProductStatus.pending,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      images: List<String>.from(json['images'] ?? []),
      vendorId: json['vendorId'],
      vendorName: json['vendorName'],
      stock: json['stock'],
      status: ProductStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ProductStatus.pending,
      ),
      rating: json['rating']?.toDouble() ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'vendorId': vendorId,
      'vendorName': vendorName,
      'stock': stock,
      'status': status.name,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum ProductStatus {
  pending,
  approved,
  rejected,
  outOfStock,
}

class ProductCategory {
  static const String mbogaMbichi = 'Mboga Mbichi';
  static const String matunda = 'Matunda';
  static const String nafaka = 'Nafaka';
  static const String nyama = 'Nyama na Samaki';
  static const String maziwa = 'Maziwa na Bidhaa Zake';
  static const String vyakula = 'Vyakula Vilivyoandaliwa';
  static const String vinywaji = 'Vinywaji';
  static const String mengineyo = 'Mengineyo';

  static List<String> getAllCategories() {
    return [
      mbogaMbichi,
      matunda,
      nafaka,
      nyama,
      maziwa,
      vyakula,
      vinywaji,
      mengineyo,
    ];
  }
}
