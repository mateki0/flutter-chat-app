import 'package:flutter/material.dart';

enum SquareType { first, second, third, fourth, fifth }

class CustomLoader extends StatefulWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class SquareTile extends StatelessWidget {
  final SquareType squareType;
  final double maxSide;
  final double minSide;

  final AnimationController animationController;

  const SquareTile(
      {Key? key,
      required this.squareType,
      this.maxSide = 50,
      this.minSide = 10,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? getColor() {
      switch (squareType) {
        case SquareType.first:
          return Colors.red[200];
        case SquareType.second:
          return Colors.purple[100];
        case SquareType.third:
          return Colors.purple[400];
        case SquareType.fourth:
          return Colors.purple[700];
        case SquareType.fifth:
          return Colors.deepPurple[900];

        default:
          return Colors.black;
      }
    }

    var sequence = TweenSequence([
      TweenSequenceItem(
          tween: Tween<double>(begin: maxSide, end: minSide), weight: 0.5),
      TweenSequenceItem(
          tween: Tween<double>(begin: minSide, end: maxSide), weight: 0.5),
    ]);

    double _getBeginForSquareType() {
      switch (squareType) {
        case SquareType.first:
          return 0;
        case SquareType.second:
          return 0.1;
        case SquareType.third:
          return 0.2;
        case SquareType.fourth:
          return 0.3;
        case SquareType.fifth:
          return 0.4;

        default:
          return 0;
      }
    }

    double _getEndForSquareType() {
      return _getBeginForSquareType() + 0.3;
    }

    var squareSizeChangeTweenAnimation = sequence.animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(_getBeginForSquareType(), _getEndForSquareType(),
            curve: Curves.linear)));

    return AnimatedBuilder(
        animation: squareSizeChangeTweenAnimation,
        builder: (BuildContext context, Widget? child) {
          var side = squareSizeChangeTweenAnimation.value;
          return SizedBox(
            height: maxSide,
            width: maxSide,
            child: Center(
              child: Container(
                color: getColor(),
                width: side,
                height: side,
              ),
            ),
          );
        });
  }
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, value: 0, duration: const Duration(milliseconds: 2000))
      ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SquareTile(
                squareType: SquareType.first,
                animationController: animationController,
              ),
              SquareTile(
                squareType: SquareType.second,
                animationController: animationController,
              ),
              SquareTile(
                squareType: SquareType.third,
                animationController: animationController,
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SquareTile(
              squareType: SquareType.second,
              animationController: animationController,
            ),
            SquareTile(
              squareType: SquareType.third,
              animationController: animationController,
            ),
            SquareTile(
              squareType: SquareType.fourth,
              animationController: animationController,
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SquareTile(
              squareType: SquareType.third,
              animationController: animationController,
            ),
            SquareTile(
              squareType: SquareType.fourth,
              animationController: animationController,
            ),
            SquareTile(
              squareType: SquareType.fifth,
              animationController: animationController,
            ),
          ]),
        ],
      ),
    );
  }
}
