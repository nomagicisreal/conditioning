// ignore_for_file: constant_identifier_names, non_constant_identifier_names

part of source;

///
/// this file contains:
/// [kVoidCallback]
///
/// [KDoubleMapper], [FDoubleMapper], [KCurveMapper], [KCubicPointsMapper]
/// [FStream]
///
/// [FListAnimatedItemBuilder], [FListAnimatedItemListener]
///
/// [FSizeToBoxConstraints]
/// [FSizeToPath], [FSizeToPathRow], [FSizeToPathOperation]
/// [FCanvasListener]
///
/// [FTextFormFieldValidator]
///
/// [FImageLoadingBuilder]
///
/// [FInputDecorationBuilder]
/// [FWidgetListBuilder]
///
///

void _voidCallback() {}
const VoidCallback kVoidCallback = _voidCallback;

extension KDoubleMapper on DoubleMapper {
  static const DoubleMapper none = _none;
  static const DoubleMapper sin_3_04 = _sin_3_04;

  static double _none(double t) => t;
  static double _sin_3_04(double value) => sin(value * 3) * 0.4;
}

extension FDoubleMapper on DoubleMapper {
  static DoubleMapper sinFromFactor({
    required double timeFactor,
    required double factor,
  }) =>
      (value) => sin(timeFactor * value) * factor;

  // return times of period of (0 ~ 1 ~ 0 ~ -1 ~ 0)
  static DoubleMapper sinPeriodOf(double times) {
    final tween = Tween(begin: 0.0, end: KRadian.angle_360 * times);
    return (value) => sin(tween.transform(value));
  }

  static DoubleMapper operate(Operator operator, double value) =>
      (v) => operator.operateDouble(v, value);

  static DoubleMapper operateAngle(Operator operator, double angle) =>
      (v) => FRadian.operateWithAngle(v, operator, angle);

  static DoubleMapper operateAngles(Map<Operator, double> operations) =>
      (v) => FRadian.operateAllWithAngle(v, operations);

}

extension KCurveMapper on CurveMapper {
  static const CurveMapper flipped = _flipped;
  static Curve _flipped(Curve curve) => curve.flipped;
}

extension KCubicPointsMapper on CubicPointsMapper {
  static const CubicPointsMapper keep = _keep;
  static const CubicPointsMapper add0_remove0 = _add0_remove0;
  static const CubicPointsMapper add1_remove1 = _add1_remove1;
  static const CubicPointsMapper add2_remove2 = _add2_remove2;

  static Map<Offset, List<Offset>> _keep(Map<Offset, List<Offset>> points) =>
      points;

  static Map<Offset, List<Offset>> _add0_remove0(
    Map<Offset, List<Offset>> points,
  ) =>
      points.map((point, cubicPoints) => MapEntry(
            point,
            cubicPoints
              ..add(cubicPoints[0])
              ..removeAt(0),
          ));

  static Map<Offset, List<Offset>> _add1_remove1(
    Map<Offset, List<Offset>> points,
  ) =>
      points.map((point, cubicPoints) => MapEntry(
            point,
            cubicPoints
              ..add(cubicPoints[1])
              ..removeAt(1),
          ));

  static Map<Offset, List<Offset>> _add2_remove2(
    Map<Offset, List<Offset>> points,
  ) =>
      points.map((point, cubicPoints) => MapEntry(
            point,
            cubicPoints
              ..add(cubicPoints[2])
              ..removeAt(2),
          ));
}

extension FStream on Stream {
  static Stream<int> intOf({
    int start = 1,
    int end = 10,
    Duration interval = KDuration.second1,
    bool startWithoutDelay = true,
  }) async* {
    final yieldFun = startWithoutDelay
        ? (int value) async => await Future.delayed(interval).then((_) => value)
        : (int value) async => value == start
            ? value
            : await Future.delayed(interval).then((_) => value);

    if (end >= start) {
      for (var value = start; value <= end; value++) {
        yield await yieldFun(value);
      }
    } else {
      for (var value = start; value >= end; value--) {
        yield await yieldFun(value);
      }
    }
  }

  static Stream<double> doubleOf(
    int elementCount, {
    Duration interval = KDuration.second1,
  }) async* {
    for (int i = 0; i < elementCount; i++) {
      yield i.toDouble();
      await Future.delayed(interval);
    }
  }

  static Stream<FollowerBuilder> followerOf(
    int elementCount, {
    Duration interval = KDuration.second2,
    Offset begin = Offset.zero,
    Offset distance = KCoordinate.cube_10,
  }) async* {
    Offset offset = begin;
    for (int i = 0; i < elementCount; i++, offset += distance) {
      yield (link) => Follower(
            link: link,
            leaderOffset: offset,
            anchorOnLeader: Alignment.center,
            child: VContainer.squareGreen_300,
          );
      await Future.delayed(interval);
    }
  }
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
            decoration: KShapeDecoration.stadiumGrey,
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
                  icon: KIcon.cancel_24,
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

extension FSizeToBoxConstraints on Size {
  static BoxConstraints minWH100_maxWH08Of(Size size) => BoxConstraints(
        minWidth: 100,
        minHeight: 100,
        maxHeight: size.height * 0.8,
        maxWidth: size.width * 0.8,
      );

// ...
}

///
/// [line]
/// [lineAll]
/// [bezierQuadratic]
/// [bezierCubic]
/// [circle]
/// [circleHalf]
/// [rect]
/// [rRect]
/// [polygon]
/// [polygonCubicCorner]
/// [trapezium]
/// [pencil]
///
extension FSizeToPath on SizeToPath {
  static SizeToPath _invertFromSize({
    bool close = true,
    required bool invertFromSize,
    required SizeToPath sizeToPath,
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

  ///
  /// line
  ///

  static SizeToPath line({
    required Offset from,
    required Offset to,
    PathFillType pathFillType = PathFillType.nonZero,
  }) =>
      (_) => Path()
        ..connect(from, to)
        ..fillType = pathFillType
        ..close();

  static SizeToPath lineAll({
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

  ///
  /// bezier
  ///

  static SizeToPath bezierQuadratic({
    bool invertFromSize = false,
    required Offset controlPoint,
    required Offset endPoint,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) =>
            Path()..quadraticBezierToPoint(controlPoint, endPoint),
      );

  static SizeToPath bezierCubic({
    bool invertFromSize = false,
    required Offset c1,
    required Offset c2,
    required Offset endPoint,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => Path()..cubicToPoint(c1, c2, endPoint),
      );

  ///
  /// oval
  ///

  static SizeToPath circle({
    bool invertFromSize = false,
    required Offset center,
    required double radius,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) =>
            Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
      );

  static SizeToPath circleFromSize({
    bool invertFromSize = false,
    required SizeToOffset center,
    required SizeToDouble radius,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (size) => Path()
          ..addOval(Rect.fromCircle(
            center: center(size),
            radius: radius(size),
          )),
      );

  static SizeToPath circleHalf({
    bool clockwise = true,
    required SizeToOffset arcStartOf,
    required SizeToOffset arcEndOf,
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

  /// rect
  ///
  /// A
  ///  --------
  ///  |      |       [cornerA] = A
  ///  |      |       [cornerB] = B
  ///  --------
  ///          B
  ///
  static SizeToPath rect({
    bool invertFromSize = false,
    required Offset cornerA,
    required Offset cornerB,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => Path()..addRect(Rect.fromPoints(cornerA, cornerB)),
      );

  static SizeToPath rRect({
    bool invertFromSize = false,
    Radius radius = KRadius.circular10,
    required Offset cornerA,
    required Offset cornerB,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => Path()
          ..addRRect(RRect.fromRectAndRadius(
            Rect.fromPoints(cornerA, cornerB),
            radius,
          )),
      );

  ///
  /// polygon
  ///

  ///
  /// see [RegularPolygon.cornersOf] for [corners] creation
  ///
  static SizeToPath polygon(
    List<Offset> corners, {
    bool invertFromSize = false,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (_) => Path()..addPolygon(corners, false),
      );

  static SizeToPath polygonFromSize(
    SizeToOffsetList corners, {
    bool invertFromSize = false,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: (size) => Path()..addPolygon(corners(size), false),
      );

  ///
  /// [cubicPoints] should be the cubic points related to polygon corners in clockwise or counterclockwise sequence
  /// every element list of [cubicPoints] will be treated as [beginPoint, controlPointA, controlPointB, endPoint]
  ///
  /// see [RRegularPolygon.cubicPoints] and its subclasses for [cubicPoints] creation
  ///
  static SizeToPath polygonCubicCorner(
    Iterable<List<Offset>> cubicPoints, {
    OnOffsetListWithSize? transform,
    bool invertFromSize = false,
    double scale = 1,
  }) =>
      _invertFromSize(
        invertFromSize: invertFromSize,
        sizeToPath: transform == null
            ? (_) => cubicPoints
                .map((points) => scale == 1
                    ? points
                    : points.map((p) => p * scale).toList(growable: false))
                .foldWithIndex(
                  Path(),
                  (path, points, index) => path
                    ..moveOrLineToPoint(index == 0, points[0])
                    ..cubicToPointsList(points.sublist(1)),
                )
            : (size) => cubicPoints
                .map((points) => scale == 1
                    ? points
                    : points.map((p) => p * scale).toList(growable: false))

                /// compared with transform == null, only this line is been added.
                .map((points) => transform(points, size))
                .foldWithIndex(
                  Path(),
                  (path, points, index) => path
                    ..moveOrLineToPoint(index == 0, points[0])
                    ..cubicToPointsList(points.sublist(1)),
                ),
      );

  /// trapezium
  ///
  /// [parallelFactor] = AB / CD
  ///
  /// A   B
  ///  ---
  /// /   \
  /// -----
  /// C    D
  ///
  static SizeToPath trapezium({
    bool invertFromSize = false,
    required double parallelFactor,
  }) {
    assert(parallelFactor < 1, 'invalid factor');

    return _invertFromSize(
      invertFromSize: invertFromSize,
      sizeToPath: (size) {
        final width = size.width;
        final height = size.height;
        final padding = width * ((1 - parallelFactor) / 2);

        return Path()
          ..moveTo(padding, 0.0)
          ..lineTo(width - padding, 0.0)
          ..lineTo(width, height)
          ..lineTo(0.0, height)
          ..lineTo(padding, 0.0);
      },
    );
  }

  /// pencil
  ///
  /// [verticalFactor] description see [trapezium]
  ///
  /// -----
  /// |   |
  /// |   |   b = (the length of '|')
  /// |   |
  /// \   /   a = (the length of '\' and '/')
  ///  ---
  ///
  /// [horizontalFactor] = a / b
  ///
  static SizeToPath pencil({
    bool invertFromSize = false,
    required double verticalFactor,
    required double horizontalFactor,
  }) {
    assert(verticalFactor < 1, 'invalid pencil');

    return _invertFromSize(
      invertFromSize: invertFromSize,
      sizeToPath: (size) {
        final width = size.width;
        final height = size.height;
        final pencilTailPadding = width * ((1 - verticalFactor) / 2);
        final pencilBody = height * (1 / (1 + horizontalFactor));

        return Path()
          ..lineTo(width, 0.0)
          ..lineTo(width, pencilBody)
          ..lineTo(width - pencilTailPadding, height)
          ..lineTo(pencilTailPadding, height)
          ..lineTo(0.0, pencilBody)
          ..lineTo(0.0, 0.0)
          ..close();
      },
    );
  }
}

///
/// [circleLeftRight]
///
extension FSizeToPathRow on SizeToPath {
  static SizeToPath circleLeftRight({
    required bool isRight,
  }) =>
      isRight
          ? FSizeToPath.circleHalf(
              arcStartOf: (size) => Offset.zero,
              arcEndOf: (size) => Offset(0, size.height),
              clockwise: true,
            )
          : FSizeToPath.circleHalf(
              arcStartOf: (size) => Offset(size.width, 0),
              arcEndOf: (size) => size.toOffset,
              clockwise: false,
            );
}

extension FSizeToPathOperation on SizeToPath {
  static SizeToPath operate(
    PathOperation operation,
    SizeToPath spA,
    SizeToPath spB,
  ) =>
      (size) => Path.combine(operation, spA(size), spB(size));

  static SizeToPath operateAll({
    required PathOperation operation,
    required Iterable<SizeToPath> sps,
  }) =>
      sps.reduce((sp, spNext) => operate(operation, sp, spNext));
}

extension FCanvasListener on CanvasListener {
  static const drawPathWithPaint = _drawPathWithPaint;

  static void _drawPathWithPaint(Canvas canvas, Paint paint, Path path) =>
      canvas.drawPath(path, paint);
}

extension FTextFormFieldValidator on TextFormFieldValidator {
  static FormFieldValidator<String> validateNullOrEmpty(
    String validationFailedMessage,
  ) =>
      (value) =>
          value == null || value.isEmpty ? validationFailedMessage : null;
}

extension FWidgetListBuilder on Widget {
  static List<Widget> sandwich({
    bool isRow = true,
    required int boundary,
    required BoxConstraints breadConstraints,
    required BoxConstraints meatConstraints,
    required Widget Function(int index) bread,
    required Widget Function(int indexOfPreviousBread) meat,
  }) {
    List<Widget> children(int index) => [
          Container(constraints: breadConstraints, child: bread(index)),
          index != boundary
              ? Container(constraints: meatConstraints, child: meat(index))
              : const SizedBox()
        ];

    return isRow
        ? List<Row>.generate(
            boundary,
            (index) => Row(
              children: children(index),
            ),
          )
        : List<Column>.generate(
            boundary,
            (index) => Column(
              children: children(index),
            ),
          );
  }
}

extension FInputDecorationBuilder on InputDecoration {
  static InputDecoration rowLabelIconText({
    InputBorder? border,
    required Icon icon,
    required String text,
  }) =>
      InputDecoration(
        alignLabelWithHint: true,
        border: border,
        contentPadding: switch (border) {
          KInputBorder.outline => null,
          null => EdgeInsets.zero,
          _ => throw UnimplementedError(),
        },
        label: Row(
          children: [
            icon,
            Text(text, style: KTextStyle.roboto),
          ],
        ),
      );
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
          : Container(
              decoration: KBoxDecorationBorderRadius.circularAllGrey_10,
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
      KIcon.accountCircleStyle2;

  static Widget errorStyle1(BuildContext c, Object o, StackTrace? s) =>
      const SizedBox(height: 200, width: 200, child: Icon(Icons.error));
}

extension FOnOffsetListWithSize on OnOffsetListWithSize {
  static List<Offset> transformPointsToSizeCenter(
    List<Offset> points,
    Size size,
  ) =>
      points.adjustCenterOf(size);
}
