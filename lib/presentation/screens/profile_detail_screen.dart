import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/like_button.dart';

class ProfileDetailScreen extends StatelessWidget {
  final String userId;

  const ProfileDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.getUserById(userId);

        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('User not found')),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          body: Stack(
            children: [
              // Full-screen user image
              Positioned.fill(
                child: Hero(
                  tag: 'user_image_${user.id}',
                  child: Image.network(
                    user.picture,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;

                      // Simple loading indicator without shimmer
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  )
                ),
              ),

              // Bottom card overlay
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Like icon row
                      Text(
                        '${user.fullName}, ${user.age}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          LikeButton(
                            isLiked: user.isLiked,
                            onTap: () {
                              userProvider.toggleLike(user.id);
                            },
                          ),
                        ],
                      ),
                     // const SizedBox(height: 6),
                      Text(
                        "${user.city}, ${user.country}",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // iPhone-like small drag bar
              Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 5,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
