import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color? glowColor;
  final bool hasHoverEffect;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.borderRadius = 16,
    this.glowColor,
    this.hasHoverEffect = true,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final borderCol = _isHovered && widget.hasHoverEffect
        ? (widget.glowColor ?? AppColors.primaryAccent).withOpacity(0.4)
        : AppColors.borderLight;
        
    final cardBg = _isHovered && widget.hasHoverEffect
        ? (widget.glowColor ?? AppColors.primaryAccent).withOpacity(0.06)
        : AppColors.glassBg;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered && widget.hasHoverEffect ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              if (_isHovered && widget.hasHoverEffect)
                BoxShadow(
                  color: (widget.glowColor ?? AppColors.primaryAccent).withOpacity(0.12),
                  blurRadius: 24,
                  spreadRadius: -4,
                )
              else
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(color: borderCol, width: 1.2),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    onTap: widget.onTap,
                    splashColor: (widget.glowColor ?? AppColors.primaryAccent).withOpacity(0.1),
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
