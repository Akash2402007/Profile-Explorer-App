import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final VoidCallback onTap;
  final double size;

  const LikeButton({
    super.key,
    required this.isLiked,
    required this.onTap,
    this.size = 24.0,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 1.0), weight: 50),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(LikeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLiked != oldWidget.isLiked && widget.isLiked) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: Icon(
          widget.isLiked ? Icons.favorite : Icons.favorite_border,
          color: widget.isLiked ? Colors.red : Colors.grey,
          size: widget.size,
        ),
        onPressed: () {
          widget.onTap();
          if (!widget.isLiked) {
            _controller.forward(from: 0.0);
          }
        },
      ),
    );
  }
}