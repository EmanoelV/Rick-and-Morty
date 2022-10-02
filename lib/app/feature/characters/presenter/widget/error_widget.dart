import 'package:flutter/material.dart';

import '../../domain/error/error.dart';

class ErrorWidget extends StatelessWidget {
  final Failure error;

  const ErrorWidget(this.error, {super.key});

  @override
  Widget build(BuildContext context) => Text(error.message);
}
