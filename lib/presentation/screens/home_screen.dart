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
                        const Icon(Icons.filter_list),
                        const SizedBox(width: 4),
                        Text(userProvider.selectedCountry),
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
            return const Center(child: CircularProgressIndicator());
          }

          // Error State
          if (userProvider.error.isNotEmpty && userProvider.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${userProvider.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: userProvider.fetchUsers,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Main Content with Pull to Refresh
          return RefreshIndicator(
            onRefresh: () async {
              await userProvider.refreshUsers();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
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