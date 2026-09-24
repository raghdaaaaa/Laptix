import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? trailing;
  final bool centerTitle;
  final double leadingWidth;

  static const double _height = kToolbarHeight + 8;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.trailing,
    this.centerTitle = true,
    this.leadingWidth = 72,
  });

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: _height,
      centerTitle: centerTitle,
      leadingWidth: leadingWidth,
      leading: leading == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(alignment: Alignment.centerLeft, child: leading),
            ),
      title: title,
      actions: [
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: trailing,
          ),
      ],
    );
  }
}