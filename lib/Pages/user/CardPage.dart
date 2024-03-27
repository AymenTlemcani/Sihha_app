import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> with TickerProviderStateMixin {
  late AnimationController flipAnimationController;
  late Animation<double> flipAnimation;
  double horizontalDrag = 0;

  bool isFront = true;
  bool _showCard = false;

  void _showTemporaryImage() {
    setState(() {
      _showCard = true;
    });

    Future.delayed(Duration(seconds: 30000), () {
      setState(() {
        _showCard = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    flipAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    flipAnimationController.addListener(() {
      setState(() {
        horizontalDrag = flipAnimation.value;
        setCardSide();
      });
    });
  }

  void resetCardState() {
    setState(() {
      horizontalDrag = 0;
      isFront = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_showCard)
              ElevatedButton(
                onPressed: () {
                  _showTemporaryImage();
                },
                child: Text("DEMANDER VOTRE CARTE SIHHA"),
              ),
            SizedBox(height: 20),
            if (_showCard) buildAnimatedCard(),
          ],
        ),
      ),
    );
  }

  Widget buildAnimatedCard() {
    return Container(
      width: 350,
      height: 200,
      child: GestureDetector(
        onHorizontalDragStart: (_) {
          flipAnimationController.reset();
          setState(() {
            resetCardState();
          });
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            horizontalDrag += details.primaryDelta!;
            horizontalDrag %= 360;
            setCardSide();
          });
        },
        onHorizontalDragEnd: (_) {
          final double end = 360 - horizontalDrag >= 180 ? 0 : 360;

          flipAnimation = Tween<double>(begin: horizontalDrag, end: end)
              .animate(flipAnimationController);

          flipAnimationController.forward();
        },
        child: AnimatedBuilder(
          animation: flipAnimationController,
          builder: (context, child) => Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, .001)
              ..rotateY((horizontalDrag / 180) * 3.14),
            child: isFront ? cardFront : cardBack,
          ),
        ),
      ),
    );
  }

  Widget get cardBack => Card(
        elevation: 12,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 220,
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFECF8F3), Colors.white],
              stops: [0.0, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(.002),
                offset: const Offset(0, 15),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/codeqr.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget get cardFront => Card(
        elevation: 12,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(20),
          width: 220,
          height: 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD9F2E7), Color(0xFFECF8F3), Colors.white],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(.002),
                offset: const Offset(0, 15),
                blurRadius: 30,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ETCHIALI ABDELHAKE",
                        style: TextStyle(
                          color: Color(0xFF41BE88),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "DD/MM/YY",
                        style: TextStyle(
                          color: Color(0xFF41BE88),
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "TLEMCEN",
                        style: TextStyle(
                          color: Color(0xFF41BE88),
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "XXXXXXXXXX",
                        style: TextStyle(
                          color: Color(0xFF41BE88),
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/Etchiali.jpeg',
                          width: 90,
                          height: 98,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "XXXXXXXXXX",
                  style: TextStyle(
                    color: Color(0xFF41BE88),
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  setCardSide() {
    isFront = (horizontalDrag <= 90 || horizontalDrag >= 270);
  }
}
