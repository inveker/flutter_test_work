part of 'comment_form_bloc.dart';

class CommentFormState extends Equatable {
  final String name;
  final String nameError;
  final String email;
  final String emailError;
  final String body;
  final String bodyError;

  const CommentFormState({
    this.name = '',
    this.nameError = '',
    this.email = '',
    this.emailError = '',
    this.body = '',
    this.bodyError = '',
  });

  CommentFormState copyWith({
    String? name,
    String? nameError,
    String? email,
    String? emailError,
    String? body,
    String? bodyError,
  }) {
    return CommentFormState(
      name: name ?? this.name,
      nameError: nameError ?? this.name,
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      body: body ?? this.body,
      bodyError: bodyError ?? this.bodyError,
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      nameError,
      email,
      emailError,
      body,
      bodyError,
    ];
  }
}
