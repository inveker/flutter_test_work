import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comment_form_event.dart';
part 'comment_form_state.dart';

class CommentFormBloc extends Bloc<CommentFormEvent, CommentFormState> {
  CommentFormBloc() : super(CommentFormState()) {
    on<CommentFormNameChanged>(_changeName);
    on<CommentFormEmailChanged>(_changeEmail);
    on<CommentFormBodyChanged>(_changeBody);
    on<CommentFormSubmitted>(_submit);
  }

  String? _nameValidation(String value) {
    if(value.isEmpty) return 'Field is required';
  }

  String? _emailValidation(String value) {
    if(value.isEmpty) return 'Field is required';
    if(!value.contains('@')) return 'Wrong email address';
  }

  String? _bodyValidation(String value) {
    if(value.isEmpty) return 'Field is required';
    if(!value.contains('@')) return 'Wrong email address';
  }

  void _changeName(CommentFormNameChanged event, Emitter<CommentFormState> emit) {
    final name = event.value;
    emit(state.copyWith(
      name: name,
      nameError: _nameValidation(name),
    ));
  }

  void _changeEmail(CommentFormEmailChanged event, Emitter<CommentFormState> emit) {
    final email = event.value;
    emit(state.copyWith(
      email: email,
      nameError: _emailValidation(email),
    ));
  }

  void _changeBody(CommentFormBodyChanged event, Emitter<CommentFormState> emit) {
    final body = event.value;
    emit(state.copyWith(
      body: body,
      nameError: _bodyValidation(body),
    ));
  }

  void _submit(CommentFormSubmitted event, Emitter<CommentFormState> emit) {
    final nameError = _nameValidation(state.name);
    final emailError = _nameValidation(state.email);
    final bodyError = _nameValidation(state.body);

    var newState = state.copyWith(
      nameError: nameError,
      emailError: emailError,
      bodyError: bodyError,
    );
    emit(newState);

    if([nameError, emailError, bodyError].every((i) => i == null)) {
      //TODO: Submit form
    }
  }
}
