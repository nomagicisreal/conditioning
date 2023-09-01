

import 'package:conditioning/res/usecase/material.dart';

///
/// this file contains:
/// [ItemModificationOption]
/// [ItemMutation]
/// [AnimatedContainerUsage]
/// [AnimatedContainerUsageData]
///
///

enum ItemModificationOption {
  create,
  remove,
  focus,
  select,
  refresh,
  otherUpdate,
}

class ItemMutation {
  final ItemModificationOption option;
  final CustomAnimatedContainer? currentCoordinateMapItem;

  const ItemMutation({
    required this.option,
    this.currentCoordinateMapItem,
  });

  const ItemMutation.coordinateMapItem({
    required this.option,
    required this.currentCoordinateMapItem,
  }) : assert(currentCoordinateMapItem != null);
}

enum AnimatedContainerUsage {
  template,
  layoutGraph,
  layoutGraphItem,
  layoutGraphItemDistance,
  layoutGraphItemCorner,
  plane,
}

///
/// animated container usage data
/// [AnimatedContainerUsageData.layoutGraph]
/// [AnimatedContainerUsageData.layoutGraphItem]
/// [AnimatedContainerUsageData.layoutGraphItemDistance]
/// [AnimatedContainerUsageData.layoutGraphItemCorner]
/// [AnimatedContainerUsageData.template]
/// [AnimatedContainerUsageData._format]
///
// class AnimatedContainerUsageData {
//   Coordinate? get border {
//     switch (category) {
//       case AnimatedContainerUsage.layoutGraph:
//         return _border;
//       case AnimatedContainerUsage.layoutGraphItem:
//       case AnimatedContainerUsage.layoutGraphItemDistance:
//       case AnimatedContainerUsage.layoutGraphItemCorner:
//         return _border!;
//       case AnimatedContainerUsage.plane:
//         return _border!.retain2DAsXY;
//       case AnimatedContainerUsage.template:
//         throw TemplateError();
//     }
//   }
//
//   Widget get child {
//     switch (category) {
//       case AnimatedContainerUsage.layoutGraph:
//       case AnimatedContainerUsage.layoutGraphItem:
//       case AnimatedContainerUsage.layoutGraphItemDistance:
//       case AnimatedContainerUsage.layoutGraphItemCorner:
//       case AnimatedContainerUsage.plane:
//         return _child;
//       case AnimatedContainerUsage.template:
//         throw TemplateError();
//     }
//   }
//
//   final AnimatedContainerUsage category;
//   final Key? key;
//   final Coordinate? _border;
//   final Widget _child;
//
//   const AnimatedContainerUsageData.template()
//       : category = AnimatedContainerUsage.template,
//         key = null,
//         _border = null,
//         _child = KSizedBox.none;
//
//   const AnimatedContainerUsageData.layoutGraph({
//     this.key,
//     required Graph graph,
//   })  : category = AnimatedContainerUsage.layoutGraph,
//         _border = null,
//         _child = graph;
//
//   /// layout graph item
//   const AnimatedContainerUsageData.layoutGraphItem({
//     required ValueKey<Coordinate> position,
//     required Coordinate border,
//     required Widget child,
//   })  : category = AnimatedContainerUsage.layoutGraphItem,
//         key = position,
//         _border = border,
//         _child = child;
//
//   const AnimatedContainerUsageData.layoutGraphItemDistance({
//     this.key,
//     required Coordinate border,
//     required Widget child,
//   })  : category = AnimatedContainerUsage.layoutGraphItemDistance,
//         _border = border,
//         _child = child;
//
//   const AnimatedContainerUsageData.layoutGraphItemCorner({
//     this.key,
//     required Coordinate border,
//     required Widget child,
//   })  : category = AnimatedContainerUsage.layoutGraphItemCorner,
//         _border = border,
//         _child = child;
//
//   /// plane
//   const AnimatedContainerUsageData.plane({
//     this.key,
//     required Coordinate border,
//     required Widget child,
//   })  : category = AnimatedContainerUsage.plane,
//         _border = border,
//         _child = child;
// }
