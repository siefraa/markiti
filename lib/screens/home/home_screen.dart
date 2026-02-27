import 'package:flutter/material.dart';
import '../../models/product_model.dart';
import '../../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  String selectedCategory = 'Yote';
  
  // Mock products data
  final List<Product> allProducts = [
    Product(
      id: '1',
      name: 'Nyanya Fresh',
      description: 'Nyanya safi na fresh kutoka shamba',
      price: 2000,
      category: ProductCategory.mbogaMbichi,
      images: ['https://via.placeholder.com/300'],
      vendorId: '2',
      vendorName: 'John Mwangi',
      stock: 100,
      status: ProductStatus.approved,
      rating: 4.5,
      reviewCount: 25,
      createdAt: DateTime.now(),
    ),
    Product(
      id: '2',
      name: 'Chungwa (Kg)',
      description: 'Machungwa matamu kutoka Tanga',
      price: 3500,
      category: ProductCategory.matunda,
      images: ['https://via.placeholder.com/300'],
      vendorId: '2',
      vendorName: 'John Mwangi',
      stock: 50,
      status: ProductStatus.approved,
      rating: 4.8,
      reviewCount: 42,
      createdAt: DateTime.now(),
    ),
    Product(
      id: '3',
      name: 'Mchele (Kg)',
      description: 'Mchele wa Pakistan wa ubora wa juu',
      price: 2500,
      category: ProductCategory.nafaka,
      images: ['https://via.placeholder.com/300'],
      vendorId: '3',
      vendorName: 'Mary Njeri',
      stock: 200,
      status: ProductStatus.approved,
      rating: 4.6,
      reviewCount: 68,
      createdAt: DateTime.now(),
    ),
    Product(
      id: '4',
      name: 'Nyama ya Ng\'ombe (Kg)',
      description: 'Nyama safi ya ng\'ombe',
      price: 15000,
      category: ProductCategory.nyama,
      images: ['https://via.placeholder.com/300'],
      vendorId: '3',
      vendorName: 'Mary Njeri',
      stock: 30,
      status: ProductStatus.approved,
      rating: 4.7,
      reviewCount: 35,
      createdAt: DateTime.now(),
    ),
  ];

  List<Product> get filteredProducts {
    if (selectedCategory == 'Yote') {
      return allProducts;
    }
    return allProducts.where((p) => p.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twende Markiti'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
          PopupMenuButton(
            icon: const Icon(Icons.account_circle),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8),
                    Text('Wasifu'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'orders',
                child: Row(
                  children: [
                    Icon(Icons.shopping_bag),
                    SizedBox(width: 8),
                    Text('Maagizo Yangu'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Toka'),
                  ],
                ),
              ),
            ],
            onSelected: (value) async {
              if (value == 'logout') {
                await _authService.logout();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              } else if (value == 'orders') {
                Navigator.pushNamed(context, '/orders');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories
          Container(
            height: 60,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildCategoryChip('Yote'),
                ...ProductCategory.getAllCategories()
                    .map((cat) => _buildCategoryChip(cat))
                    .toList(),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Products Grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                    child: Text('Hakuna bidhaa katika kategoria hii'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Kikapu'),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        selectedColor: Colors.green[700],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
        ),
        onSelected: (selected) {
          setState(() {
            selectedCategory = category;
          });
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/product-detail',
            arguments: product,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 120,
              color: Colors.grey[200],
              child: Center(
                child: Icon(
                  Icons.shopping_basket,
                  size: 50,
                  color: Colors.grey[400],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.orange[700]),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating} (${product.reviewCount})',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'TSh ${_formatPrice(product.price)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
