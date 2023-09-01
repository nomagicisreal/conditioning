part of source;

///
/// this file contains:
///
/// transformer:
/// [DoubleToTweenDouble]
/// [SizeToOffset], [SizeToRadius], [SizeToPath], [CanvasSizeToPaint]
///
/// call:
/// [MapStringCall]
///
/// initializer:
/// [AnimationControllerInitializer]
///
/// listener (void call):
/// [CanvasListener]
/// [AnimationControllerListener], [AnimatedListItemUpdateListener], [AnimatedListItemInsertListener]
///
/// builder (the type that return a widget):
/// [ValueBuilder], [CustomWidgetBuilder], [LeaderBuilder], [FollowerBuilder]
///
/// plan (the type that return a builder):
/// [AnimatedItemPlan], [PathPlan]
///
/// generator (with index):
/// [VectorToVectorGenerator]
///
/// validator:
/// [TextFormFieldValidator]
///
/// on:
/// [OnLerp], [OnMatrix4Animate], [OnMatrix4D3ValueAnimate],
///
/// mapper:
/// [DoubleMapper], [DoubleDoubleMapper], [CoordinateMapper], [MationMapper], [AnimationsMapper], [MyTweenMapper]
/// [CubicPointsMapper]
///
/// creator:
/// [AnimatedListItemIndexCreator]
///
///

final kTweenDoubleZero = TweenDouble.constant(0);

///
/// transformer
///

typedef DoubleToTweenDouble = TweenDouble Function(double double);
typedef SizeToDouble = double Function(Size size);
typedef SizeToOffset = Offset Function(Size size);
typedef SizeToOffsetList = List<Offset> Function(Size size);
typedef SizeToRadius = Radius Function(Size size);
typedef SizeToPath = Path Function(Size size);
typedef CanvasSizeToPaint = Paint Function(Canvas canvas, Size size);

///
/// call
///

typedef MapStringCall<T> = Map<String, T> Function();

///
/// initializer
///

typedef AnimationControllerInitializer = AnimationController Function(
  TickerProvider tickerProvider,
  Duration forward,
  Duration reverse,
);

///
/// listener
///

typedef TimerListener = void Function(Timer timer);

typedef CanvasListener = void Function(Canvas canvas, Paint paint, Path path);

typedef AnimationControllerListener = void Function(
  AnimationController controller,
);

typedef AnimatedListItemUpdateListener = void Function({
  required AnimatedItemBuilder? builder,
  required AnimatedListState listState,
  required List<AnimatedListItem> items,
  required int index,
});
typedef AnimatedListItemInsertListener = void Function({
  required AnimatedItemBuilder builder,
  required AnimatedListState listState,
  required List<AnimatedListItem> items,
  required AnimatedListItem item,
  required int index,
});

///
/// builder
///

typedef CustomWidgetBuilder = Widget Function(Widget child);
typedef LeaderBuilder = Leader Function(LayerLink link);
typedef FollowerBuilder = Follower Function(LayerLink link);
typedef AniBuilder = MyAnimation Function(BuildContext context);

///
/// plan
///

typedef AnimatedItemPlan = AnimatedItemBuilder Function({
  required List<AnimatedListItem> items,
  required AnimatedListState listState,
  required AnimatedListModification modification,
});

typedef PathPlan<T> = SizeToPath Function(T value);

///
/// generator
///

typedef VectorToVectorGenerator = Vector Function(Vector vector, int index);

///
/// validator
///

typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);

///
/// on
///

///
/// [T] types:
/// - [double] for 2d scaling, rotation
/// - [Offset] for 2d translation
/// - [Coordinate] for 3D scaling, translation, rotation
///
typedef OnMatrix4Animate<T> = Matrix4 Function(Matrix4 matrix4, T value);

typedef OnMatrix4D3ValueAnimate = double Function(
  Dimension dimension,
  double value,
);

typedef OnLerp<T> = T Function(double t);

typedef OnOffsetListWithSize = List<Offset> Function(
  List<Offset> points,
  Size size,
);

///
/// mapper
///

typedef DoubleMapperNullable = double Function(double? value);
typedef DoubleMapper = double Function(double value);
typedef DoubleDoubleMapper = double Function(double v1, double v2);
typedef OffsetMapper = double Function(Offset offset);

typedef CoordinateMapper = Coordinate Function(Coordinate coordinate);

typedef CurveMapper = Curve Function(Curve curve);
typedef MationMapper<T> = Mation<T> Function(Mation<T> setup);

typedef AnimationsMapper<T> = Iterable<Animation> Function(
  Iterable<Animation> animations,
);

typedef MyTweenMapper<T> = MyTween<T> Function(MyTween<T> tween);
typedef CubicPointsMapper = Map<Offset, List<Offset>> Function(
  Map<Offset, List<Offset>> points,
);

///
/// creator
///

typedef AnimatedListItemIndexCreator = int Function({
  required AnimatedItemBuilder? builder,
  required List<AnimatedListItem> items,
  required AnimatedListItem item,
});
