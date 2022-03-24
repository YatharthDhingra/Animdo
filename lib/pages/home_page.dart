import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double _buttonRadius = 100; //initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior:
              Clip.none, //Act of restricting the rendering to a particular area
          children: [
            _pageBackground(), //for background color
            _circularAnimationButton(),
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return Container(
      color: Colors.blue,
    ); //for background color
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
                  
              curve: Curves.bounceIn,   //our animation takes place linearly by default 
              //if we want to change how it transitions from start to end , we do it by using curve

              height:
                  _buttonRadius, //did both _deviceWidth as it should be a circle
              width: _buttonRadius,
              decoration: BoxDecoration(
                  color: Colors.purple,  
                  borderRadius: BorderRadius.circular(1000)),
                  // we gave such a high radius that it becomes circular

              child: const  Center(child: Text("Button!" , style: TextStyle(color: Colors.white),),),
              //a centered text inside the button
            )));
  }
}
