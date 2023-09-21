// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of source;

///
/// this file contains:
/// [VoidCallbackExtension]
/// [FOnLerp], [FOnMatrix4Animate]
///
/// [FWidgetBuilder]
/// [FImageLoadingBuilder], [FImageErrorWidgetBuilder]
/// [FListAnimatedItemBuilder], [FListAnimatedItemListener]
/// [FTextFormFieldValidator]
/// [FFabExpandableSetupOrbit], [FFabExpandableSetupLine]
///
/// [FPathFromSize], [FPathFromSizeStyle], [FPathFromRectSize], [FPathFromRRectSize]
///
/// [FCanvasProcessor]
/// [FCanvasSizeToPaint], [VPaintFill], [VPaintFillBlur], [VPaintStroke], [KMaskFilter]
///
/// [FMyClipper], [FMyClipper], [FMyClipperMationTransform], [FMyClipperMationTransformRowTransform]...
/// [FCustomPaint], [FMyPainter], [FMationPainter]
///
/// [FRRegularPolygon]
///

extension VoidCallbackExtension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

extension FOnLerp on OnLerp {
  static OnLerp<T> constant<T>(T value) => (_) => value;

  static OnLerp<T> of<T>(T a, T b) => switch (a) {
        Size() => _size(a, b as Size),
        Rect() => _rect(a, b as Rect),
        Color() => _color(a, b as Color),
        Vector() => _vector(a, b as Vector),
        Decoration() => _decoration(a, b as Decoration),
        ShapeBorder() => _shapeBorder(a, b as ShapeBorder),
        RelativeRect() => _relativeRect(a, b as RelativeRect),
        AlignmentGeometry() => _alignmentGeometry(
            a,
            b as AlignmentGeometry,
          ),
        _ => Tween<T>(begin: a, end: b).transform,
      } as OnLerp<T>;

  static OnLerp<Size> _size(Size a, Size b) => (t) => Size.lerp(a, b, t)!;

  static OnLerp<Rect> _rect(Rect a, Rect b) => (t) => Rect.lerp(a, b, t)!;

  static OnLerp<Color> _color(Color a, Color b) => (t) => Color.lerp(a, b, t)!;

  static OnLerp<Vector> _vector(Vector a, Vector b) =>
      (t) => Vector.lerp(a, b, t);

  static OnLerp<RelativeRect> _relativeRect(RelativeRect a, RelativeRect b) =>
      (t) => RelativeRect.lerp(a, b, t)!;

  static OnLerp<AlignmentGeometry> _alignmentGeometry(
    AlignmentGeometry a,
    AlignmentGeometry b,
  ) =>
      (t) => AlignmentGeometry.lerp(a, b, t)!;

  ///
  ///
  /// TODO: lerp between difference [ShapeBorder], migrate with [RRegularPolygon]
  /// before then, it's better to create borders in the same type.
  ///
  /// See Also
  ///   * [BetweenPath.fromShapeBorder] ...
  ///   * [FPathFromSize.fromShapeBorder]
  ///   * [FOnLerpPath.shapeOuterLtr] ...
  ///   * [KBoxBorder] ...
  ///
  ///
  static OnLerp<ShapeBorder> _shapeBorder(ShapeBorder a, ShapeBorder b) =>
      switch (a) {
        BoxBorder() => switch (b) {
            BoxBorder() => (t) => BoxBorder.lerp(a, b, t)!,
            _ => throw UnimplementedError(),
          },
        InputBorder() => switch (b) {
            InputBorder() => (t) => ShapeBorder.lerp(a, b, t)!,
            _ => throw UnimplementedError(),
          },
        OutlinedBorder() => switch (b) {
            OutlinedBorder() => (t) => OutlinedBorder.lerp(a, b, t)!,
            _ => throw UnimplementedError(),
          },
        _ => throw UnimplementedError(),
      };

  static OnLerp<Decoration> _decoration(Decoration a, Decoration b) =>
      switch (a) {
        BoxDecoration() => b is BoxDecoration && a.shape == b.shape
            ? (t) => BoxDecoration.lerp(a, b, t)!
            : throw UnimplementedError('BoxShape should not be interpolated'),
        ShapeDecoration() => switch (b) {
            ShapeDecoration() => a.shape == b.shape
                ? (t) => ShapeDecoration.lerp(a, b, t)!
                : switch (a.shape) {
                    CircleBorder() || RoundedRectangleBorder() => switch (
                          b.shape) {
                        CircleBorder() || RoundedRectangleBorder() => (t) =>
                            Decoration.lerp(a, b, t)!,
                        _ => throw UnimplementedError(
                            "'$a shouldn't be interpolated to $b'",
                          ),
                      },
                    _ => throw UnimplementedError(
                        "'$a shouldn't be interpolated to $b'",
                      ),
                  },
            _ => throw UnimplementedError(),
          },
        _ => throw UnimplementedError(),
      };
}

extension FOnLerpPath on OnLerpPath {
  static const shapeOuterLtr = _shapeOuterLtr;
  static const shapeOuterRtl = _shapeOuterRtl;
  static const shapeInnerLtr = _shapeInnerLtr;
  static const shapeInnerRtl = _shapeInnerRtl;

  static Translator<Size, Path> _shapeOuterLtr(ShapeBorder shape) =>
      FPathFromSize.fromShapeBorder(
        shape,
        textDirection: TextDirection.ltr,
        isOuterPath: true,
      );

  static Translator<Size, Path> _shapeOuterRtl(ShapeBorder shape) =>
      FPathFromSize.fromShapeBorder(
        shape,
        textDirection: TextDirection.rtl,
        isOuterPath: true,
      );

  static Translator<Size, Path> _shapeInnerLtr(ShapeBorder shape) =>
      FPathFromSize.fromShapeBorder(
        shape,
        textDirection: TextDirection.ltr,
        isOuterPath: false,
      );

  static Translator<Size, Path> _shapeInnerRtl(ShapeBorder shape) =>
      FPathFromSize.fromShapeBorder(
        shape,
        textDirection: TextDirection.rtl,
        isOuterPath: false,
      );
}

///
///
///
/// onMatrix4Animate
///
///
///

extension FOnMatrix4Animate on OnMatrix4Animate {
  static const OnMatrix4Animate scaling = _scaling;
  static const OnMatrix4Animate translating = _translating;
  static const OnMatrix4Animate rotating = _rotating;

  static Matrix4 _scaling(Matrix4 matrix4, Coordinate value) =>
      matrix4.scaledCoordinate(value);

  static Matrix4 _translating(Matrix4 matrix4, Coordinate value) =>
      Matrix4Extension.identityPerspectiveOf(matrix4)
        ..translateCoordinate(value);

  static Matrix4 _rotating(Matrix4 matrix4, Coordinate value) => matrix4
    ..setRotation((Matrix4.identity()..rotateCoordinate(value)).getRotation());

  ///
  /// with mapper
  ///
  static OnMatrix4Animate scaleMapping(Mapper<Coordinate> mapper) =>
      (matrix4, value) => matrix4.scaledCoordinate(mapper(value));

  static OnMatrix4Animate translateMapping(Mapper<Coordinate> mapper) =>
      (matrix4, value) => Matrix4Extension.identityPerspectiveOf(matrix4)
        ..translateCoordinate(mapper(value));

  static OnMatrix4Animate rotateMapping(Mapper<Coordinate> mapper) =>
      (matrix4, value) => matrix4
        ..setRotation((Matrix4.identity()..rotateCoordinate(mapper(value)))
            .getRotation());

  ///
  /// with fixed value
  ///
  static OnMatrix4Animate fixedScaling(Coordinate fixed) =>
      (matrix4, value) => matrix4.scaledCoordinate(value + fixed);

  static OnMatrix4Animate fixedTranslating(Coordinate fixed) =>
      (matrix4, value) => Matrix4Extension.identityPerspectiveOf(matrix4)
        ..translateCoordinate(value + fixed);

  static OnMatrix4Animate fixedRotating(Coordinate fixed) =>
      (matrix4, value) => matrix4
        ..setRotation((Matrix4.identity()..rotateCoordinate(fixed + value))
            .getRotation());
}

///
/// widget builder
///

extension FWidgetBuilder on Widget {
  static WidgetBuilder of(Widget child) => (context) => child;

  static Widget progressing(BuildContext _) => KProgressIndicator.circular;

  static List<Widget> sandwich({
    bool isInRow = true,
    required int breadCount,
    required Generator<Widget> bread,
    required Generator<Widget> meat,
  }) {
    List<Widget> children(int index) => [
          bread(index),
          if (index < breadCount - 1) meat(index),
        ];

    return isInRow
        ? List<Row>.generate(
            breadCount,
            (index) => Row(children: children(index)),
          )
        : List<Column>.generate(
            breadCount,
            (index) => Column(children: children(index)),
          );
  }
}

extension FImageLoadingBuilder on ImageLoadingBuilder {
  static Widget style1(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
                value: loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );

  static Widget style2(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : SizedBox(
              width: 90,
              height: 90,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );

  static Widget style3(
    BuildContext ctx,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey,
                value: loadingProgress.expectedTotalBytes != null &&
                        loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );

  static Widget style4(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) =>
      loadingProgress == null
          ? child
          : SizedBox(
              width: 200,
              height: 200,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.brown,
                  value: loadingProgress.expectedTotalBytes != null &&
                          loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
}

extension FImageErrorWidgetBuilder on ImageErrorWidgetBuilder {
  static Widget accountStyle2(BuildContext c, Object o, StackTrace? s) =>
      KIconMaterial.accountCircleStyle2;

  static Widget errorStyle1(BuildContext c, Object o, StackTrace? s) =>
      const SizedBox(height: 200, width: 200, child: Icon(Icons.error));
}

extension FListAnimatedItemBuilder on AnimatedItemBuilder {
  static AnimatedItemBuilder plan1({
    required List<AnimatedListItem> items,
    required AnimatedListState listState,
    required AnimatedListModification modification,
  }) =>
      (context, index, animation) {
        final item = items[index];
        return Padding(
          padding: KEdgeInsets.all_2,
          child: SizeTransition(
            sizeFactor: animation,
            child: GestureDetector(
              onTap: () => modification.onTap(
                builder: null,
                listState: listState,
                items: items,
                index: index,
              ),
              child: SizedBox(
                height: 80.0,
                child: Card(
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      'Item $item',
                      style: context.theme.textTheme.headlineMedium!,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      };

  static AnimatedItemBuilder plan2({
    required List<AnimatedListItem> items,
    required AnimatedListState listState,
    required AnimatedListModification setting,
  }) {
    Widget builder(
      BuildContext context,
      int index,
      Animation<double> animation,
    ) {
      return SizeTransition(
        sizeFactor: animation,
        child: Padding(
          padding: KEdgeInsets.symV_4,
          child: Container(
            height: 48,
            decoration: FDecorationShape.stadiumGrey,
            clipBehavior: Clip.antiAlias,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: KEdgeInsets.onlyLeft_24,
                  child: SizedBox(
                    width: 168,
                    child: Text(items[index].toString()),
                  ),
                ),
                IconButton(
                  onPressed: () => setting.remove(
                    builder: builder,
                    listState: listState,
                    items: items,
                    index: index,
                  ),
                  color: KColor.constant_200,
                  icon: KIconMaterial.cancel_24,
                  splashRadius: 20.0,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return builder;
  }
}

extension FListAnimatedItemListener on AnimatedItemBuilder {
  /// index style
  static int index0({
    required AnimatedItemBuilder? builder,
    required List<AnimatedListItem> items,
    required AnimatedListItem item,
  }) =>
      items.indexOf(item);

  /// insert style
  static void insert0({
    required AnimatedItemBuilder builder,
    required AnimatedListState listState,
    required List<AnimatedListItem> items,
    required AnimatedListItem item,
    required int index,
  }) {
    items.insert(index, item);
    listState.insertItem(index);
  }

  /// remove style
  static void remove0({
    required AnimatedItemBuilder? builder,
    required AnimatedListState listState,
    required List<AnimatedListItem> items,
    required int index,
  }) {
    try {
      final item = items[index];

      listState.removeItem(index, (context, animation) {
        void listener(AnimationStatus status) {
          if (status == AnimationStatus.completed) {
            items.remove(item);
            animation.removeStatusListener(listener);
          }
        }

        animation.addStatusListener(listener);

        return builder == null
            ? Container()
            : builder(context, index, animation);
      });
    } catch (_) {
      throw UnimplementedError();
    }
  }

  /// onTap style
  static void onTap0({
    required AnimatedItemBuilder? builder,
    required AnimatedListState listState,
    required List<AnimatedListItem> items,
    required int index,
  }) =>
      throw UnimplementedError();
}

extension FTextFormFieldValidator on TextFormFieldValidator {
  static FormFieldValidator<String> validateNullOrEmpty(
    String validationFailedMessage,
  ) =>
      (value) =>
          value == null || value.isEmpty ? validationFailedMessage : null;
}

extension FFabExpandableSetupOrbit on FabExpandableSetupInitializer {
  static const clockwise_2 = _clockwise_2;
  static const counterClockwise_2 = _counterClockwise_2;

  static FabExpandableSetup _clockwise_2({
    required BuildContext context,
    required Rect openIconRect,
    required Alignment openIconAlignment,
    required List<(Icon, VoidCallback)> icons,
  }) =>
      FabExpandableSetup.orbitOnOpenIcon(
        context: context,
        openIconRect: openIconRect,
        direction: openIconAlignment.directionOfSideSpace(
          true,
          icons.length,
        ),
        icons: icons,
      );

  static FabExpandableSetup _counterClockwise_2({
    required BuildContext context,
    required Rect openIconRect,
    required Alignment openIconAlignment,
    required List<(Icon, VoidCallback)> icons,
  }) =>
      FabExpandableSetup.orbitOnOpenIcon(
        context: context,
        openIconRect: openIconRect,
        direction: openIconAlignment.directionOfSideSpace(false, icons.length),
        icons: icons,
      );
}

extension FFabExpandableSetupLine on FabExpandableSetupInitializer {
  static FabExpandableSetupInitializer line1d2Of(
    Direction2DIn8 direction,
  ) =>
      ({
        required BuildContext context,
        required Rect openIconRect,
        required Alignment openIconAlignment,
        required List<(Icon, VoidCallback)> icons,
      }) =>
          FabExpandableSetup.line(
            context: context,
            openIconRect: openIconRect,
            direction: direction,
            icons: icons,
          );
}

///
/// [addOval], [addRect], [addRRect] ...
///
///
/// [lineAll]
/// [bezierQuadratic]
/// [bezierCubic]
/// [polygon]
/// [polygonCubicCorner]
/// [trapezium]
/// ...
///
/// [_invertFromSize]
/// [fromShapeBorder]
/// [circleHalfOf]
/// [_circleHalf]
/// [penpointFlat]
/// ...
///
extension FPathFromSize on Translator<Size, Path> {
  static Translator<Size, Path> addOval(Rect rect) =>
      (_) => Path()..addOval(rect);

  static Translator<Size, Path> addRect(Rect rect) =>
      (_) => Path()..addRect(rect);

  static Translator<Size, Path> addRRect(RRect rRect) =>
      (_) => Path()..addRRect(rRect);

  ///
  /// line, bezier
  ///

  static Translator<Size, Path> lineAll({
    Offset from = Offset.zero,
    required Iterable<Offset> points,
    PathFillType pathFillType = PathFillType.nonZero,
  }) =>
      (_) => points.fold(
            Path()..moveToPoint(from),
            (path, point) => path..lineToPoint(point),
          )
            ..fillType = pathFillType
            ..close();

  static Translator<Size, Path> bezierQuadratic({
    bool invertFromSize = false,
    required Offset controlPoint,
    required Offset endPoint,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) =>
            Path()..quadraticBezierToPoint(controlPoint, endPoint),
      );

  static Translator<Size, Path> bezierCubic({
    bool invertFromSize = false,
    required Offset c1,
    required Offset c2,
    required Offset endPoint,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => Path()..cubicToPoint(c1, c2, endPoint),
      );

  static Translator<Size, Path> trapezium({
    bool invertFromSize = false,
    Translator<Size, double>? height,
    required DoubleToDoublePair topSide,
    required DoubleToDoublePair bottomSide,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (size) {
          final top = topSide(size.width);
          final bottom = bottomSide(size.width);
          final h = height?.call(size) ?? size.height;

          return Path()
            ..moveTo(top.$1, 0.0)
            ..lineTo(top.$2, 0.0)
            ..lineTo(bottom.$1, h)
            ..lineTo(bottom.$2, h)
            ..lineTo(top.$1, 0.0);
        },
      );

  ///
  /// polygon
  ///

  /// to create [corners], see [RegularPolygon.cornersOf]
  static Translator<Size, Path> polygon(
    List<Offset> corners, {
    bool invertFromSize = false,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => Path()..addPolygon(corners, false),
      );

  ///
  /// [cubicPoints] should be the cubic points related to polygon corners in clockwise or counterclockwise sequence
  /// every element list of [cubicPoints] will be treated as [beginPoint, controlPointA, controlPointB, endPoint]
  ///
  /// see [RRegularPolygon.cubicPoints] and its subclasses for [cubicPoints] creation
  ///
  static Translator<Size, Path> polygonCubicCorner(
    Iterable<List<Offset>> cubicPoints, {
    bool invertFromSize = false,
    double scale = 1,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => cubicPoints
            .map((points) => scale == 1
                ? points
                : points.map((p) => p * scale).toList(growable: false))
            .foldWithIndex(
              Path(),
              (path, points, index) => path
                ..moveOrLineToPoint(index == 0, points[0])
                ..cubicToPointsList(points.sublist(1)),
            ),
      );

  static Translator<Size, Path> polygonCubicCornerFromSize(
    Iterable<List<Offset>> cubicPoints, {
    MapperWith<List<Offset>, Size> transform =
        FOffsetListWithSize.transformPointsToSizeCenter,
    bool invertFromSize = false,
    double scale = 1,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (size) => cubicPoints
            .map((points) => scale == 1
                ? points
                : points.map((p) => p * scale).toList(growable: false))
            .map((points) => transform(points, size))
            .foldWithIndex(
              Path(),
              (path, points, index) => path
                ..moveOrLineToPoint(index == 0, points[0])
                ..cubicToPointsList(points.sublist(1)),
            ),
      );

  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  static Translator<Size, Path> _invertFromSize({
    bool close = true,
    required bool invertFromSize,
    required Translator<Size, Path> sizeToPath,
  }) =>
      close
          ? invertFromSize
              ? (size) => sizeToPath(size)
                ..addRect(Offset.zero & size)
                ..close()
              : (size) => sizeToPath(size)..close()
          : invertFromSize
              ? (size) => sizeToPath(size)..addRect(Offset.zero & size)
              : (size) => sizeToPath(size);

  static Translator<Size, Path> fromShapeBorder(
    ShapeBorder shape, {
    TextDirection? textDirection,
    bool isOuterPath = true,
  }) =>
      isOuterPath
          ? (size) => shape.getOuterPath(
                Offset.zero & size,
                textDirection: textDirection,
              )
          : (size) => shape.getInnerPath(
                Offset.zero & size,
                textDirection: textDirection,
              );

  static Translator<Size, Path> circleHalfOf(bool isRight) => isRight
      ? FPathFromSize._circleHalf(
          arcStartOf: (size) => Offset.zero,
          arcEndOf: (size) => Offset(0, size.height),
          clockwise: true,
        )
      : FPathFromSize._circleHalf(
          arcStartOf: (size) => Offset(size.width, 0),
          arcEndOf: (size) => size.toOffset,
          clockwise: false,
        );

  static Translator<Size, Path> _circleHalf({
    bool clockwise = true,
    required Translator<Size, Offset> arcStartOf,
    required Translator<Size, Offset> arcEndOf,
  }) =>
      (size) {
        final start = arcStartOf(size);
        final end = arcEndOf(size);
        return Path()
          ..moveToPoint(start)
          ..arcToPoint(
            end,
            radius: ((end - start).distance / 2).toCircularRadius,
            clockwise: clockwise,
          )
          ..close();
      };

  /// pencil
  ///
  /// -----
  /// |   |
  /// |   |   <----[penBodyLength]
  /// |   |
  /// \   /
  ///  ---   <---- [flatWidth]
  ///
  ///
  static Translator<Size, Path> penpointFlat({
    bool invertFromSize = false,
    required Translator<Size, double> flatWidth,
    required Translator<Size, double> penBodyLength,
  }) =>
      FPathFromSize._invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (size) {
          final width = size.width;
          final height = size.height;
          final flatLength = flatWidth(size);
          final penBody = penBodyLength(size);

          return Path()
            ..lineTo(width, 0.0)
            ..lineTo(width, penBody)
            ..lineTo((width + flatLength) / 2, height)
            ..lineTo((width - flatLength) / 2, height)
            ..lineTo(0.0, penBody)
            ..lineTo(0.0, 0.0)
            ..close();
        },
      );
}

extension FPathFromRectSize on PathFromRectSize {
  static const PathFromRectSize addOval = _addOval;
  static const PathFromRectSize addRect = _addRect;

  static Path _addOval(Rect rect, Size size) =>
      FPathFromSize.addOval(rect)(size);

  static Path _addRect(Rect rect, Size size) =>
      FPathFromSize.addRect(rect)(size);
}

extension FPathFromRRectSize on PathFromRRectSize {
  static const PathFromRRectSize addRRect = _addRRect;

  static Path _addRRect(RRect rect, Size size) =>
      FPathFromSize.addRRect(rect)(size);
}

///
///
/// canvas, paint
///
///

extension FCanvasProcessor on CanvasProcessor {
  static const drawPathWithPaint = _drawPathWithPaint;

  static void _drawPathWithPaint(Canvas canvas, Paint paint, Path path) =>
      canvas.drawPath(path, paint);
}

extension FCanvasSizeToPaint on PaintFromCanvasSize {
  static const PaintFromCanvasSize whiteFill = _whiteFill;
  static const PaintFromCanvasSize redFill = _redFill;

  static Paint _whiteFill(Canvas canvas, Size size) => VPaintFill.white;

  static Paint _redFill(Canvas canvas, Size size) => VPaintFill.red;

  static PaintFromCanvasSize of(Paint paint) => (_, __) => paint;
}

extension VPaintFill on Paint {
  static Paint get _fill => Paint()..style = PaintingStyle.fill;

  static Paint get black => _fill..color = Colors.black;

  static Paint get white => _fill..color = Colors.white;

  static Paint get red => _fill..color = Colors.red;

  static Paint get orange => _fill..color = Colors.orange;

  static Paint get yellow => _fill..color = Colors.yellow;

  static Paint get green => _fill..color = Colors.green;

  static Paint get blue => _fill..color = Colors.blue;

  static Paint get blueAccent => _fill..color = Colors.blueAccent;

  static Paint get purple => _fill..color = Colors.purple;
}

extension VPaintFillBlur on Paint {
  static Paint get white_normal_05 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_05;

  static Paint get white_normal_1 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_1;

  static Paint get white_normal_2 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_2;

  static Paint get white_normal_3 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_3;

  static Paint get white_normal_4 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_4;

  static Paint get white_normal_5 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_5;

  static Paint get white_normal_6 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_6;

  static Paint get white_normal_7 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_7;

  static Paint get white_normal_8 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_8;

  static Paint get white_normal_9 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_9;

  static Paint get white_normal_10 =>
      VPaintFill.white..maskFilter = KMaskFilter.normal_10;
}

extension FPaintFill on Paint {
  static Paint of(Color color) => VPaintFill._fill..color = color;
}

extension VPaintStroke on Paint {
  static Paint get _stroke => Paint()..style = PaintingStyle.stroke;

  /// stroke

  static Paint get _stroke_1 => _stroke..strokeWidth = 1;

  static Paint get _stroke_2 => _stroke..strokeWidth = 2;

  static Paint get _stroke_3 => _stroke..strokeWidth = 3;

  static Paint get _stroke_4 => _stroke..strokeWidth = 4;

  static Paint get _stroke_5 => _stroke..strokeWidth = 5;

  /// cap

  static Paint get _stroke_1_capRound => _stroke_1..strokeCap = StrokeCap.round;

  static Paint get _stroke_1_capSquare =>
      _stroke_1..strokeCap = StrokeCap.square;

  static Paint get _stroke_1_capButt => _stroke_1..strokeCap = StrokeCap.butt;

  static Paint get _stroke_2_capRound => _stroke_2..strokeCap = StrokeCap.round;

  static Paint get _stroke_2_capSquare =>
      _stroke_2..strokeCap = StrokeCap.square;

  static Paint get _stroke_2_capButt => _stroke_2..strokeCap = StrokeCap.butt;

  static Paint get _stroke_3_capRound => _stroke_3..strokeCap = StrokeCap.round;

  static Paint get _stroke_3_capSquare =>
      _stroke_3..strokeCap = StrokeCap.square;

  static Paint get _stroke_3_capButt => _stroke_3..strokeCap = StrokeCap.butt;

  static Paint get _stroke_4_capRound => _stroke_4..strokeCap = StrokeCap.round;

  static Paint get _stroke_4_capSquare =>
      _stroke_4..strokeCap = StrokeCap.square;

  static Paint get _stroke_4_capButt => _stroke_4..strokeCap = StrokeCap.butt;

  static Paint get _stroke_5_capRound => _stroke_5..strokeCap = StrokeCap.round;

  static Paint get _stroke_5_capSquare =>
      _stroke_5..strokeCap = StrokeCap.square;

  static Paint get _stroke_5_capButt => _stroke_5..strokeCap = StrokeCap.butt;

  /// color_strokeWidth_cap

  // 1
  static Paint get black_1_capRound => _stroke_1_capRound..color = Colors.black;

  static Paint get black_1_capSquare =>
      _stroke_1_capSquare..color = Colors.black;

  static Paint get black_1_capButt => _stroke_1_capButt..color = Colors.black;

  static Paint get white_1_capRound => _stroke_1_capRound..color = Colors.white;

  static Paint get white_1_capSquare =>
      _stroke_1_capSquare..color = Colors.white;

  static Paint get white_1_capButt => _stroke_1_capButt..color = Colors.white;

  static Paint get red_1_capRound => _stroke_1_capRound..color = Colors.red;

  static Paint get red_1_capSquare => _stroke_1_capSquare..color = Colors.red;

  static Paint get red_1_capButt => _stroke_1_capButt..color = Colors.red;

  static Paint get orange_1_capRound =>
      _stroke_1_capRound..color = Colors.orange;

  static Paint get orange_1_capSquare =>
      _stroke_1_capSquare..color = Colors.orange;

  static Paint get orange_1_capButt => _stroke_1_capButt..color = Colors.orange;

  static Paint get yellow_1_capRound =>
      _stroke_1_capRound..color = Colors.yellow;

  static Paint get yellow_1_capSquare =>
      _stroke_1_capSquare..color = Colors.yellow;

  static Paint get yellow_1_capButt => _stroke_1_capButt..color = Colors.yellow;

  static Paint get green_1_capRound => _stroke_1_capRound..color = Colors.green;

  static Paint get green_1_capSquare =>
      _stroke_1_capSquare..color = Colors.green;

  static Paint get green_1_capButt => _stroke_1_capButt..color = Colors.green;

  static Paint get blue_1_capRound => _stroke_1_capRound..color = Colors.blue;

  static Paint get blue_1_capSquare => _stroke_1_capSquare..color = Colors.blue;

  static Paint get blue_1_capButt => _stroke_1_capButt..color = Colors.blue;

  static Paint get blueAccent_1_capRound =>
      _stroke_1_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_1_capSquare =>
      _stroke_1_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_1_capButt =>
      _stroke_1_capButt..color = Colors.blueAccent;

  static Paint get purple_1_capRound =>
      _stroke_1_capRound..color = Colors.purple;

  static Paint get purple_1_capSquare =>
      _stroke_1_capSquare..color = Colors.purple;

  static Paint get purple_1_capButt => _stroke_1_capButt..color = Colors.purple;

  // 2
  static Paint get black_2_capRound => _stroke_2_capRound..color = Colors.black;

  static Paint get black_2_capSquare =>
      _stroke_2_capSquare..color = Colors.black;

  static Paint get black_2_capButt => _stroke_2_capButt..color = Colors.black;

  static Paint get white_2_capRound => _stroke_2_capRound..color = Colors.white;

  static Paint get white_2_capSquare =>
      _stroke_2_capSquare..color = Colors.white;

  static Paint get white_2_capButt => _stroke_2_capButt..color = Colors.white;

  static Paint get red_2_capRound => _stroke_2_capRound..color = Colors.red;

  static Paint get red_2_capSquare => _stroke_2_capSquare..color = Colors.red;

  static Paint get red_2_capButt => _stroke_2_capButt..color = Colors.red;

  static Paint get orange_2_capRound =>
      _stroke_2_capRound..color = Colors.orange;

  static Paint get orange_2_capSquare =>
      _stroke_2_capSquare..color = Colors.orange;

  static Paint get orange_2_capButt => _stroke_2_capButt..color = Colors.orange;

  static Paint get yellow_2_capRound =>
      _stroke_2_capRound..color = Colors.yellow;

  static Paint get yellow_2_capSquare =>
      _stroke_2_capSquare..color = Colors.yellow;

  static Paint get yellow_2_capButt => _stroke_2_capButt..color = Colors.yellow;

  static Paint get green_2_capRound => _stroke_2_capRound..color = Colors.green;

  static Paint get green_2_capSquare =>
      _stroke_2_capSquare..color = Colors.green;

  static Paint get green_2_capButt => _stroke_2_capButt..color = Colors.green;

  static Paint get blue_2_capRound => _stroke_2_capRound..color = Colors.blue;

  static Paint get blue_2_capSquare => _stroke_2_capSquare..color = Colors.blue;

  static Paint get blue_2_capButt => _stroke_2_capButt..color = Colors.blue;

  static Paint get blueAccent_2_capRound =>
      _stroke_2_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_2_capSquare =>
      _stroke_2_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_2_capButt =>
      _stroke_2_capButt..color = Colors.blueAccent;

  static Paint get purple_2_capRound =>
      _stroke_2_capRound..color = Colors.purple;

  static Paint get purple_2_capSquare =>
      _stroke_2_capSquare..color = Colors.purple;

  static Paint get purple_2_capButt => _stroke_2_capButt..color = Colors.purple;

  // 3
  static Paint get black_3_capRound => _stroke_3_capRound..color = Colors.black;

  static Paint get black_3_capSquare =>
      _stroke_3_capSquare..color = Colors.black;

  static Paint get black_3_capButt => _stroke_3_capButt..color = Colors.black;

  static Paint get white_3_capRound => _stroke_3_capRound..color = Colors.white;

  static Paint get white_3_capSquare =>
      _stroke_3_capSquare..color = Colors.white;

  static Paint get white_3_capButt => _stroke_3_capButt..color = Colors.white;

  static Paint get red_3_capRound => _stroke_3_capRound..color = Colors.red;

  static Paint get red_3_capSquare => _stroke_3_capSquare..color = Colors.red;

  static Paint get red_3_capButt => _stroke_3_capButt..color = Colors.red;

  static Paint get orange_3_capRound =>
      _stroke_3_capRound..color = Colors.orange;

  static Paint get orange_3_capSquare =>
      _stroke_3_capSquare..color = Colors.orange;

  static Paint get orange_3_capButt => _stroke_3_capButt..color = Colors.orange;

  static Paint get yellow_3_capRound =>
      _stroke_3_capRound..color = Colors.yellow;

  static Paint get yellow_3_capSquare =>
      _stroke_3_capSquare..color = Colors.yellow;

  static Paint get yellow_3_capButt => _stroke_3_capButt..color = Colors.yellow;

  static Paint get green_3_capRound => _stroke_3_capRound..color = Colors.green;

  static Paint get green_3_capSquare =>
      _stroke_3_capSquare..color = Colors.green;

  static Paint get green_3_capButt => _stroke_3_capButt..color = Colors.green;

  static Paint get blue_3_capRound => _stroke_3_capRound..color = Colors.blue;

  static Paint get blue_3_capSquare => _stroke_3_capSquare..color = Colors.blue;

  static Paint get blue_3_capButt => _stroke_3_capButt..color = Colors.blue;

  static Paint get blueAccent_3_capRound =>
      _stroke_3_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_3_capSquare =>
      _stroke_3_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_3_capButt =>
      _stroke_3_capButt..color = Colors.blueAccent;

  static Paint get purple_3_capRound =>
      _stroke_3_capRound..color = Colors.purple;

  static Paint get purple_3_capSquare =>
      _stroke_3_capSquare..color = Colors.purple;

  static Paint get purple_3_capButt => _stroke_3_capButt..color = Colors.purple;

  // 4
  static Paint get black_4_capRound => _stroke_4_capRound..color = Colors.black;

  static Paint get black_4_capSquare =>
      _stroke_4_capSquare..color = Colors.black;

  static Paint get black_4_capButt => _stroke_4_capButt..color = Colors.black;

  static Paint get white_4_capRound => _stroke_4_capRound..color = Colors.white;

  static Paint get white_4_capSquare =>
      _stroke_4_capSquare..color = Colors.white;

  static Paint get white_4_capButt => _stroke_4_capButt..color = Colors.white;

  static Paint get red_4_capRound => _stroke_4_capRound..color = Colors.red;

  static Paint get red_4_capSquare => _stroke_4_capSquare..color = Colors.red;

  static Paint get red_4_capButt => _stroke_4_capButt..color = Colors.red;

  static Paint get orange_4_capRound =>
      _stroke_4_capRound..color = Colors.orange;

  static Paint get orange_4_capSquare =>
      _stroke_4_capSquare..color = Colors.orange;

  static Paint get orange_4_capButt => _stroke_4_capButt..color = Colors.orange;

  static Paint get yellow_4_capRound =>
      _stroke_4_capRound..color = Colors.yellow;

  static Paint get yellow_4_capSquare =>
      _stroke_4_capSquare..color = Colors.yellow;

  static Paint get yellow_4_capButt => _stroke_4_capButt..color = Colors.yellow;

  static Paint get green_4_capRound => _stroke_4_capRound..color = Colors.green;

  static Paint get green_4_capSquare =>
      _stroke_4_capSquare..color = Colors.green;

  static Paint get green_4_capButt => _stroke_4_capButt..color = Colors.green;

  static Paint get blue_4_capRound => _stroke_4_capRound..color = Colors.blue;

  static Paint get blue_4_capSquare => _stroke_4_capSquare..color = Colors.blue;

  static Paint get blue_4_capButt => _stroke_4_capButt..color = Colors.blue;

  static Paint get blueAccent_4_capRound =>
      _stroke_4_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_4_capSquare =>
      _stroke_4_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_4_capButt =>
      _stroke_4_capButt..color = Colors.blueAccent;

  static Paint get purple_4_capRound =>
      _stroke_4_capRound..color = Colors.purple;

  static Paint get purple_4_capSquare =>
      _stroke_4_capSquare..color = Colors.purple;

  static Paint get purple_4_capButt => _stroke_4_capButt..color = Colors.purple;

  // 5
  static Paint get black_5_capRound => _stroke_5_capRound..color = Colors.black;

  static Paint get black_5_capSquare =>
      _stroke_5_capSquare..color = Colors.black;

  static Paint get black_5_capButt => _stroke_5_capButt..color = Colors.black;

  static Paint get white_5_capRound => _stroke_5_capRound..color = Colors.white;

  static Paint get white_5_capSquare =>
      _stroke_5_capSquare..color = Colors.white;

  static Paint get white_5_capButt => _stroke_5_capButt..color = Colors.white;

  static Paint get red_5_capRound => _stroke_5_capRound..color = Colors.red;

  static Paint get red_5_capSquare => _stroke_5_capSquare..color = Colors.red;

  static Paint get red_5_capButt => _stroke_5_capButt..color = Colors.red;

  static Paint get orange_5_capRound =>
      _stroke_5_capRound..color = Colors.orange;

  static Paint get orange_5_capSquare =>
      _stroke_5_capSquare..color = Colors.orange;

  static Paint get orange_5_capButt => _stroke_5_capButt..color = Colors.orange;

  static Paint get yellow_5_capRound =>
      _stroke_5_capRound..color = Colors.yellow;

  static Paint get yellow_5_capSquare =>
      _stroke_5_capSquare..color = Colors.yellow;

  static Paint get yellow_5_capButt => _stroke_5_capButt..color = Colors.yellow;

  static Paint get green_5_capRound => _stroke_5_capRound..color = Colors.green;

  static Paint get green_5_capSquare =>
      _stroke_5_capSquare..color = Colors.green;

  static Paint get green_5_capButt => _stroke_5_capButt..color = Colors.green;

  static Paint get blue_5_capRound => _stroke_5_capRound..color = Colors.blue;

  static Paint get blue_5_capSquare => _stroke_5_capSquare..color = Colors.blue;

  static Paint get blue_5_capButt => _stroke_5_capButt..color = Colors.blue;

  static Paint get blueAccent_5_capRound =>
      _stroke_5_capRound..color = Colors.blueAccent;

  static Paint get blueAccent_5_capSquare =>
      _stroke_5_capSquare..color = Colors.blueAccent;

  static Paint get blueAccent_5_capButt =>
      _stroke_5_capButt..color = Colors.blueAccent;

  static Paint get purple_5_capRound =>
      _stroke_5_capRound..color = Colors.purple;

  static Paint get purple_5_capSquare =>
      _stroke_5_capSquare..color = Colors.purple;

  static Paint get purple_5_capButt => _stroke_5_capButt..color = Colors.purple;

  /// eraser
  static Paint get _eraser => _stroke..color = Colors.transparent;

  static Paint get _eraser_clear => _eraser..blendMode = BlendMode.clear;

  static Paint get eraser_1 => _eraser_clear..strokeWidth = 1;

  static Paint get eraser_2 => _eraser_clear..strokeWidth = 2;

  static Paint get eraser_3 => _eraser_clear..strokeWidth = 3;

  static Paint get eraser_4 => _eraser_clear..strokeWidth = 4;

  static Paint get eraser_5 => _eraser_clear..strokeWidth = 5;
}

extension KMaskFilter on Paint {
  /// normal
  static const MaskFilter normal_05 = MaskFilter.blur(BlurStyle.normal, 0.5);
  static const MaskFilter normal_1 = MaskFilter.blur(BlurStyle.normal, 1);
  static const MaskFilter normal_2 = MaskFilter.blur(BlurStyle.normal, 2);
  static const MaskFilter normal_3 = MaskFilter.blur(BlurStyle.normal, 3);
  static const MaskFilter normal_4 = MaskFilter.blur(BlurStyle.normal, 4);
  static const MaskFilter normal_5 = MaskFilter.blur(BlurStyle.normal, 5);
  static const MaskFilter normal_6 = MaskFilter.blur(BlurStyle.normal, 6);
  static const MaskFilter normal_7 = MaskFilter.blur(BlurStyle.normal, 7);
  static const MaskFilter normal_8 = MaskFilter.blur(BlurStyle.normal, 8);
  static const MaskFilter normal_9 = MaskFilter.blur(BlurStyle.normal, 9);
  static const MaskFilter normal_10 = MaskFilter.blur(BlurStyle.normal, 10);

  /// solid
  static const MaskFilter solid_05 = MaskFilter.blur(BlurStyle.solid, 0.5);
}

///
///
///
/// clipper
///
///
///

extension FClipPath on CustomPaint {
  static ClipPath decoratedPolygon(
    Decoration decoration,
    RRegularPolygon polygon, {
    DecorationPosition position = DecorationPosition.background,
    Widget child = KSizedBox.expand,
  }) =>
      ClipPath(
        clipper: FMyClipper.polygonCubicCornerFromSize(polygon),
        child: DecoratedBox(
          decoration: decoration,
          position: position,
          child: child,
        ),
      );
}

extension FMyClipper on MyClipper {
  static MyClipper rectOf(Rect rect) =>
      MyClipper.reClipNeverOf((_) => Path()..addRect(rect));

  static MyClipper rectFromZeroTo(Offset corner) =>
      rectOf(Rect.fromPoints(Offset.zero, corner));

  static MyClipper polygonCubicCornerFromSize(RRegularPolygon polygon) =>
      MyClipper.reClipNeverOf(
        FPathFromSize.polygonCubicCornerFromSize(polygon.cubicPoints),
      );
}

extension FMyClipperMationTransform on MyAnimation {
  static MyAnimation rotate({
    Clip clipBehavior = Clip.antiAlias,
    required AlignmentGeometry alignment,
    required Ani setting,
    required Between<Coordinate> tween,
    required Translator<Size, Path> sizeToPath,
    required Widget child,
  }) =>
      MyAnimation(
        mation: _MationTransformBase.rotate(alignment: alignment, tween),
        child: ClipPath(
          clipper: MyClipper.reClipNeverOf(sizeToPath),
          clipBehavior: clipBehavior,
          child: child,
        ),
      );
}

extension FMyClipperMationTransformRowTransform on MyAnimation {
  static MyAnimation rotateHalfCircleFlip({
    MainAxisAlignment halfCircleAlignment = MainAxisAlignment.center,
    Widget? childRight,
    Widget? childLeft,
    required Between<Coordinate> tweenRotate,
    required Between<Coordinate> tweenFlip,
    required AnimationStatusListener statusListenerRotate,
    required AnimationStatusListener statusListenerFlip,
    required bool isFlipped,
  }) =>
      MyAnimation(
        ani: Ani.initForward(
          initialStatusListener: statusListenerRotate,
          updateProcess: FAni.decideResetForward(isFlipped),
        ),
        mation: _MationTransformBase.rotate(
          alignment: Alignment.center,
          tweenRotate,
        ),
        child: Row(
          mainAxisAlignment: halfCircleAlignment,
          children: [
            FMyClipperMationTransform.rotate(
              tween: tweenFlip,
              alignment: Alignment.centerRight,
              sizeToPath: FPathFromSize.circleHalfOf(false),
              setting: Ani(
                updateProcess: FAni.decideResetForward(!isFlipped),
              ),
              child: childLeft ?? FSizedBox.square100Of(KColoredBox.blue),
            ),
            FMyClipperMationTransform.rotate(
              tween: tweenFlip,
              alignment: Alignment.centerLeft,
              sizeToPath: FPathFromSize.circleHalfOf(true),
              setting: Ani(
                initialStatusListener: statusListenerFlip,
                updateProcess: FAni.decideResetForward(!isFlipped),
              ),
              child: childRight ?? FSizedBox.square100Of(KColoredBox.yellow),
            ),
          ],
          // children: [VContainerStyled.gradiantWhitRed],
        ),
      );
}

///
///
/// painter
///
///

extension FCustomPaint on CustomPaint {
  static CustomPaint polygonCanvasSizeToPaint(
    RRegularPolygonCubicOnEdge polygon,
    PaintFromCanvasSize paintFromCanvasSize, {
    Widget child = KSizedBox.expand,
  }) =>
      CustomPaint(
        painter: FMyPainter.polygonCubicCorner(paintFromCanvasSize, polygon),
        child: child,
      );
}

extension FMyPainter on MyPainter {
  static MyPainter polygonCubicCorner(
    PaintFromCanvasSize paintFromCanvasSize,
    RRegularPolygon polygon,
  ) =>
      MyPainter.rePaintNever(
        paintFromCanvasSize: paintFromCanvasSize,
        sizeToPath: FPathFromSize.polygonCubicCorner(polygon.cubicPoints),
      );
}

extension FMationPainter on MationPainter {
  static MationPainter progressingCircles({
    double initialCircleRadius = 5.0,
    double circleRadiusFactor = 0.1,
    required Ani setting,
    required Paint paint,
    required Tween<double> radiusOrbit,
    required int circleCount,
    required MapperWith<Vector, int> planetGenerator,
  }) =>
      MationPainter.drawPathTweenWithPaint(
        canvasSizeToPaint: (_, __) => paint,
        BetweenPath.fromTween(
          Between<Vector>(
            begin: Vector(Coordinate.zero, radiusOrbit.begin!),
            end: Vector(KRadianCoordinate.angleZ_360, radiusOrbit.end!),
          ),
          lerp: (vector) => PathOperation.union.operateSizeToPathAll(
            Iterable.generate(
              circleCount,
              (i) => (_) => Path()
                ..addOval(
                  Rect.fromCircle(
                    center: planetGenerator(vector, i).toCoordinate,
                    radius: initialCircleRadius * (i + 1) * circleRadiusFactor,
                  ),
                ),
            ),
          ),
        ),
      );
}

///
///
/// polygon
///
///

extension FRRegularPolygon on RRegularPolygon {
  static RRegularPolygonCubicOnEdge randomOfCubicStyleOnEdge({
    MapEntry<int, int> nBound = const MapEntry(3, 8),
    MapEntry<int, int> rBound = const MapEntry(60, 60),
  }) {
    final r = math.Random();
    return RRegularPolygonCubicOnEdge(
      nBound.key + r.nextInt(nBound.value),
      radiusCircumscribedCircle: rBound.key + r.nextInt(rBound.value),
    );
  }
}
