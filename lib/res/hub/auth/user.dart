import 'package:flutter/material.dart' show immutable;

@immutable
class AuthUser {
  final String id;

  // final String email;

  const AuthUser({required this.id});
}

@immutable
class AuthEvent {
  final String eventName;
  // final String email;
  final bool eventUiHasA = true;//attendance
  final bool eventUiHasB = true;//bringUp
  final bool eventUiHasC = true;//conduct

  const AuthEvent({required this.eventName});

}

@immutable
class AuthOrg {
  final String orgName;
  // final String email;

  const AuthOrg({required this.orgName});

}