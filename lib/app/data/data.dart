part of app;


sealed class Data {
  const Data();

  ///
  /// [id] ensure every data in the app has only one
  /// [storeId] enable every data can be stored in any store service
  ///
  String get id;

  static const List<String> typeList = [
    //...
  ];
}
