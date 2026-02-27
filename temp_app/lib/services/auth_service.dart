import '../models/user_model.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  User? _currentUser;

  // Mock authentication - Replace with real backend API calls
  Future<User> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    
    // Mock user data - Replace with actual API call
    if (email == 'admin@twende.com' && password == 'admin123') {
      _currentUser = User(
        id: '1',
        email: email,
        name: 'Super Admin',
        phone: '+255712345678',
        role: UserRole.superAdmin,
        permissions: AppPermissions.getDefaultPermissionsForRole(UserRole.superAdmin),
        createdAt: DateTime.now(),
      );
      return _currentUser!;
    } else if (email == 'vendor@twende.com' && password == 'vendor123') {
      _currentUser = User(
        id: '2',
        email: email,
        name: 'John Vendor',
        phone: '+255723456789',
        role: UserRole.vendor,
        permissions: AppPermissions.getDefaultPermissionsForRole(UserRole.vendor),
        createdAt: DateTime.now(),
      );
      return _currentUser!;
    }
    
    throw Exception('Barua pepe au nenosiri si sahihi');
  }

  Future<User> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock registration - Replace with actual API call
    _currentUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: name,
      phone: phone,
      role: UserRole.customer,
      permissions: AppPermissions.getDefaultPermissionsForRole(UserRole.customer),
      createdAt: DateTime.now(),
    );
    
    return _currentUser!;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  Future<User?> getCurrentUser() async {
    // In a real app, this would check for saved token and fetch user data
    return _currentUser;
  }

  bool isLoggedIn() {
    return _currentUser != null;
  }

  bool hasPermission(String permission) {
    if (_currentUser == null) return false;
    return _currentUser!.hasPermission(permission);
  }

  // Admin functions
  Future<List<User>> getAllUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock users data - Replace with actual API call
    return [
      User(
        id: '1',
        email: 'admin@twende.com',
        name: 'Super Admin',
        phone: '+255712345678',
        role: UserRole.superAdmin,
        permissions: AppPermissions.getDefaultPermissionsForRole(UserRole.superAdmin),
        createdAt: DateTime.now().subtract(const Duration(days: 100)),
      ),
      User(
        id: '2',
        email: 'john@vendor.com',
        name: 'John Mwangi',
        phone: '+255723456789',
        role: UserRole.vendor,
        permissions: AppPermissions.getDefaultPermissionsForRole(UserRole.vendor),
        createdAt: DateTime.now().subtract(const Duration(days: 50)),
      ),
      User(
        id: '3',
        email: 'mary@vendor.com',
        name: 'Mary Njeri',
        phone: '+255734567890',
        role: UserRole.vendor,
        permissions: [
          AppPermissions.viewProducts,
          AppPermissions.createProducts,
          AppPermissions.editProducts,
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      User(
        id: '4',
        email: 'james@admin.com',
        name: 'James Kamau',
        phone: '+255745678901',
        role: UserRole.admin,
        permissions: AppPermissions.getDefaultPermissionsForRole(UserRole.admin),
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      User(
        id: '5',
        email: 'customer@example.com',
        name: 'Jane Doe',
        phone: '+255756789012',
        role: UserRole.customer,
        permissions: [],
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }

  Future<void> updateUserPermissions(String userId, List<String> permissions) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would call your backend API
    // For now, we just simulate the update
  }

  Future<void> updateUserRole(String userId, UserRole role) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would call your backend API
  }

  Future<void> toggleUserStatus(String userId, bool isActive) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would call your backend API
  }

  Future<void> deleteUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, this would call your backend API
  }
}
