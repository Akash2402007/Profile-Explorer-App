import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import 'like_button.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback onTap;
  final VoidCallback onLike;

  const UserCard({
    super.key,
    required this.user,
    required this.onTap,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(user.picture),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay for better text readability
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          // User Info Overlay
          Positioned(
            left: 12,
            right: 12,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Like button in row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${user.firstName} ${user.lastName}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    LikeButton(
                      isLiked: user.isLiked,
                      onTap: onLike,
                      size: 18,
                    ),
                  ],
                ),
                Text(
                  '${user.age} years • ${user.city}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Tap Area for Navigation
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}