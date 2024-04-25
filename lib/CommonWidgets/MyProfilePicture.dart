import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class MyProfilePicture extends StatelessWidget {
  final String? URL;
  final double? ImageHeight;
  final double? ImageWidth;
  final double radius;
  final Color? borderColor;
  const MyProfilePicture(
      {super.key,
      required this.URL,
      this.ImageHeight,
      this.ImageWidth,
      required this.radius,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: CircleAvatar(
        backgroundColor: borderColor ?? Colors.white,
        radius: radius,
        child: URL == null || URL!.isEmpty
            ? Icon(
                CupertinoIcons.person,
                color: SihhaGreen2,
                size: 29,
              )
            : SizedBox(
                //if no height is provided then it will take the maximum possible space available in its parent container
                height: ImageHeight ?? 1000,
                width: ImageWidth ?? 1000, // same for the width
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    URL!,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Icon(
                        CupertinoIcons.exclamationmark_triangle,
                        color: Colors.red,
                        size: 29,
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
