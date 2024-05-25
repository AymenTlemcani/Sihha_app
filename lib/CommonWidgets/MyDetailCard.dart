import 'package:flutter/material.dart';
import 'package:sahha_app/Models/Variables.dart';

class MyDetailCard extends StatefulWidget {
  final String title;
  final String? subtitle;
  final double? height;
  final double? width;
  final IconData leadingIcon;
  final String lastUpdated;
  final String data;
  final String? unity;

  const MyDetailCard(
      {super.key,
      required this.title,
      this.subtitle,
      this.height,
      this.width,
      required this.leadingIcon,
      required this.lastUpdated,
      required this.data,
      this.unity});

  @override
  State<MyDetailCard> createState() => _MyDetailCardState();
}

class _MyDetailCardState extends State<MyDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: SihhaGreen1.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white,
        ),
        child: Container(
          height: widget.height, //130
          width: widget.width, //400
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 35,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(widget.leadingIcon, color: SihhaGreen2),
                          ),
                          Text(
                            widget.title,
                            style: SihhaFont.copyWith(
                              fontSize: 18,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              widget.lastUpdated,
                              style: SihhaFont.copyWith(
                                fontSize: 15,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                  indent: 10,
                  thickness: 1,
                  color: Colors.black.withOpacity(0.1),
                  height: 5,
                  endIndent: 10),
              Expanded(
                flex: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.data,
                                  style: SihhaFont.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${widget.unity}',
                                  style: SihhaFont.copyWith(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
