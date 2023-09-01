

///
/// TODO: in my application, the basic unit of logic is a "love"
///
sealed class Love {
  final double value;
  const Love(this.value);
}

class UserDefinedLove extends Love {
  const UserDefinedLove(super.value);
}