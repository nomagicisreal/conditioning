part of res;

extension _QuerySanpshotUtil<D> on firestore.QuerySnapshot<D> {
  Iterable<D> get _toModels => docs.map((doc) => doc.data());
}

extension _QueryUtil<D> on firestore.Query<D> {
  firestore.Query<D> _filter(FieldsSet fieldsSet) =>
      fieldsSet.keys.fold<firestore.Query<D>>(this, (query, name) {
        final match = fieldsSet[name]!;
        return query.where(
          name,
          isEqualTo: match.equalValue,
          isNotEqualTo: match.notEqualValue,
        );
      });

  Stream<Iterable<D>> get _iterabledataStream =>
      snapshots().map((event) => event._toModels);
}

extension _DocRefUtil<D> on firestore.DocumentReference<D> {
  Stream<Iterable<D?>> get _dataStream => snapshots().map((event) => [event.data()]);
}