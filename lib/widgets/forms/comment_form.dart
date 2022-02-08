import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/bloc/comment_form/comment_form_bloc.dart';
import 'package:provider/provider.dart';

class CommentForm extends StatelessWidget {
  final int postId;
  final CommentFormBloc? bloc;

  const CommentForm({
    Key? key,
    required this.postId,
    this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          bloc ??
          CommentFormBloc(
            postId: postId,
          ),
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: BlocBuilder<CommentFormBloc, CommentFormState>(builder: (context, state) {
          if (state.status == CommentFormStateStatus.success) {
            return _Reset();
          } else {
            return _Form();
          }
        }),
      ),
    );
  }
}

class _Reset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 392.7,
      height: 434,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Success!'),
            ElevatedButton(
              child: const Text('Send new comment'),
              onPressed: () {
                context.read<CommentFormBloc>().add(const CommentFormReset());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(),
        const SizedBox(height: 32),
        _NameInput(),
        const SizedBox(height: 16),
        _EmailInput(),
        const SizedBox(height: 16),
        _BodyInput(),
        const SizedBox(height: 16),
        _SubmitButton(),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Add comment',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 21,
        color: Colors.black54,
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentFormBloc, CommentFormState>(
      buildWhen: (p, n) => p.nameError != n.nameError,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<CommentFormBloc>().add(CommentFormNameChanged(value.trim()));
          },
          decoration: InputDecoration(
            labelText: 'Your name',
            errorText: state.nameError,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentFormBloc, CommentFormState>(
      buildWhen: (p, n) => p.emailError != n.emailError,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<CommentFormBloc>().add(CommentFormEmailChanged(value.trim()));
          },
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.emailError,
          ),
        );
      },
    );
  }
}

class _BodyInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentFormBloc, CommentFormState>(
      buildWhen: (p, n) => p.bodyError != n.bodyError,
      builder: (context, state) {
        return TextField(
          onChanged: (value) {
            context.read<CommentFormBloc>().add(CommentFormBodyChanged(value.trim()));
          },
          decoration: InputDecoration(
            labelText: 'Commentary',
            errorText: state.bodyError,
          ),
          maxLines: null,
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Send'),
      onPressed: () {
        context.read<CommentFormBloc>().add(const CommentFormSubmitted());
      },
    );
  }
}
