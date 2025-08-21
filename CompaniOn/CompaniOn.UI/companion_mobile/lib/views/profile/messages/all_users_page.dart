import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/views/profile/messages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/providers/users_provider.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  late UsersProvider _usersProvider;
  List<Users> allUsers = [];
  List<Users> filteredUsers = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _usersProvider = context.read<UsersProvider>();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    var result = await _usersProvider.getPaged(
      filter: {'PageSize': 1000},
    );
    setState(() {
      allUsers = result.items
          .where((u) =>
              u.roleId == loggedUser?.roleId && u.isVisibleToOthers == true)
          .toList();
      isLoading = false;
    });
    _filterUsers('');
  }

  void _filterUsers(String query) {
    searchQuery = query.toLowerCase();
    setState(() {
      filteredUsers = allUsers.where((user) {
        final fullName =
            "${user.firstName ?? ''} ${user.lastName ?? ''}".toLowerCase();
        return fullName.contains(searchQuery);
      }).toList();
    });
  }

  void _sayHi(Users user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          currentUserId: loggedUser?.id ?? 0,
          otherUserId: user.id!,
          otherUserName: user.firstName!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find users', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search users...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _filterUsers,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredUsers.length,
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 0.5),
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return ListTile(
                        leading: const Icon(Icons.account_circle, size: 50),
                        title: Text(
                          "${user.firstName ?? ''} ${user.lastName ?? ''}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: ElevatedButton(
                          onPressed: () => _sayHi(user),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: const Text("Say Hi"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
