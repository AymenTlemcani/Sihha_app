import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class MyDrawerTile extends StatefulWidget {
  final Color? unselectedIconColor;
  final Color? unselectedLabelColor;
  final Color? unselectedButtonColor;
  final Color? selectedIconColor;
  final Color? selectedLabelColor;
  final Color? selectedButtonColor;
  final Color? hoveredButtonColor;
  final Color? hoveredLabelColor;
  final Color? hoveredIconColor;

  final String label;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final double? buttonHeight;
  final double? borderRadius;
  final double? iconSize;
  final double? labelSize;
  final int? index;
  final int? selectedIndex;

  final VoidCallback? onTap;
  final Function(int)? callback;

  const MyDrawerTile({
    Key? key,
    this.unselectedIconColor,
    this.unselectedLabelColor,
    this.unselectedButtonColor,
    this.selectedIconColor,
    this.selectedLabelColor,
    this.selectedButtonColor,
    required this.label,
    required this.selectedIcon,
    required this.unselectedIcon,
    this.buttonHeight,
    this.borderRadius,
    this.iconSize,
    this.labelSize,
    this.hoveredButtonColor,
    this.hoveredLabelColor,
    this.hoveredIconColor,
    required this.onTap,
    this.index,
    this.selectedIndex,
    this.callback,
  }) : super(key: key);

  @override
  State<MyDrawerTile> createState() => _MyDrawerTileState();
}

class _MyDrawerTileState extends State<MyDrawerTile> {
  bool isSelected = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedIndex == widget.index;
    return InkWell(
      onHover: (value) {
        setState(() {
          isHovered = value;
        });
      },
      onTap: () {
        // Clear existing routes
        Navigator.of(context).popUntil((route) => route.isFirst);

        // Navigate to the new screen
        widget.onTap!();
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: widget.buttonHeight ?? 50,
          decoration: BoxDecoration(
            color: isSelected
                ? widget.selectedButtonColor ?? SihhaGreen1
                : isHovered
                    ? (widget.hoveredButtonColor ??
                        SihhaGreen1.withOpacity(0.18))
                    : (widget.unselectedButtonColor ?? CupertinoColors.white),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            boxShadow: [
              if (!(isHovered || isSelected))
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 0.2,
                ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: SihhaGreen1.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 0.3,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    isSelected ? widget.selectedIcon : widget.unselectedIcon,
                    size: (isHovered || isSelected)
                        ? (widget.iconSize ?? 20) + 2
                        : (widget.iconSize ?? 20),
                    color: isSelected
                        ? widget.selectedIconColor ?? SihhaGreen1
                        : (isHovered && !isSelected)
                            ? (widget.hoveredIconColor ?? SihhaGreen2)
                            : (widget.unselectedIconColor ??
                                CupertinoColors.systemGrey),
                  ),
                ),
              ),
              SizedBox(width: 20),
              AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 100),
                style: SihhaFont.copyWith(
                  fontSize: (isHovered || isSelected)
                      ? (widget.labelSize ?? 13) + 2
                      : (widget.labelSize ?? 13),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  color: isSelected
                      ? widget.selectedLabelColor ?? Colors.white
                      : (isHovered && !isSelected)
                          ? (widget.hoveredLabelColor ?? Colors.black87)
                          : (widget.unselectedLabelColor ??
                              CupertinoColors.systemGrey),
                ),
                child: Text(widget.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
