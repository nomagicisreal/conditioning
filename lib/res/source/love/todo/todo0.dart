// import 'dart:math';
//
// import 'package:flutter/material.dart';
//
// ///
// /// this file contains:
// /// [Example3]
// /// [Example4]
// /// [Example7]
// /// [Example8]
// /// [Example9]
// ///
// /// [Examples]
// ///
//
// ///
// /// TODO: test all the possibility of [Direction3D.parseRotation] (2^3 = 8) are what i thought for.
// ///
// class Example3 extends StatefulWidget {
//   const Example3({Key? key}) : super(key: key);
//
//   @override
//   State<Example3> createState() => _Example3State();
// }
//
// class _Example3State extends State<Example3> with TickerProviderStateMixin {
//   bool _isPhaseA = true;
//   late final AnimationController _controllerA;
//   late final AnimationController _controllerB;
//
//   late Tween<Coordinate> _animationA;
//
//   late Tween<Coordinate> _animationB;
//
//   final List<Tween<Coordinate>> _tweens = [
//     Tween(
//       begin: Matrix4Extension.transfer(Coordinate.zero),
//       end: Matrix4Extension.transfer(KCoordinateRadian.angleZ_360),
//     ),
//     Tween(
//       begin: Matrix4Extension.transfer(KCoordinateRadian.angleZ_360),
//       end: Matrix4Extension.transfer(
//         KCoordinateRadian.angleZ_360 + KCoordinateRadian.angleY_360,
//       ),
//     ),
//     Tween(
//       begin: Matrix4Extension.transfer(
//         KCoordinateRadian.angleZ_360 + KCoordinateRadian.angleY_360,
//       ),
//       end: Matrix4Extension.transfer(
//         KCoordinateRadian.angleZ_360 +
//             KCoordinateRadian.angleY_360 +
//             KCoordinateRadian.angleX_360,
//       ),
//     ),
//     Tween(
//       begin: Matrix4Extension.transfer(
//         KCoordinateRadian.angleZ_360 +
//             KCoordinateRadian.angleY_360 +
//             KCoordinateRadian.angleX_360,
//       ),
//       end: Matrix4Extension.transfer(
//         KCoordinateRadian.angleY_360 + KCoordinateRadian.angleX_360,
//       ),
//     ),
//     Tween(
//       begin: Matrix4Extension.transfer(
//         KCoordinateRadian.angleY_360 + KCoordinateRadian.angleX_360,
//       ),
//       end: Matrix4Extension.transfer(KCoordinateRadian.angleX_360),
//     ),
//     Tween(
//       begin: Matrix4Extension.transfer(KCoordinateRadian.angleX_360),
//       end: Matrix4Extension.transfer(Coordinate.zero),
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _controllerA =
//         AnimationController(vsync: this, duration: KDuration.second3);
//     _controllerB =
//         AnimationController(vsync: this, duration: KDuration.second3);
//
//     _animationA = _tweens.addFirstAndRemoveFirstAndGet();
//
//     _controllerB.addStatusListener(_listener);
//     _controllerA.addStatusListener(_listener);
//     _controllerA.forward();
//   }
//
//   @override
//   void dispose() {
//     _controllerA.dispose();
//     _controllerB.dispose();
//     super.dispose();
//   }
//
//   void _listener(AnimationStatus status) {
//     if (status == AnimationStatus.completed) {
//       _isPhaseA = !_isPhaseA;
//       if (_isPhaseA) {
//         _animationA = _tweens.addFirstAndRemoveFirstAndGet();
//         _controllerA.reset();
//         _controllerA.forward();
//       } else {
//         _animationB = _tweens.addFirstAndRemoveFirstAndGet();
//         _controllerB.reset();
//         _controllerB.forward();
//       }
//     }
//   }
//
//   final double perspective = 0.001;
//
//   Coordinate get evaluation => _isPhaseA
//       ? _animationA.evaluate(_controllerA)
//       : _animationB.evaluate(_controllerB);
//
//   List<Widget> get _visibleWidgets => Direction3D.parseRotation(evaluation)
//       .map((d) => d.buildTransform(
//             zDeep: 100,
//             child: switch (d) {
//               Direction3D.front => VContainer.squareYellow_100,
//               Direction3D.back => VContainer.squareBlue_100,
//               Direction3D.left => VContainer.squareRed_100,
//               Direction3D.right => VContainer.squareGreen_100,
//               Direction3D.top => VContainer.squarePurple_100,
//               Direction3D.bottom => VContainer.squareBrown_100,
//             },
//           ))
//       .toList(growable: false);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             KSizedBox.infinityW_300H,
//             AnimatedBuilder(
//               animation: Listenable.merge([_controllerA, _controllerB]),
//               // builder: (_, __) => Transform(
//               //   alignment: Alignment.center,
//               //   transform: Matrix4.identity()
//               //     // ..setPerspective(perspective)
//               //     ..rotated(evaluation),
//               //   child: Stack(children: _visibleWidgets),
//               // ),
//
//               builder: (_, __) => Stack(children: _visibleWidgets),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// ///
// ///
// /// example 4: TODO: learn [Hero] widget
// ///
// ///
//
// class Example4 extends StatelessWidget {
//   const Example4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     const people = Person.people;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('People'),
//       ),
//       body: ListView.builder(
//         itemCount: people.length,
//         itemBuilder: (context, index) {
//           final person = people[index];
//           return ListTile(
//             onTap: () {
//               context.navigator.push(
//                 MaterialPageRoute(
//                   builder: (context) => DetailsPage(person: person),
//                 ),
//               );
//             },
//             leading: Hero(
//               tag: person.name,
//               child: Text(person.emoji, style: KTextStyle.k40),
//             ),
//             title: Text(person.name),
//             subtitle: Text('${person.age} years old'),
//             trailing: KIcon.arrowRight,
//           );
//         },
//       ),
//     );
//   }
// }
//
// class DetailsPage extends StatelessWidget {
//   const DetailsPage({super.key, required this.person});
//
//   final Person person;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Hero(
//           flightShuttleBuilder: (
//             BuildContext flightContext,
//             Animation<double> animation,
//             HeroFlightDirection flightDirection,
//             BuildContext fromHeroContext,
//             BuildContext toHeroContext,
//           ) =>
//               switch (flightDirection) {
//             HeroFlightDirection.push => Material(
//                 color: Colors.transparent,
//                 child: ScaleTransition(
//                   scale: animation.drive(
//                     VTweenDouble.double_0_1.chain(
//                       CurveTween(curve: Curves.fastOutSlowIn),
//                     ),
//                   ),
//                   child: toHeroContext.widget,
//                 ),
//               ),
//             HeroFlightDirection.pop => Material(
//                 color: Colors.transparent,
//                 child: fromHeroContext.widget,
//               ),
//           },
//           tag: person.name,
//           child: Text(person.emoji, style: KTextStyle.k50),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             KSizedBox.h20,
//             Text(person.name, style: KTextStyle.k20),
//             KSizedBox.h20,
//             Text('${person.age} years old', style: KTextStyle.k20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// @immutable
// class Person {
//   final String name;
//   final int age;
//   final String emoji;
//
//   const Person({
//     required this.name,
//     required this.age,
//     required this.emoji,
//   });
//
//   static const List<Person> people = [
//     Person(name: 'John', age: 20, emoji: '🙋🏻‍♂️'),
//     Person(name: 'Jane', age: 21, emoji: '👸🏽'),
//     Person(name: 'Jack', age: 22, emoji: '🧔🏿‍♂️'),
//   ];
// }
//
// ///
// ///
// /// example 7: TODO: use [Mations] to include three kinds of tween in [Ani]
// ///
// ///
//
// class Example7 extends StatefulWidget {
//   const Example7({Key? key}) : super(key: key);
//
//   @override
//   State<Example7> createState() => _Example7State();
// }
//
// class _Example7State extends State<Example7>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController controller;
//
//   late Animation<int> _sidesAnimation;
//   late Animation<double> _radiusAnimation;
//   late Animation<double> _rotationAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = AnimationController(vsync: this, duration: KDuration.second3);
//
//     _sidesAnimation = IntTween(begin: 3, end: 10).animate(controller);
//     _radiusAnimation = VTweenDouble.double_20_400
//         .chain(CurveTween(curve: Curves.bounceInOut))
//         .animate(controller);
//
//     _rotationAnimation = VTweenDouble.angle_0_360
//         .chain(CurveTween(curve: Curves.easeInOut))
//         .animate(controller);
//
//     controller.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedBuilder(
//           animation: Listenable.merge([controller]),
//           builder: (context, child) => Transform(
//             alignment: Alignment.center,
//             transform: Matrix4.identity()
//               ..rotateX(_rotationAnimation.value)
//               ..rotateY(_rotationAnimation.value)
//               ..rotateZ(_rotationAnimation.value),
//             child: CustomPaint(
//               painter: MyPainter.rePaintOf(
//                 canvasSizeToPaint: (_, __) => VPaintStroke.blue_3_capRound,
//                 sizeToPath: FSizeToPath.polygonFromSize(
//                   (size) => RegularPolygon.cornersOf(
//                     _sidesAnimation.value,
//                     size.width / 2,
//                     size: size,
//                   ),
//                 ),
//               ),
//               child: SizedBox(
//                 width: _radiusAnimation.value,
//                 height: _radiusAnimation.value,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// ///
// ///
// /// example 8: TODO: learn [GestureDetector]
// ///
// ///
// class Example8 extends StatelessWidget {
//   const Example8({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Example8Drawer(
//       drawer: Material(
//         child: Container(
//           color: const Color(0xff24283b),
//           child: ListView.builder(
//             padding: KEdgeInsets.onlyLeftTop_100,
//             itemCount: 20,
//             itemBuilder: (context, index) =>
//                 ListTile(title: Text('Item $index')),
//           ),
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Drawer')),
//         body: Container(color: const Color(0xff414868)),
//       ),
//     );
//   }
// }
//
// class Example8Drawer extends StatefulWidget {
//   final Widget child;
//   final Widget drawer;
//
//   const Example8Drawer({
//     super.key,
//     required this.child,
//     required this.drawer,
//   });
//
//   @override
//   State<Example8Drawer> createState() => _Example8DrawerState();
// }
//
// class _Example8DrawerState extends State<Example8Drawer>
//     with TickerProviderStateMixin {
//   late AnimationController _xControllerForChild;
//   late Animation<double> _yRotationAnimationForChild;
//
//   late AnimationController _xControllerForDrawer;
//   late Animation<double> _yRotationAnimationForDrawer;
//
//   @override
//   void initState() {
//     super.initState();
//     _xControllerForChild =
//         AnimationController(vsync: this, duration: KDuration.milli500);
//     _xControllerForDrawer =
//         AnimationController(vsync: this, duration: KDuration.milli500);
//
//     _yRotationAnimationForChild =
//         VTweenDouble.angle_0_90.animate(_xControllerForChild);
//     _yRotationAnimationForDrawer =
//         Tween<double>(begin: pi / 2.7, end: 0).animate(_xControllerForDrawer);
//   }
//
//   @override
//   void dispose() {
//     _xControllerForChild.dispose();
//     _xControllerForDrawer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = context.mediaSize.width;
//     final maxDrag = screenWidth * 0.8;
//
//     return GestureDetector(
//       onHorizontalDragUpdate: (details) {
//         final delta = details.delta.dx / maxDrag;
//         _xControllerForChild.value += delta;
//         _xControllerForDrawer.value += delta;
//       },
//       onHorizontalDragEnd: (details) {
//         if (_xControllerForChild.value < 0.5) {
//           _xControllerForChild.reverse();
//           _xControllerForDrawer.reverse();
//         } else {
//           _xControllerForChild.forward();
//           _xControllerForDrawer.forward();
//         }
//       },
//       child: AnimatedBuilder(
//         animation: Listenable.merge([
//           _xControllerForChild,
//           _xControllerForDrawer,
//         ]),
//         builder: (context, child) {
//           return Stack(
//             children: [
//               Container(color: const Color(0xFF1a1b26)),
//               Transform(
//                 alignment: Alignment.centerLeft,
//                 transform: Matrix4.identity()
//                   ..setEntry(3, 2, 0.001)
//                   ..translate(_xControllerForChild.value * maxDrag)
//                   ..rotateY(_yRotationAnimationForChild.value),
//                 child: widget.child,
//               ),
//               Transform(
//                 alignment: Alignment.centerRight,
//                 transform: Matrix4.identity()
//                   ..setEntry(3, 2, 0.001)
//                   ..translate(
//                       -screenWidth + _xControllerForDrawer.value * maxDrag)
//                   ..rotateY(_yRotationAnimationForDrawer.value),
//                 child: widget.drawer,
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// ///
// ///
// /// example 9: TODO: pre requisition: [Example7], name this effect as a general widget
// ///
// ///
//
// class Example9 extends StatefulWidget {
//   const Example9({super.key});
//
//   @override
//   State<Example9> createState() => _Example9State();
// }
//
// class _Example9State extends State<Example9>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late Animation<double> _iconScaleAnimation;
//   late Animation<double> _containerScaleAnimation;
//   late Animation<Offset> _yAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: KDuration.second1);
//
//     _yAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.23))
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _iconScaleAnimation = Tween<double>(begin: 7, end: 6)
//         .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//
//     _containerScaleAnimation = Tween<double>(begin: 2.0, end: 0.4).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
//
//     _controller
//       ..reset()
//       ..forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = context.mediaSize;
//
//     return Scaffold(
//       appBar: AppBar(title: const Text('Icons')),
//       body: Center(
//         child: ClipRRect(
//           borderRadius: KBorderRadius.allCircular_20,
//           child: Container(
//             decoration: VBoxDecorationStyled.style1,
//             constraints: FSizeToBoxConstraints.minWH100_maxWH08Of(size),
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: KEdgeInsets.all_32,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       KSizedBox.h160,
//                       const Text(
//                         'Thank you for your order!',
//                         textAlign: TextAlign.center,
//                         style: KTextStyle.boldBlack_30,
//                       ),
//                       KSizedBox.h20,
//                       Text(
//                         'Your order will be delivered in 2 days. Enjoy!',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: SlideTransition(
//                     position: _yAnimation,
//                     child: ScaleTransition(
//                       scale: _containerScaleAnimation,
//                       child: Container(
//                         decoration: KBoxDecoration.circleGreen,
//                         child: ScaleTransition(
//                           scale: _iconScaleAnimation,
//                           child: KIcon.check,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Examples extends StatelessWidget {
//   const Examples(this.index, {super.key});
//
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     return switch (index) {
//       3 => const Example3(),
//       4 => const Example4(),
//       7 => const Example7(),
//       8 => const Example8(),
//       9 => const Example9(),
//       _ => throw UnimplementedError(),
//     };
//   }
// }
