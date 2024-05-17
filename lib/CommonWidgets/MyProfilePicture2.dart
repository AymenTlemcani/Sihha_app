import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class MyProfilePicture2 extends StatelessWidget {
  final String? URL;
  final double? iconSize;
  final double frameRadius;
  final double? pictureRadius;
  final Color? borderColor;
  const MyProfilePicture2(
      {super.key,
      required this.URL,
      required this.frameRadius,
      this.borderColor,
      this.iconSize,
      this.pictureRadius});

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
        child: URL == null || URL!.isEmpty
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
            : CircleAvatar(
                radius: pictureRadius ?? frameRadius,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
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
                            'Error on MyProfilePicture2.dart : ${error.toString()}');
                        return Icon(
                          CupertinoIcons.exclamationmark_triangle,
                          color: Colors.red,
                          size: 29,
                        );
                      },
                    )
                    // Image.network(
                    //   URL!,
                    //   fit: BoxFit.cover,
                    //   errorBuilder: (BuildContext context, Object exception,
                    //       StackTrace? stackTrace) {
                    //     print(
                    //         'Error on MyProfilePicture.dart : ${exception.toString()}');
                    // return Icon(
                    //   CupertinoIcons.exclamationmark_triangle,
                    //   color: Colors.red,
                    //   size: 29,
                    // );
                    //   },
                    // ),
                    ),
              ),
      ),
    );
  }
}
