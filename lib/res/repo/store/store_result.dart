part of res;

// TODO: replaced with sealed class as kotlin, if someday dart have
enum ResultType {
  instance,
  iterable,
  count,
  propsMap,
}

class Result<D extends Data> {
  final QueryWhere<D> queryWhere;
  final D? instance;
  final Iterable<D?>? iterable;
  final Map<String, Iterable<D>>? propsMap;
  final int? count;

  const Result._({
    required this.queryWhere,
    this.instance,
    this.iterable,
    this.propsMap,
    this.count,
  });

  factory Result.from({
    required QueryWhere<D> queryWhere,
    required Iterable<D?> result,
  }) {
    switch (queryWhere.expectResult) {
      case ResultType.instance:
        return Result._(
          queryWhere: queryWhere,
          instance: result.first,
        );
      case ResultType.iterable:
        return Result._(
          queryWhere: queryWhere,
          iterable: result,
        );
      case ResultType.count:
        return Result._(
          queryWhere: queryWhere,
          count: result.length,
        );
      case ResultType.propsMap:
        throw UnimplementedError();
    }
  }
}
