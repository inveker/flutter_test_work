part of 'comment_form_bloc.dart';

enum CommentFormStateStatus {
  initial,
  sent,
  loading,
  success
}

class CommentFormState extends Equatable {
  final String name;
  final String? nameError;
  final String email;
  final String? emailError;
  final String body;
  final String? bodyError;
  final CommentFormStateStatus status;

  CommentFormState({
    this.name = '',
    this.nameError,
    this.email = '',
    this.emailError,
    this.body = '',
    this.bodyError,
    this.status = CommentFormStateStatus.initial,
  });

  CommentFormState copyWith({
    String? name,
    Nullable<String>? nameError,
    String? email,
    Nullable<String>? emailError,
    String? body,
    Nullable<String>? bodyError,
    CommentFormStateStatus? status,
  }) {
    return CommentFormState(
      name: name ?? this.name,
      nameError: nameError != null ? nameError.value : this.nameError,
      email: email ?? this.email,
      emailError: emailError != null ? emailError.value : this.emailError,
      body: body ?? this.body,
      bodyError: bodyError != null ? bodyError.value : this.bodyError,
      status: status ?? this.status,
    );
  }

  bool get isSent => status == CommentFormStateStatus.sent;

  @override
  List<Object?> get props {
    return [
      name,
      nameError,
      email,
      emailError,
      body,
      bodyError,
      status,
    ];
  }
}
