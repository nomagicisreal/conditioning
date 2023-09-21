part of source;

///
/// this file contains:
/// generics:
/// [Processor]                   (with 1 argument, return void)
/// [Conductor]                   (with 2 argument, return void)
/// [Caller]                      (without argument, return value)
/// [Mapper], [MapperWith]        (return value that has the same type with argument)
/// [Reducer], [ReducerWith]      (return value that comes from two argument with same type)
/// [Generator]                   (return value from index)
/// [Translator]                  (return argument in different type)
/// [Decider]                     (with argument, return [Processor])
///
/// [Predicator], [PredicatorComparison]
/// [TernaryPredicator], [TernaryPredicatorComparison]
///
/// a little generics:
/// [CanvasProcessor], [AnimatingProcessor]
/// [AnimatedListItemUpdateProcessor], [AnimatedListItemInsertProcessor]
///
/// [AnimationControllerInitializer], [FabExpandableSetupInitializer]
///
/// [AnimationBuilder], [AnimationsBuilder]
/// [SizedBoxBuilder], [MyAnimationBuilder]
/// [LeaderBuilder], [FollowerBuilder]
///
/// [AnimatedListItemPlan]
///
/// [OnLerp], [OnLerpPath], [OnMatrix4Animate]
///
/// [PaintFromCanvasSize]
/// [PathFromRectSize], [PathFromRRectSize]
///
/// [DoubleToDoublePair]
/// [TextFormFieldValidator]
/// [AnimatedListItemIndexCreator]
///
///

// one generic type
typedef Processor<T> = void Function(T value);
typedef Conductor<T> = void Function(T a, T b);
typedef Caller<T> = T Function();
typedef Mapper<T> = T Function(T value);
typedef Reducer<T> = T Function(T v1, T v2);
typedef Generator<T> = T Function(int index);

// two generic type
typedef MapperWith<T, S> = T Function(T value, S helper);
typedef ReducerWith<T, S> = T Function(T v1, T v2, S helper);
typedef Translator<T, S> = S Function(T value);
typedef Decider<T, S> = Processor<T> Function(S toggle);

///
/// predicator
///
typedef Predicator<T> = bool Function(T value);
typedef PredicatorComparison<T> = bool Function(T a, T? b);
typedef TernaryPredicator<T> = bool? Function(T value);
typedef TernaryPredicatorComparison<T> = bool? Function(T a, T? b);

///
/// processor
///
typedef CanvasProcessor = void Function(Canvas canvas, Paint paint, Path path);
typedef AnimatingProcessor = void Function(
  AnimationController controller,
  bool isForward,
);

typedef AnimatedListItemUpdateProcessor = void Function({
  required AnimatedItemBuilder? builder,
  required AnimatedListState listState,
  required List<AnimatedListItem> items,
  required int index,
});
typedef AnimatedListItemInsertProcessor = void Function({
  required AnimatedItemBuilder builder,
  required AnimatedListState listState,
  required List<AnimatedListItem> items,
  required AnimatedListItem item,
  required int index,
});

///
/// initializer
///
typedef AnimationControllerInitializer = AnimationController Function(
  TickerProvider tickerProvider,
  Duration forward,
  Duration reverse,
);

typedef FabExpandableSetupInitializer = FabExpandableSetup Function({
  required BuildContext context,
  required Rect openIconRect,
  required Alignment openIconAlignment,
  required List<(Icon, VoidCallback)> icons,
});

///
/// builder
///
typedef AnimationBuilder<T> = Widget Function(
  Animation<T> animation,
  Widget child,
);
typedef AnimationsBuilder<T> = Widget Function(
  Iterable<Animation<T>> animations,
  Widget child,
);
typedef MationBuilder<T> = Widget Function(
  BuildContext context,
  MationBase<T> mation,
);
typedef LeaderBuilder = Leader Function(LayerLink link);
typedef FollowerBuilder = Follower Function(LayerLink link);

///
/// plan (the type that return a builder)
///
typedef AnimatedListItemPlan = AnimatedItemBuilder Function({
  required List<AnimatedListItem> items,
  required AnimatedListState listState,
  required AnimatedListModification modification,
});

///
/// on (the type that may process in every tick)
///
/// [OnMatrix4Animate]<[T]>:
/// - [double] for 2d scaling, rotation
/// - [Offset] for 2d translation
/// - [Coordinate] for 3D scaling, translation, rotation
///
///
typedef OnLerp<T> = T Function(double t);
typedef OnLerpPath<T> = Translator<Size, Path> Function(T value);
typedef OnMatrix4Animate = Matrix4 Function(Matrix4 matrix4, Coordinate value);

///
/// from
///
typedef PaintFromCanvasSize = Paint Function(Canvas canvas, Size size);
typedef PathFromRectSize = Path Function(Rect rect, Size size);
typedef PathFromRRectSize = Path Function(RRect rect, Size size);

///
/// others
///
typedef DoubleToDoublePair = (double, double) Function(double value);

typedef TextFormFieldValidator = FormFieldValidator<String> Function(
  String failedMessage,
);

typedef AnimatedListItemIndexCreator = int Function({
  required AnimatedItemBuilder? builder,
  required List<AnimatedListItem> items,
  required AnimatedListItem item,
});
