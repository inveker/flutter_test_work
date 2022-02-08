part of 'comment_form_bloc.dart';

abstract class CommentFormEvent {
  const CommentFormEvent();
}

class CommentFormNameChanged extends CommentFormEvent {
  final String value;

  const CommentFormNameChanged(this.value);
}

class CommentFormEmailChanged extends CommentFormEvent {
  final String value;

  const CommentFormEmailChanged(this.value);
}

class CommentFormBodyChanged extends CommentFormEvent {
  final String value;

  const CommentFormBodyChanged(this.value);
}

class CommentFormSubmitted extends CommentFormEvent {
  const CommentFormSubmitted();
}

class CommentFormReset extends CommentFormEvent {
  const CommentFormReset();
}
