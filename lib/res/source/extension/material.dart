part of source;

///
/// this file contains:
/// [VoidCallbackExtension]
/// [ColorExtension]
/// [GlobalKeyExtension]
/// [FocusManagerExtension]
/// [StreamExtension]
/// [StreamIterableExtension]
/// [AnimationExtension]
/// [AlignmentExtension]
/// [PositionedExtension]
/// [FocusNodeExtension]
///
/// [Matrix4Extension]
/// [PathExtension]
///
/// [TweenExtension], [TweenDoubleExtension], [TweenOffsetExtension], [TweenSizeExtension], [TweenDecorationExtension]
///
/// [ContextExtension]
///

extension VoidCallbackExtension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

extension ColorExtension on Color {
  Color plusARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
        this.alpha + alpha,
        this.red + red,
        this.green + green,
        this.blue + blue,
      );

  Color minusARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha - alpha,
    this.red - red,
    this.green - green,
    this.blue - blue,
  );

  Color multiplyARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha * alpha,
    this.red * red,
    this.green * green,
    this.blue * blue,
  );

  Color divideARGB(int alpha, int red, int green, int blue) => Color.fromARGB(
    this.alpha ~/ alpha,
    this.red ~/ red,
    this.green ~/ green,
    this.blue ~/ blue,
  );


}

extension GlobalKeyExtension on GlobalKey {
  RenderBox get renderBox => currentContext?.findRenderObject() as RenderBox;

  Rect get rect {
    final renderBox = this.renderBox;
    final translation = renderBox.getTransformTo(null).getTranslation();
    final size = renderBox.semanticBounds.size;
    return Rect.fromLTWH(translation.x, translation.y, size.width, size.height);
  }

  Offset adjustScaffoldOf(Offset offset) {
    final translation = currentContext
        ?.findRenderObject()
        ?.getTransformTo(null)
        .getTranslation();

    return translation == null
        ? offset
        : Offset(
            offset.dx - translation.x,
            offset.dy - translation.y,
          );
  }
}

extension FocusManagerExtension on FocusManager {
  void unFocus() => primaryFocus?.unfocus();
}

extension AnimationExtension on Animation {
  void addListenerUntilStatusCompleted(VoidCallback listener) {
    void toRemoveListener(AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        removeListener(listener);
        removeStatusListener(toRemoveListener);
      }
    }

    addListener(listener);
    addStatusListener(toRemoveListener);
  }
}

extension AlignmentExtension on Alignment {
  double get toFabExpandableDirection {
    if (this == Alignment.bottomRight) {
      return KRadian.angle_180;
    } else if (this == Alignment.bottomLeft) {
      return -KRadian.angle_90;
    } else if (this == Alignment.bottomCenter) {
      return -KRadian.angle_60 * 2;
    } else {
      throw UnimplementedError();
    }
  }

  CustomWidgetBuilder get deviateBuilder {
    if (this == Alignment.center) {
      return (child) => child;

      //
    } else {
      /// row builder
      final CustomWidgetBuilder row;
      Row getRow(List<Widget> children) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          );

      if (x == 0) {
        row = (child) => getRow([child]);
      } else if (x == 1) {
        row = (child) => getRow([child, VContainer.expanded]);
      } else if (x == -1) {
        row = (child) => getRow([VContainer.expanded, child]);
      } else {
        throw UnimplementedError();
      }

      /// column builder
      final CustomWidgetBuilder column;
      Column getColumn(List<Widget> children) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: children,
          );

      if (y == 0) {
        column = (child) => getColumn([child]);
      } else if (y == 1) {
        column = (child) => getColumn([row(child), VContainer.expanded]);
      } else if (y == -1) {
        column = (child) => getColumn([VContainer.expanded, row(child)]);
      } else {
        throw UnimplementedError();
      }

      return (child) => column(child);
    }
  }
}

extension PositionedExtension on Positioned {
  Rect? get rect =>
      (left == null || top == null || width == null || height == null)
          ? null
          : Rect.fromLTWH(left!, top!, width!, height!);
}

extension FocusNodeExtension on FocusNode {
  VoidCallback addFocusChangedListener(VoidCallback listener) =>
      hasFocus ? listener : kVoidCallback;
}

extension Matrix4Extension on Matrix4 {
  ///
  /// see [Coordinate.fromDirection] for detail
  ///
  static Coordinate transfer(Coordinate origin) => Coordinate(
        origin.dx,
        -origin.dz,
        -origin.dy,
      );

  Matrix4 rotated(Coordinate coordinate) => this
    ..rotateX(coordinate.dx)
    ..rotateY(coordinate.dy)
    ..rotateZ(coordinate.dz);

  Matrix4 translated(Coordinate coordinate) =>
      this..translate(coordinate.dx, coordinate.dy, coordinate.dz);

  void setPerspective(double perspective) => setEntry(3, 2, perspective);
}

extension PathExtension on Path {
  void moveToPoint(Offset point) => moveTo(point.dx, point.dy);

  void lineToPoint(Offset point) => lineTo(point.dx, point.dy);

  void moveOrLineToPoint(bool shouldMove, Offset point) =>
      shouldMove ? moveToPoint(point) : lineToPoint(point);

  void connect(Offset a, Offset b) => this
    ..moveToPoint(a)
    ..lineToPoint(b);

  void quadraticBezierToPoint(Offset controlPoint, Offset endPoint) =>
      quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      );

  ///
  /// [cubicToPoint] forms the line that from Pa to Pd that lerp by t (from 0 to 1) on each segment,
  /// see https://www.youtube.com/watch?v=aVwxzDHniEw for explanation
  ///
  /// Pa: the current [Offset] of [Path]
  /// Pb: [controlPoint1]
  /// Pc: [controlPoint2]
  /// Pd: [endPoint]
  ///
  /// P(t) =
  ///   Pa * ( -t^3 + 3t^2 - 3t + 1 )
  ///   Pb * ( 3t^3 - 6t^2 + 3t )
  ///   Pc * (-3t^3 + 3t^2 )
  ///   Pd * ( t^3 )
  ///
  /// P(0.5) = Pa * 0.125 + Pb * 0.375 + Pc * 0.375 + Pd * 0.125
  ///        = (Pa+Pd) * 1/8 + (Pb+Pc) * 3/8
  ///
  void cubicToPoint(
    Offset controlPoint1,
    Offset controlPoint2,
    Offset endPoint,
  ) =>
      cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint.dx,
        endPoint.dy,
      );

  /// the [points] will be treated as [controlPointA, controlPointB, endPoint]
  void cubicToPointsList(List<Offset> points) =>
      cubicToPoint(points[0], points[1], points[2]);
}

///
/// tween
///

extension TweenExtension<T> on MyTween<T> {

}

extension TweenDoubleExtension on Tween<double> {
  Tween<double> followAdd(double addition) => Tween<double>(
        begin: end,
        end: end! + addition,
      );
}

extension TweenOffsetExtension on Tween<Offset> {
  Tween<Offset> get pushZero => Tween(begin: Offset.zero, end: begin);

  Tween<Offset> followAdd(Offset addition) => Tween<Offset>(
        begin: end,
        end: end! + addition,
      );
}

extension TweenSizeExtension on Tween<Size> {
  Tween<Size> followAdd(Offset addition) => Tween<Size>(
        begin: end,
        end: end! + addition,
      );
}

extension TweenDecorationExtension on DecorationTween {
  Tween<Decoration> followDecoration(Decoration next) => DecorationTween(
        begin: end,
        end: next,
      ); // use Tween<Decoration> cannot lerp properly
}

///
/// [theme], [textTheme], [colorScheme], [appBarTheme]
/// [mediaSize], [mediaViewInsets]
/// [isKeyboardShowing]
///
/// [renderBox]
/// [scaffold], [scaffoldMessenger]
/// [navigator]
///
/// [overlay], [preference]
///
/// [closeKeyboardIfShowing]
/// [showSnackbar], [showSnackbarWithMessage]
/// [showDialogGenericStyle1], [showDialogGenericStyle2], [showDialogListAndGetItem], [showDialogDecideTureOfFalse]
///
extension ContextExtension on BuildContext {
  // AppLocalizations get loc => AppLocalizations.of(this)!;

  /// theme

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  AppBarTheme get appBarTheme => theme.appBarTheme;

  /// media

  Size get mediaSize => MediaQuery.sizeOf(this);

  EdgeInsets get mediaViewInsets => MediaQuery.viewInsetsOf(this);

  bool get isKeyboardShowing => mediaViewInsets.bottom > 0;

  /// others

  RenderBox get renderBox => findRenderObject() as RenderBox;

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  NavigatorState get navigator => Navigator.of(this);

  /// custom components

  CustomOverlayState get overlay => CustomOverlay.of(this);

  PreferenceState get preference => Preference.of(this);

  ///
  /// methods
  ///
  void closeKeyboardIfShowing() {
    if (isKeyboardShowing) {
      FocusScopeNode currentFocus = FocusScope.of(this);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  /// snackbar
  void showSnackbar(SnackBar snackBar) =>
      scaffoldMessenger.showSnackBar(snackBar);

  void showSnackbarWithMessage({
    bool isCenter = true,
    bool showWhetherMessageIsNull = false,
    Duration duration = KDuration.second1,
    Color? backgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    required String? message,
  }) {
    if (showWhetherMessageIsNull || message != null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor ?? theme.cardColor,
          behavior: behavior,
          duration: duration,
          content: isCenter
              ? Center(child: Text(message ?? ''))
              : Text(message ?? ''),
        ),
      );
    }
  }

  /// dialog
  Future<T?> showDialogGenericStyle1<T>({
    required String title,
    required String content,
    required MapStringCall<T> optionsBuilder,
  }) {
    final options = optionsBuilder();
    return showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: options.keys
            .map((optionTitle) => TextButton(
                  onPressed: () => context.navigator.pop(
                    options[optionTitle],
                  ),
                  child: Text(optionTitle),
                ))
            .toList(),
      ),
    );
  }

  Future<T?> showDialogGenericStyle2<T>({
    required String title,
    required String? content,
    required Map<String, T Function()> actionTitleAndActions,
  }) async {
    final actions = <Widget>[];
    T? returnValue;
    actionTitleAndActions.forEach((label, action) {
      actions.add(TextButton(
        onPressed: () {
          navigator.pop();
          returnValue = action();
        },
        child: Text(label),
      ));
    });
    await showDialog(
        context: this,
        builder: (context) => content == null
            ? SimpleDialog(title: Text(title), children: actions)
            : AlertDialog(
                title: Text(title),
                content: Text(content),
                actions: actions,
              ));
    return returnValue;
  }

  Future<T?> showDialogListAndGetItem<T>({
    required String title,
    required List<T> itemList,
  }) async {
    late final T? selectedItem;
    await showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          height: 200,
          width: 100,
          child: ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              final item = itemList[index];
              return Center(
                child: TextButton(
                  onPressed: () {
                    selectedItem = item;
                    context.navigator.pop();
                  },
                  child: Text(item.toString()),
                ),
              );
            },
          ),
        ),
      ),
    );
    return selectedItem;
  }

  Future<bool?> showDialogDecideTureOfFalse() async {
    bool? result;
    await showDialog(
        context: this,
        builder: (context) => SimpleDialog(
              children: [
                TextButton(
                  onPressed: () {
                    result = true;
                    context.navigator.pop();
                  },
                  child: KIcon.check,
                ),
                TextButton(
                  onPressed: () {
                    result = false;
                    context.navigator.pop();
                  },
                  child: KIcon.cross,
                ),
              ],
            ));
    return result;
  }
}
