import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/glass_morphism.dart';

class AnimatedMarkedButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const AnimatedMarkedButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  State<AnimatedMarkedButton> createState() => _AnimatedFavoriteButtonState();
}

class _AnimatedFavoriteButtonState extends State<AnimatedMarkedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  void _handleTap() {
    widget.onTap();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: GlassMorphism(
        borderRadius: 50,
        blur: 3,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white60, width: 0.5),
          ),
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: CircleAvatar(
                  backgroundColor: Colors.white60.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.favorite_rounded,

                    color: widget.isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
