part of todo1;

///
/// this file contains:
/// [CustomRow]
/// [CustomColumn]
/// [CustomScaffold]
/// [CustomDrawer]
/// [CustomBottomNavigationBar]
/// [CustomCard]
/// [CustomTextFormField]
/// [CustomListTile]
///

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn._({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  factory CustomColumn.titled({
    Key? key,
    required Text title,
    required List<Widget> children,
  }) =>
      CustomColumn._(
        key: key,
        builder: (context) => Column(
          children: [title, ...children],
        ),
      );

  @override
  Widget build(BuildContext context) => builder(context);
}

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.appBar,
    required this.backgroundColor,
    required this.body,
    required this.drawer,
    required this.fab,
    required this.fabLocation,
  });

  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? body;
  final Widget? drawer;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;

  factory CustomScaffold.appbarFab({
    Color? backgroundColor,
    FloatingActionButtonLocation? fabLocation,
    required PreferredSizeWidget appBar,
    required Widget fab,
    required Widget body,
  }) =>
      CustomScaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        body: body,
        drawer: null,
        fab: fab,
        fabLocation: fabLocation,
      );

  factory CustomScaffold.appbarDrawerFab({
    Color? backgroundColor,
    FloatingActionButtonLocation? fabLocation,
    double? drawerHeight,
    required PreferredSizeWidget appBar,
    required CustomDrawer drawer,
    required Widget fab,
    required Widget body,
  }) =>
      CustomScaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        body: body,
        drawer: SizedBox(
          height: drawerHeight,
          child: drawer,
        ),
        fab: fab,
        fabLocation: fabLocation,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: body,
      drawer: drawer,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
    );
  }
}



/// custom drawer:
/// [CustomDrawer.style1]
/// [CustomDrawer.style2]
/// [CustomDrawer.style3]
///
/// tip: use [SizedBox] enclosing [CustomDrawer] to constraint the drawer's height
///
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    this.shape,
    required this.child,
  });

  final ShapeBorder? shape;
  final Widget child;

  factory CustomDrawer.style1({
    double cardElevation = 10,
    ShapeBorder? shape,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    BoxShape headerShape = BoxShape.rectangle,
    String headerSize = "400",
    required String title,
    required List<CustomListTile> tiles,
  }) =>
      CustomDrawer(
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 50,
              child: Center(child: Text(title)),
            ),
            DrawerHeader(
              decoration: BoxDecoration(
                shape: headerShape,
                image: DecorationImage(
                  image:
                  Image.network('https://picsum.photos/$headerSize').image,
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(),
            ),
            Padding(
              padding: padding,
              child: Column(
                children: tiles
                    .map((tile) => CustomCard.listTile(
                  elevation: cardElevation,
                  listTile: tile,
                ))
                    .toList(),
              ),
            ),
          ],
        ),
      );

  factory CustomDrawer.style2() => throw UnimplementedError();

  factory CustomDrawer.style3() => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: shape,
      child: child,
    );
  }
}


class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    this.iconSize = 30,
  });
  final double iconSize;
  final List<BottomNavigationBarItem> items;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      iconSize: widget.iconSize,
      backgroundColor: Colors.green,
      selectedFontSize: Theme.of(context).textTheme.titleMedium!.fontSize!,
      currentIndex: _bottomNavIndex,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      items: widget.items,
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.elevation,
    required this.child,
  });

  final double? elevation;
  final Widget child;

  factory CustomCard.iconText({
    double elevation = 5,
    GestureTapCallback onTap = kVoidCallback,
    required IconData icon,
    required String text,
  }) =>
      CustomCard(
        elevation: elevation,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(icon), Text(text)],
            ),
          ),
        ),
      );

  factory CustomCard.listTile({
    double? elevation,
    required CustomListTile listTile,
  }) =>
      CustomCard(
        elevation: elevation,
        child: listTile,
      );

  @override
  Widget build(BuildContext context) => Card(
        elevation: elevation,
        child: child,
      );
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.decoration,
    required this.style,
  });

  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final TextStyle? style;

  factory CustomTextFormField.style1({
    TextStyle textStyle = KTextStyle.roboto,
    TextFormFieldValidator validator = FTextFormFieldValidator.validateNullOrEmpty,
    required TextEditingController controller,
    required String vfMessage,
    required InputDecoration decoration,
  }) =>
      CustomTextFormField(
        controller: controller,
        validator: validator(vfMessage),
        decoration: decoration,
        style: textStyle,
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: decoration,
      style: style,
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final GestureTapCallback? onTap;

  factory CustomListTile.style1({
    required String title,
    required String subtitle,
    required GestureTapCallback onTap,
  }) =>
      CustomListTile(
        title: Center(child: Text(title)),
        subtitle: Text(subtitle),
        onTap: onTap,
      );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}