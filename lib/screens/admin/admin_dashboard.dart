import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';
import 'permissions_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AuthService _authService = AuthService();
  User? currentUser;
  Map<String, int> stats = {
    'users': 0,
    'vendors': 0,
    'products': 0,
    'orders': 0,
    'revenue': 0,
  };

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    currentUser = await _authService.getCurrentUser();
    // Load statistics
    // In a real app, this would fetch from your backend
    setState(() {
      stats = {
        'users': 150,
        'vendors': 45,
        'products': 320,
        'orders': 890,
        'revenue': 4500000,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard - Twende Markiti'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: currentUser == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  Card(
                    color: Colors.green[700],
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Text(
                              currentUser!.name[0].toUpperCase(),
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Karibu,',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  currentUser!.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    _getRoleText(currentUser!.role),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Statistics Cards
                  const Text(
                    'Takwimu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildStatCard(
                        'Watumiaji',
                        stats['users'].toString(),
                        Icons.people,
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Wauzaji',
                        stats['vendors'].toString(),
                        Icons.store,
                        Colors.orange,
                      ),
                      _buildStatCard(
                        'Bidhaa',
                        stats['products'].toString(),
                        Icons.inventory,
                        Colors.purple,
                      ),
                      _buildStatCard(
                        'Maagizo',
                        stats['orders'].toString(),
                        Icons.shopping_cart,
                        Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Revenue Card
                  Card(
                    color: Colors.green[50],
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mapato ya Mwezi',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  'TSh ${_formatNumber(stats['revenue']!)}',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.trending_up,
                            color: Colors.green,
                            size: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Quick Actions
                  const Text(
                    'Vitendo vya Haraka',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                    children: [
                      if (currentUser!.hasPermission(AppPermissions.managePermissions))
                        _buildActionCard(
                          'Simamia Ruhusa',
                          Icons.admin_panel_settings,
                          Colors.purple,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PermissionsScreen(),
                              ),
                            );
                          },
                        ),
                      if (currentUser!.hasPermission(AppPermissions.viewUsers))
                        _buildActionCard(
                          'Watumiaji',
                          Icons.people,
                          Colors.blue,
                          () {
                            // Navigate to users screen
                          },
                        ),
                      if (currentUser!.hasPermission(AppPermissions.viewProducts))
                        _buildActionCard(
                          'Bidhaa',
                          Icons.inventory,
                          Colors.orange,
                          () {
                            Navigator.pushNamed(context, '/products');
                          },
                        ),
                      if (currentUser!.hasPermission(AppPermissions.viewOrders))
                        _buildActionCard(
                          'Maagizo',
                          Icons.shopping_bag,
                          Colors.green,
                          () {
                            Navigator.pushNamed(context, '/orders');
                          },
                        ),
                      if (currentUser!.hasPermission(AppPermissions.viewReports))
                        _buildActionCard(
                          'Ripoti',
                          Icons.bar_chart,
                          Colors.red,
                          () {
                            // Navigate to reports screen
                          },
                        ),
                      if (currentUser!.hasPermission(AppPermissions.manageSettings))
                        _buildActionCard(
                          'Mipangilio',
                          Icons.settings,
                          Colors.grey,
                          () {
                            // Navigate to settings screen
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRoleText(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
        return 'Super Admin';
      case UserRole.admin:
        return 'Admin';
      case UserRole.vendor:
        return 'Muuzaji';
      case UserRole.customer:
        return 'Mteja';
    }
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
