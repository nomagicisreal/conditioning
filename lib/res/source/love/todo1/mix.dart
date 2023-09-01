part of todo1;

///
/// this file contains:
///
/// [MaterialCenterContainerScroll]
/// [MaterialIconButton]
/// [CardInkwellRowIconText]
///

class MaterialCenterContainerScroll extends StatelessWidget {
  const MaterialCenterContainerScroll({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    return Material(
      key: key,
      color: Colors.black12.withAlpha(150),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.8,
            maxHeight: size.height * 0.8,
            minWidth: size.width * 0.5,
          ),
          decoration: KBoxDecorationBorderRadius.circularAllWhite_10,
          child: Padding(
            padding: KEdgeInsets.all_16,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KSizedBox.h10,
                  KProgressIndicator.circular,
                  KSizedBox.h20,
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


@immutable
class MaterialIconButton extends StatelessWidget {
  const MaterialIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);
  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      key: key,
      shape: KBorder.circle,
      clipBehavior: Clip.antiAlias,
      color: context.theme.primaryColor,
      elevation: 20.0,
      child: IconButton(onPressed: onPressed, icon: icon, color: Colors.white),
    );
  }
}

@immutable
class CardInkwellRowIconText extends StatelessWidget {
  const CardInkwellRowIconText({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) => Card(
        key: key,
        elevation: 5,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: KEdgeInsets.all_10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                Padding(padding: KEdgeInsets.onlyLeft_8, child: Text(text))
              ],
            ),
          ),
        ),
      );
}
