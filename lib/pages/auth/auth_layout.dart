import 'package:app2/common/loading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final String errorMessage;
  final Widget actionButton;
  final String header;
  final String description;
  final List<Widget> inputFields;
  final List<Widget> extra;
  final Widget footer;
  final String title;

  AuthContainer(
      {super.key,
      String? title,
      required this.header,
      required this.description,
      required this.errorMessage,
      AuthActionButton? actionButton,
      required this.inputFields,
      Widget? footer,
      List<Widget>? extra})
      : extra = extra ?? [],
        footer = footer ?? Container(),
        actionButton = actionButton ?? Container(),
        title = title ?? "";

  @override
  Widget build(BuildContext context) {
    List<Widget> spacedInputFields = [];

    for (Widget widget in inputFields) {
      spacedInputFields.add(widget);
      spacedInputFields.add(const SizedBox(height: 10));
    }

    spacedInputFields.removeLast();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(header: header, description: description),
                  const SizedBox(height: 20),
                  ...spacedInputFields,
                  const SizedBox(height: 20),
                  _ErrorMessage(error: errorMessage),
                  const SizedBox(height: 20),
                  actionButton,
                  ...extra,
                ])),
        const Spacer(),
        footer,
      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String header;
  final String description;

  const _Title({super.key, required this.header, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        header,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 5),
      Text(description, textAlign: TextAlign.center)
    ]);
  }
}

class _ErrorMessage extends StatelessWidget {
  final String error;

  const _ErrorMessage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Text(error,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.red));
  }
}

class AuthActionButton extends StatelessWidget {
  final bool loading;
  final bool disabled;
  final Function action;
  final String text;

  const AuthActionButton(
      {required this.text,
      required this.loading,
      required this.disabled,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: !disabled
            ? Theme.of(context).textButtonTheme.style?.copyWith(
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red))
            : Theme.of(context).textButtonTheme.style?.copyWith(
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
        onPressed: disabled
            ? null
            : () async {
                await action();
              },
        child: loading ? const LoadingActionIcon() : Text(text));
  }
}

class AuthFooter extends StatelessWidget {
  final String actionText;
  final String leadingText;
  final String route;

  const AuthFooter(
      {super.key,
      required this.leadingText,
      required this.actionText,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        color: const Color.fromARGB(255, 251, 251, 251),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(color: Colors.black),
            text: leadingText,
            children: <TextSpan>[
              TextSpan(
                  text: ' $actionText',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, route);
                    },
                  style: const TextStyle(color: Colors.red)),
            ],
          ),
        ));
  }
}
