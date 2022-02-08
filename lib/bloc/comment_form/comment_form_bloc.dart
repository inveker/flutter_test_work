import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test_work/api/api_jsonplaceholder.dart';
import 'package:flutter_test_work/utils/nullable.dart';

part 'comment_form_event.dart';

part 'comment_form_state.dart';

class CommentFormBloc extends Bloc<CommentFormEvent, CommentFormState> {
  final int postId;

  CommentFormBloc({
    required this.postId,
  }) : super(CommentFormState()) {
    on<CommentFormNameChanged>(_changeName);
    on<CommentFormEmailChanged>(_changeEmail);
    on<CommentFormBodyChanged>(_changeBody);
    on<CommentFormSubmitted>(_submit);
    on<CommentFormReset>(_reset);
  }

  String? _nameValidation(String value) {
    if (value.isEmpty) return 'Field is required';
  }

  String? _emailValidation(String value) {
    if (value.isEmpty) return 'Field is required';
    if (!value.contains('@')) return 'Wrong email address';
  }

  String? _bodyValidation(String value) {
    if (value.isEmpty) return 'Field is required';
    if (value.length > 200) return 'Max comment length = 200';
  }

  void _changeName(CommentFormNameChanged event, Emitter<CommentFormState> emit) {
    final name = event.value;
    emit(state.copyWith(
      name: name,
      nameError: state.isSent ? Nullable(_nameValidation(name)) : null,
    ));
  }

  void _changeEmail(CommentFormEmailChanged event, Emitter<CommentFormState> emit) {
    final email = event.value;
    emit(state.copyWith(
      email: email,
      emailError: state.isSent ? Nullable(_emailValidation(email)) : null,
    ));
  }

  void _changeBody(CommentFormBodyChanged event, Emitter<CommentFormState> emit) {
    final body = event.value;
    emit(state.copyWith(
      body: body,
      bodyError: state.isSent ? Nullable(_bodyValidation(body)) : null,
    ));
  }

  Future<void> _submit(CommentFormSubmitted event, Emitter<CommentFormState> emit) async {
    final nameError = _nameValidation(state.name);
    final emailError = _emailValidation(state.email);
    final bodyError = _bodyValidation(state.body);

    var newState = state.copyWith(
      status: CommentFormStateStatus.sent,
      nameError: Nullable(nameError),
      emailError: Nullable(emailError),
      bodyError: Nullable(bodyError),
    );
    emit(newState);

    print([nameError, emailError, bodyError].every((i) => i == null));

    if ([nameError, emailError, bodyError].every((i) => i == null)) {
      try {
        emit(newState.copyWith(
          status: CommentFormStateStatus.loading,
        ));
        var comment = await ApiJsonPlaceholder.createComment(
          postId: postId,
          name: newState.name,
          email: newState.email,
          body: newState.body,
        );
        emit(newState.copyWith(
          status: CommentFormStateStatus.success,
        ));
      } catch (e) {
        print(e);
        emit(newState.copyWith(
          status: CommentFormStateStatus.sent,
        ));
      }
    }
  }

  void _reset(CommentFormReset event, Emitter<CommentFormState> emit) {
    emit(CommentFormState());
  }
}
