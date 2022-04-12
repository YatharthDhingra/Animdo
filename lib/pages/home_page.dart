import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

//this with thing for passing our class in vsync in animation controller
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100; //initially

  //basically will go from 0% to 100%
  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);
  //a tween is also used for animation
  //this tween is of double data type as its start and end value are of type double
  //tween maps all the values between this start and end and go over them

  AnimationController? _startIconAnimationController;
  //controls animation

  @override
  void initState() {
    //this is used to initialise something in our class
    super.initState();
    _startIconAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4)); //pass our class in vsync
    //vsync allows us to avoid repeated use of class resources and make animation more resource-efficient
    _startIconAnimationController!.repeat(); //to start the animation , once the page loads
    //repeat to keep running the animation
    //.forward() to just run the animation once
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior:
              Clip.none, //Act of restricting the rendering to a particular area
          children: [
            _pageBackground(), //for background color
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularAnimationButton(),
                _starIcon(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
      tween: _backgroundScale,
      duration: const Duration(seconds: 2),

      curve:
          Curves.easeInOutCubicEmphasized, //we can also add curves to this too

      //a function that returns the animation
      builder: (_context, double _scale, _child) {
        // _scale is the value of the tween at a specific moment , _child is the child on which we are operating the animation on
        return Transform.scale(
          //tranform is linearly moving with time
          scale: _scale,
          child: _child,
        );
      },
      child: Container(
        color: Colors.blue,
      ),
    );
  }

  Widget _circularAnimationButton() {
    return Center(
        //wrap the widget with center to center it on the screen
        child: GestureDetector(
            //detects gestures on its child
            onTap: () {
              setState(() {
                //re-renders the screen and also calls the build method again
                _buttonRadius += _buttonRadius == 100 ? 100 : -100;
                //ternary operator -> doubles the size if it is 100 , halves the size if it's 200
              });
            },
            child: AnimatedContainer(
              //we write 'Animated' in front of everything that has animation

              duration: const Duration(
                  seconds: 2), //duration should be given to the animation

              curve: Curves
                  .bounceIn, //our animation takes place linearly by default
              //if we want to change how it transitions from start to end , we do it by using curve

              height:
                  _buttonRadius, //did both _deviceWidth as it should be a circle
              width: _buttonRadius,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(1000)),
              // we gave such a high radius that it becomes circular

              child: const Center(
                child: Text(
                  "Button!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //a centered text inside the button
            )));
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      //takes in an animation , a builder and child on which animation is going to take place
      animation: _startIconAnimationController!.view, //ignore null safety
      builder: (_buildContext, _child) {
        //_child -> just our child that is icon(star)
        return Transform.rotate(
            angle: _startIconAnimationController!.value * 2 * pi,
            child: _child);
        //converting degrees into radian -> import math to use pi
      }, //builder function is called whenever our animation changes
      child: const Icon(
        //a star icon
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
