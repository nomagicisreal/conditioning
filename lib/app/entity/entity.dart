part of data;

///
/// topic, field, board, realm...
///

enum EntityType {
  messagingUser;
}

@immutable
abstract class MessagingUser {
  final String id;
  final String email;
  final String? name;
  const MessagingUser({required this.id, required this.email, this.name});
}