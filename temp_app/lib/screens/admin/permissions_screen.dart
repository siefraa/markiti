import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/auth_service.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  final AuthService _authService = AuthService();
  List<User> users = [];
  bool isLoading = true;
  User? selectedUser;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => isLoading = true);
    try {
      final loadedUsers = await _authService.getAllUsers();
      setState(() {
        users = loadedUsers;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      _showError('Kosa la kupakia watumiaji: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Future<void> _updateUserPermissions(User user, List<String> permissions) async {
    try {
      await _authService.updateUserPermissions(user.id, permissions);
      _showSuccess('Ruhusa zimebadilishwa kikamilifu');
      _loadUsers();
    } catch (e) {
      _showError('Kosa la kubadilisha ruhusa: $e');
    }
  }

  Future<void> _updateUserRole(User user, UserRole role) async {
    try {
      await _authService.updateUserRole(user.id, role);
      _showSuccess('Wadhifa umebadilishwa kikamilifu');
      _loadUsers();
    } catch (e) {
      _showError('Kosa la kubadilisha wadhifa: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simamia Ruhusa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                // Users List
                Expanded(
                  flex: 1,
                  child: _buildUsersList(),
                ),
                const VerticalDivider(width: 1),
                // Permissions Panel
                Expanded(
                  flex: 2,
                  child: selectedUser != null
                      ? _buildPermissionsPanel(selectedUser!)
                      : const Center(
                          child: Text(
                            'Chagua mtumiaji ili kuhariri ruhusa',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildUsersList() {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final isSelected = selectedUser?.id == user.id;
        
        return ListTile(
          selected: isSelected,
          selectedTileColor: Colors.green[50],
          leading: CircleAvatar(
            backgroundColor: _getRoleColor(user.role),
            child: Text(
              user.name[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(user.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.email),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getRoleColor(user.role).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _getRoleText(user.role),
                  style: TextStyle(
                    fontSize: 12,
                    color: _getRoleColor(user.role),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          trailing: Icon(
            user.isActive ? Icons.check_circle : Icons.block,
            color: user.isActive ? Colors.green : Colors.red,
          ),
          onTap: () {
            setState(() {
              selectedUser = user;
            });
          },
        );
      },
    );
  }

  Widget _buildPermissionsPanel(User user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: _getRoleColor(user.role),
                        child: Text(
                          user.name[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(user.email),
                            Text(user.phone),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  // Role Selection
                  const Text(
                    'Wadhifa:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: UserRole.values.map((role) {
                      return ChoiceChip(
                        label: Text(_getRoleText(role)),
                        selected: user.role == role,
                        selectedColor: _getRoleColor(role).withOpacity(0.3),
                        onSelected: (selected) {
                          if (selected) {
                            _showRoleChangeDialog(user, role);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Permissions by Category
          const Text(
            'Ruhusa:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...PermissionCategory.values.map((category) {
            final categoryPermissions = AppPermissions.getAllPermissions()
                .where((p) => p.category == category)
                .toList();
            
            return _buildPermissionCategory(user, category, categoryPermissions);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildPermissionCategory(
    User user,
    PermissionCategory category,
    List<Permission> permissions,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        title: Text(
          _getCategoryText(category),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        children: permissions.map((permission) {
          final hasPermission = user.permissions.contains(permission.id);
          
          return CheckboxListTile(
            title: Text(permission.name),
            subtitle: Text(permission.description),
            value: hasPermission,
            onChanged: (value) {
              final newPermissions = List<String>.from(user.permissions);
              if (value == true) {
                newPermissions.add(permission.id);
              } else {
                newPermissions.remove(permission.id);
              }
              _updateUserPermissions(user, newPermissions);
            },
          );
        }).toList(),
      ),
    );
  }

  void _showRoleChangeDialog(User user, UserRole newRole) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Badilisha Wadhifa'),
        content: Text(
          'Una uhakika unataka kubadilisha wadhifa wa ${user.name} kuwa ${_getRoleText(newRole)}?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ghairi'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _updateUserRole(user, newRole);
            },
            child: const Text('Thibitisha'),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.superAdmin:
        return Colors.purple;
      case UserRole.admin:
        return Colors.blue;
      case UserRole.vendor:
        return Colors.orange;
      case UserRole.customer:
        return Colors.green;
    }
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

  String _getCategoryText(PermissionCategory category) {
    switch (category) {
      case PermissionCategory.users:
        return 'Watumiaji';
      case PermissionCategory.products:
        return 'Bidhaa';
      case PermissionCategory.orders:
        return 'Maagizo';
      case PermissionCategory.payments:
        return 'Malipo';
      case PermissionCategory.reports:
        return 'Ripoti';
      case PermissionCategory.settings:
        return 'Mipangilio';
    }
  }
}
