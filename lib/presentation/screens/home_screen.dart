import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_card.dart';
import 'profile_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Explorer'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Country Filter
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.availableCountries.length > 1) {
                return PopupMenuButton<String>(
                  onSelected: (country) {
                    userProvider.setSelectedCountry(country);
                  },
                  itemBuilder: (BuildContext context) {
                    return userProvider.availableCountries.map((String country) {
                      return PopupMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_list, color: Colors.black54),
                        const SizedBox(width: 4),
                        Text(
                          userProvider.selectedCountry,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          // Loading State
          if (userProvider.isLoading && userProvider.users.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error State
          if (userProvider.error.isNotEmpty && userProvider.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load users',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      userProvider.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: userProvider.fetchUsers,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          // Empty State (when filtering)
          if (userProvider.filteredUsers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No users found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  if (userProvider.selectedCountry != 'All') ...[
                    const SizedBox(height: 8),
                    Text(
                      'No users from ${userProvider.selectedCountry}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        userProvider.setSelectedCountry('All');
                      },
                      child: const Text('Show All Countries'),
                    ),
                  ],
                ],
              ),
            );
          }

          // Main Content with Pull to Refresh
          return RefreshIndicator(
            onRefresh: () async {
              await userProvider.fetchUsers();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7, // Perfect for your card design
              ),
              itemCount: userProvider.filteredUsers.length,
              itemBuilder: (context, index) {
                final user = userProvider.filteredUsers[index];
                return UserCard(
                  user: user,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDetailScreen(userId: user.id),
                      ),
                    );
                  },
                  onLike: () {
                    userProvider.toggleLike(user.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}