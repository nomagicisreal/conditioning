part of res;

extension _HiveWatchValue<D extends Data> on hive.Box<D> {
  Stream<D?> _watch(String id) =>
      watch(key: id).map((event) => event.value as D?);
}
