part of todo1;

///
///
/// [ArrowDirection]
/// [AnimatedArrow]
///
///

enum ArrowDirection {
  left,
  top,
  right,
  bottom,
}

@immutable
class AnimatedArrow extends StatelessWidget {
  const AnimatedArrow._({
    Key? key,
    required this.onTap,
    required this.direction,
  }) : super(key: key);
  final Function onTap;
  final ArrowDirection direction;

  static Widget instanceOf({
    double dimension = 40,
    required ArrowDirection direction,
    required Function onTap,
  }) =>
      switch (direction) {
        ArrowDirection.left => Row(
            children: [
              SizedBox(
                height: double.infinity,
                width: dimension,
                child: Column(children: [
                  AnimatedArrow._(direction: ArrowDirection.left, onTap: onTap)
                ]),
              ),
              VContainer.expanded,
            ],
          ),
        ArrowDirection.right => Row(
            children: [
              VContainer.expanded,
              SizedBox(
                height: double.infinity,
                width: dimension,
                child: Column(children: [
                  AnimatedArrow._(direction: ArrowDirection.right, onTap: onTap)
                ]),
              ),
            ],
          ),
        ArrowDirection.top => Column(
            children: [
              VContainer.expanded,
              SizedBox(
                height: dimension,
                width: double.infinity,
                child: Row(children: [
                  AnimatedArrow._(
                      direction: ArrowDirection.bottom, onTap: onTap)
                ]),
              ),
            ],
          ),
        ArrowDirection.bottom => Column(
            children: [
              SizedBox(
                height: dimension,
                width: double.infinity,
                child: Row(children: [
                  AnimatedArrow._(direction: ArrowDirection.top, onTap: onTap)
                ]),
              ),
              VContainer.expanded,
            ],
          ),
      };

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: direction.index,
      child: InkWell(
        onTap: () => onTap(),
        child: Ani(
          mation: MationTransition.translate(
            tween: VTweenOffset.x_0_05,
            setting: KMationSetting.style1,
          ),
          child: kCenterFlutterLogo,
        ),
      ),
    );
  }
}
