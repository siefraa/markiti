class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final UserRole role;
  final List<String> permissions;
  final bool isActive;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.permissions,
    this.isActive = true,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      role: UserRole.values.firstWhere((e) => e.name == json['role']),
      permissions: List<String>.from(json['permissions'] ?? []),
      isActive: json['isActive'] ?? true,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role.name,
      'permissions': permissions,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  bool hasPermission(String permission) {
    return permissions.contains(permission);
  }
}

enum UserRole {
  superAdmin,
  admin,
  vendor,
  customer,
}

class Permission {
  final String id;
  final String name;
  final String description;
  final PermissionCategory category;

  Permission({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: PermissionCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.name,
    };
  }
}

enum PermissionCategory {
  users,
  products,
  orders,
  payments,
  reports,
  settings,
}

// Available permissions
class AppPermissions {
  // User Management
  static const String viewUsers = 'view_users';
  static const String createUsers = 'create_users';
  static const String editUsers = 'edit_users';
  static const String deleteUsers = 'delete_users';
  static const String managePermissions = 'manage_permissions';

  // Product Management
  static const String viewProducts = 'view_products';
  static const String createProducts = 'create_products';
  static const String editProducts = 'edit_products';
  static const String deleteProducts = 'delete_products';
  static const String approveProducts = 'approve_products';

  // Order Management
  static const String viewOrders = 'view_orders';
  static const String updateOrderStatus = 'update_order_status';
  static const String cancelOrders = 'cancel_orders';
  static const String refundOrders = 'refund_orders';

  // Payment Management
  static const String viewPayments = 'view_payments';
  static const String processPayments = 'process_payments';
  static const String refundPayments = 'refund_payments';

  // Reports
  static const String viewReports = 'view_reports';
  static const String exportReports = 'export_reports';

  // Settings
  static const String manageSettings = 'manage_settings';
  static const String viewSystemLogs = 'view_system_logs';

  static List<Permission> getAllPermissions() {
    return [
      // User Management Permissions
      Permission(
        id: viewUsers,
        name: 'Tazama Watumiaji',
        description: 'Uwezo wa kutazama orodha ya watumiaji',
        category: PermissionCategory.users,
      ),
      Permission(
        id: createUsers,
        name: 'Ongeza Watumiaji',
        description: 'Uwezo wa kuongeza watumiaji wapya',
        category: PermissionCategory.users,
      ),
      Permission(
        id: editUsers,
        name: 'Hariri Watumiaji',
        description: 'Uwezo wa kubadilisha taarifa za watumiaji',
        category: PermissionCategory.users,
      ),
      Permission(
        id: deleteUsers,
        name: 'Futa Watumiaji',
        description: 'Uwezo wa kufuta watumiaji',
        category: PermissionCategory.users,
      ),
      Permission(
        id: managePermissions,
        name: 'Simamia Permissions',
        description: 'Uwezo wa kusimamia ruhusa za watumiaji',
        category: PermissionCategory.users,
      ),

      // Product Management Permissions
      Permission(
        id: viewProducts,
        name: 'Tazama Bidhaa',
        description: 'Uwezo wa kutazama bidhaa',
        category: PermissionCategory.products,
      ),
      Permission(
        id: createProducts,
        name: 'Ongeza Bidhaa',
        description: 'Uwezo wa kuongeza bidhaa mpya',
        category: PermissionCategory.products,
      ),
      Permission(
        id: editProducts,
        name: 'Hariri Bidhaa',
        description: 'Uwezo wa kubadilisha taarifa za bidhaa',
        category: PermissionCategory.products,
      ),
      Permission(
        id: deleteProducts,
        name: 'Futa Bidhaa',
        description: 'Uwezo wa kufuta bidhaa',
        category: PermissionCategory.products,
      ),
      Permission(
        id: approveProducts,
        name: 'Thibitisha Bidhaa',
        description: 'Uwezo wa kuthibitisha bidhaa za wauzaji',
        category: PermissionCategory.products,
      ),

      // Order Management Permissions
      Permission(
        id: viewOrders,
        name: 'Tazama Maagizo',
        description: 'Uwezo wa kutazama maagizo',
        category: PermissionCategory.orders,
      ),
      Permission(
        id: updateOrderStatus,
        name: 'Badilisha Hali ya Agizo',
        description: 'Uwezo wa kubadilisha hali ya agizo',
        category: PermissionCategory.orders,
      ),
      Permission(
        id: cancelOrders,
        name: 'Ghairi Maagizo',
        description: 'Uwezo wa kughairi maagizo',
        category: PermissionCategory.orders,
      ),
      Permission(
        id: refundOrders,
        name: 'Rudisha Pesa',
        description: 'Uwezo wa kurudisha pesa kwa maagizo',
        category: PermissionCategory.orders,
      ),

      // Payment Permissions
      Permission(
        id: viewPayments,
        name: 'Tazama Malipo',
        description: 'Uwezo wa kutazama malipo',
        category: PermissionCategory.payments,
      ),
      Permission(
        id: processPayments,
        name: 'Chakata Malipo',
        description: 'Uwezo wa kuchakata malipo',
        category: PermissionCategory.payments,
      ),
      Permission(
        id: refundPayments,
        name: 'Rudisha Malipo',
        description: 'Uwezo wa kurudisha malipo',
        category: PermissionCategory.payments,
      ),

      // Reports Permissions
      Permission(
        id: viewReports,
        name: 'Tazama Ripoti',
        description: 'Uwezo wa kutazama ripoti',
        category: PermissionCategory.reports,
      ),
      Permission(
        id: exportReports,
        name: 'Pakua Ripoti',
        description: 'Uwezo wa kupakua ripoti',
        category: PermissionCategory.reports,
      ),

      // Settings Permissions
      Permission(
        id: manageSettings,
        name: 'Simamia Mipangilio',
        description: 'Uwezo wa kusimamia mipangilio ya mfumo',
        category: PermissionCategory.settings,
      ),
      Permission(
        id: viewSystemLogs,
        name: 'Tazama Kumbukumbu',
        description: 'Uwezo wa kutazama kumbukumbu za mfumo',
        category: PermissionCategory.settings,
      ),
    ];
  }

  static List<String> getDefaultPermissionsForRole(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
        return getAllPermissions().map((p) => p.id).toList();
      case UserRole.admin:
        return [
          viewUsers,
          viewProducts,
          editProducts,
          approveProducts,
          viewOrders,
          updateOrderStatus,
          viewPayments,
          viewReports,
        ];
      case UserRole.vendor:
        return [
          viewProducts,
          createProducts,
          editProducts,
          viewOrders,
          updateOrderStatus,
        ];
      case UserRole.customer:
        return [];
    }
  }
}
