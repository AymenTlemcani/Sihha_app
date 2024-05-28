import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class MyProfilePicture3 extends StatelessWidget {
  final String? URL;
  final File? imageFile;
  final double? iconSize;
  final double frameRadius;
  final double? pictureRadius;
  final double? pictureWidth;
  final double? pictureHeight;
  final Color? borderColor;
  final bool? grayscale;

  const MyProfilePicture3({
    super.key,
    this.URL,
    this.imageFile,
    required this.frameRadius,
    this.borderColor,
    this.iconSize,
    this.pictureRadius,
    this.pictureWidth,
    this.pictureHeight,
    this.grayscale,
  });

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
        radius: frameRadius,
        child: imageFile == null && (URL == null || URL!.isEmpty)
            ? CircleAvatar(
                backgroundColor: Colors.white,
                radius: frameRadius - 5,
                child: Center(
                  child: Icon(
                    CupertinoIcons.person,
                    color: SihhaGreen2,
                    size: iconSize ?? 29,
                  ),
                ),
              )
            : imageFile != null
                ? CircleAvatar(
                    radius: pictureRadius ?? frameRadius,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: imageFile != null
                          ? Image.file(
                              imageFile!, // Pass the File object directly
                              fit: BoxFit.cover,
                            )
                          : Container(), // Add an empty container as a placeholder
                    ),
                  )
                : CircleAvatar(
                    radius: pictureRadius ?? frameRadius,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        color: (grayscale ?? false)
                            ? Colors.black
                            : Colors.transparent,
                        colorBlendMode: (grayscale ?? false)
                            ? BlendMode.saturation
                            : BlendMode.dst,
                        height: pictureHeight ?? 1000,
                        width: pictureWidth ?? 1000,
                        imageUrl: URL!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) {
                          return Container(
                            child: Padding(
                              padding: EdgeInsets.all(130),
                              child: CircularProgressIndicator(
                                value: progress.progress,
                                color: SihhaGreen3,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          print(
                              'Error on MyProfilePicture3.dart : ${error.toString()}');
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
