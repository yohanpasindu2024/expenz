import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldMessangerWidget extends ConsumerStatefulWidget {
  final String message;
  const ScaffoldMessangerWidget({
    super.key,
    required this.message,
  });

  @override
  ConsumerState<ScaffoldMessangerWidget> createState() =>
      _ScaffoldMessangerWidgetState();
}

class _ScaffoldMessangerWidgetState
    extends ConsumerState<ScaffoldMessangerWidget> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.message.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(widget.message)));
      }
    });
    return Container();
  }
}
