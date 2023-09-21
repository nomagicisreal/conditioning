part of source;

///
/// this file contains:
/// [StateExtension]
///
/// [ColorExtension]
/// [GlobalKeyExtension]
/// [FocusManagerExtension]
/// [FocusNodeExtension]
///
/// [ImageExtension]
/// [OverlayEntryExtension]
///
/// [ContextExtension]
///
/// [ListIconVoidCallbackExtension]
///

extension StateExtension on State {
  // ignore: invalid_use_of_protected_member
  VoidCallback setStateOf(VoidCallback fn) => () => setState(fn);

  ///
  /// set state when [AnimationStatus] of ...
  ///

  AnimationStatusListener setStateOfAnimationStatusForward(
    VoidCallback listener,
  ) =>
      FAnimationStatusListener.forwardListen(setStateOf(listener));

  AnimationStatusListener setStateOfAnimationStatusReverse(
    VoidCallback listener,
  ) =>
      FAnimationStatusListener.reverseListen(setStateOf(listener));

  AnimationStatusListener setStateOfAnimationStatusCompleted(
    VoidCallback listener,
  ) =>
      FAnimationStatusListener.completedListen(setStateOf(listener));

  AnimationStatusListener setStateOfAnimationStatusDismissed(
    VoidCallback listener,
  ) =>
      FAnimationStatusListener.dismissedListen(setStateOf(listener));
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

  Rect get renderRect => renderBox.fromLocalToGlobalRect;

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

extension RenderBoxExtension on RenderBox {
  Rect get fromLocalToGlobalRect =>
      RectExtension.fromOffsetSize(localToGlobal(Offset.zero), size);
}

extension FocusManagerExtension on FocusManager {
  void unFocus() => primaryFocus?.unfocus();
}

extension FocusNodeExtension on FocusNode {
  VoidCallback addFocusChangedListener(VoidCallback listener) =>
      hasFocus ? listener : kVoidCallback;
}

extension ImageExtension on Image {
  static assetsInDimension(String path, double dimension) => Image.asset(
        path,
        height: dimension,
        width: dimension,
      );
}

extension OverlayEntryExtension on OverlayEntry {
  void insert(BuildContext context) => context.insertOverlay(this);

  static OverlayEntry positionedRect({
    bool opaque = false,
    bool maintainState = false,
    required Rect rect,
    required WidgetBuilder builder,
  }) =>
      OverlayEntry(
        opaque: opaque,
        maintainState: maintainState,
        builder: (context) => Positioned.fromRect(
          rect: rect,
          child: builder(context),
        ),
      );
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

  ///
  /// theme
  ///

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  AppBarTheme get appBarTheme => theme.appBarTheme;

  ///
  /// others
  ///

  Size get mediaSize => MediaQuery.sizeOf(this);

  EdgeInsets get mediaViewInsets => MediaQuery.viewInsetsOf(this);

  double get mediaViewInsetsBottom => mediaViewInsets.bottom;

  bool get isKeyboardShowing => mediaViewInsetsBottom > 0;

  RenderBox get renderBox => findRenderObject() as RenderBox;

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  NavigatorState get navigator => Navigator.of(this);

  OverlayState get overlay => Overlay.of(this);

  ///
  /// custom components
  ///

  PreferenceState get preference => Preference.of(this);

  ///
  /// methods
  ///

  void insertOverlay(
    OverlayEntry entry, {
    OverlayEntry? below,
    OverlayEntry? above,
  }) =>
      overlay.insert(entry, below: below, above: above);
  
  void closeKeyboardIfShowing() {
    if (isKeyboardShowing) {
      FocusScopeNode currentFocus = FocusScope.of(this);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }

  ///
  /// show snackbar
  ///

  void showSnackbar(SnackBar snackBar) =>
      scaffoldMessenger.showSnackBar(snackBar);

  void showSnackbarWithMessage(
    String? message, {
    bool isCenter = true,
    bool showWhetherMessageIsNull = false,
    Duration duration = KDuration.second1,
    Color? backgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
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

  ///
  /// show dialog
  ///

  Future<T?> showDialogGenericStyle1<T>({
    required String title,
    required String content,
    required Caller<Map<String, T>> optionsBuilder,
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
                  child: KIconMaterial.check,
                ),
                TextButton(
                  onPressed: () {
                    result = false;
                    context.navigator.pop();
                  },
                  child: KIconMaterial.cross,
                ),
              ],
            ));
    return result;
  }
}

extension ListIconVoidCallbackExtension on List<(Icon, VoidCallback)> {
  double maxSizeOf(BuildContext context) =>
      map((e) => e.$1.size ?? context.theme.iconTheme.size ?? 24.0)
          .reduce((a, b) => math.max(a, b));
}
