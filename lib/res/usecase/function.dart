part of usecase;

extension FDev on Object {
  void log([String? string]) => developer.log(string ?? "\n${toString()}");

  static VoidCallback listenerOnPressOf(
    BuildContext context, {
    bool isShowDialog = false,
  }) =>
      isShowDialog
          ? () => showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text('not yet complete'),
                  actions: [
                    TextButton(
                      onPressed: () => context.navigator.pop(),
                      child: const Text('close'),
                    ),
                  ],
                ),
              )
          : () => context.showSnackbarWithMessage('hello world');
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
//
// Future<void> pickAndUploadImage() async {
//   XFile? pickedFile = await ImagePicker()
//       .pickImage(source: ImageSource.gallery)
//       .catchError((onError) {
//     Fluttertoast.showToast(msg: onError.toString());
//   });
//   File? image = pickedFile != null ? File(pickedFile.path) : null;
//   if (image != null) {
//     final storageProvider = StorageProviderFirebase();
//     storageProvider.initialize();
//
//     try {
//       // final photoUrl = await storageProvider.uploadImageFileAndStoreUrl(image: image, fileName: userId);
//     } on FirebaseException catch (e) {
//       Fluttertoast.showToast(msg: 'FirebaseException:\t${e.toString()}');
//     } on Exception catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
// }

///
///
///
///
/// [_RectVariation] is to enable switch statement of [RectSetup.rectFrom]
///
///
///
///
enum _RectVariation {
  zero,

  // rect
  rectZeroToFull,
  rectZeroToSize,
  rectOffsetToSize,

  // circle
  circleZeroToFull,
  circleZeroToRadius,
  circleOffsetToRadius,

  // oval
  ovalZeroToFull,
  ovalZeroToSize,
  ovalOffsetToSize,
}

///
///
/// [RectSetup.zero]
/// [RectSetup.rectZeroToFull]
/// [RectSetup.circleZeroToFull]
/// [RectSetup.ovalZeroToFull]
///
/// [RectSetup.rectZeroToSize]
/// [RectSetup.rectOffsetToSize]
/// [RectSetup.circleZeroToRadius]
/// [RectSetup.circleOffsetToRadius]
/// [RectSetup.ovalZeroToRadius]
/// [RectSetup.ovalOffsetToRadius]
///
///

class RectSetup {
  final _RectVariation _variation;
  final Mapper<Size>? _rectZeroToSize;
  final Mapper<Size>? _ovalZeroToSize;
  final Translator<Size, double>? _circleZeroToRadius;
  final (Translator<Size, Offset>, Mapper<Size>)? _rectOffsetToSize;
  final (Translator<Size, Offset>, Mapper<Size>)? _ovalOffsetToSize;
  final (
    Translator<Size, Offset>,
    Translator<Size, double>
  )? _circleOffsetToRadius;

  Rect rectFrom(BuildContext context) {
    final mediaSize = context.mediaSize;

    return switch (_variation) {
      _RectVariation.zero => Rect.zero,

      // zero to fullSize
      _RectVariation.rectZeroToFull => Offset.zero & mediaSize,
      _RectVariation.circleZeroToFull =>
        RectExtension.fromCircle(Offset.zero, mediaSize.diagonal),
      _RectVariation.ovalZeroToFull =>
        RectExtension.fromCenterSize(Offset.zero, mediaSize),

      // zero to ...
      _RectVariation.rectZeroToSize =>
        Offset.zero & _rectZeroToSize!(mediaSize),
      _RectVariation.circleZeroToRadius => RectExtension.fromCircle(
          Offset.zero,
          _circleZeroToRadius!(mediaSize),
        ),
      _RectVariation.ovalZeroToSize => RectExtension.fromCenterSize(
          Offset.zero,
          _ovalZeroToSize!(mediaSize),
        ),

      // ... to ...
      _RectVariation.rectOffsetToSize =>
        _rectOffsetToSize!.$1(mediaSize) & _rectOffsetToSize!.$2(mediaSize),
      _RectVariation.circleOffsetToRadius => RectExtension.fromCircle(
          _circleOffsetToRadius!.$1(mediaSize),
          _circleOffsetToRadius!.$2(mediaSize),
        ),
      _RectVariation.ovalOffsetToSize => RectExtension.fromCenterSize(
          _ovalOffsetToSize!.$1(mediaSize),
          _ovalOffsetToSize!.$2(mediaSize),
        ),
    };
  }

  const RectSetup._(this._variation)
      : _rectZeroToSize = null,
        _ovalZeroToSize = null,
        _circleZeroToRadius = null,
        _rectOffsetToSize = null,
        _ovalOffsetToSize = null,
        _circleOffsetToRadius = null;

  static const RectSetup zero = RectSetup._(_RectVariation.zero);
  static const RectSetup rectZeroToFull =
      RectSetup._(_RectVariation.rectZeroToFull);
  static const RectSetup ovalZeroToFull =
      RectSetup._(_RectVariation.ovalZeroToFull);
  static const RectSetup circleZeroToFull =
      RectSetup._(_RectVariation.circleZeroToFull);

  const RectSetup.rectZeroToSize(Mapper<Size> this._rectZeroToSize)
      : _variation = _RectVariation.rectZeroToSize,
        _ovalZeroToSize = null,
        _circleZeroToRadius = null,
        _rectOffsetToSize = null,
        _ovalOffsetToSize = null,
        _circleOffsetToRadius = null;

  const RectSetup.rectOffsetToSize(
    (Translator<Size, Offset>, Mapper<Size>) this._rectOffsetToSize,
  )   : _variation = _RectVariation.rectOffsetToSize,
        _rectZeroToSize = null,
        _ovalZeroToSize = null,
        _circleZeroToRadius = null,
        _ovalOffsetToSize = null,
        _circleOffsetToRadius = null;

  const RectSetup.circleZeroToRadius(
      Translator<Size, double> this._circleZeroToRadius)
      : _variation = _RectVariation.circleZeroToRadius,
        _rectZeroToSize = null,
        _ovalZeroToSize = null,
        _rectOffsetToSize = null,
        _ovalOffsetToSize = null,
        _circleOffsetToRadius = null;

  const RectSetup.circleOffsetToRadius(
    (
      Translator<Size, Offset>,
      Translator<Size, double>
    ) this._circleOffsetToRadius,
  )   : _variation = _RectVariation.circleOffsetToRadius,
        _rectZeroToSize = null,
        _ovalZeroToSize = null,
        _circleZeroToRadius = null,
        _rectOffsetToSize = null,
        _ovalOffsetToSize = null;

  const RectSetup.ovalZeroToRadius(Mapper<Size> this._ovalZeroToSize)
      : _variation = _RectVariation.ovalZeroToSize,
        _rectZeroToSize = null,
        _circleZeroToRadius = null,
        _rectOffsetToSize = null,
        _ovalOffsetToSize = null,
        _circleOffsetToRadius = null;

  const RectSetup.ovalOffsetToRadius(
    (Translator<Size, Offset>, Mapper<Size>) this._ovalOffsetToSize,
  )   : _variation = _RectVariation.ovalOffsetToSize,
        _rectZeroToSize = null,
        _ovalZeroToSize = null,
        _circleZeroToRadius = null,
        _rectOffsetToSize = null,
        _circleOffsetToRadius = null;
}
