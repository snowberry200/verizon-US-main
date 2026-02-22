import 'package:flutter/material.dart';

class NameTextFormWidget extends StatefulWidget {
  final TextEditingController? nameController;

  const NameTextFormWidget({super.key, this.nameController});

  @override
  State<NameTextFormWidget> createState() => NameTextFormWidgetState();
}

class NameTextFormWidgetState extends State<NameTextFormWidget> {
  // Don't create a new controller, just use the one from widget
  TextEditingController get _effectiveController =>
      widget.nameController ?? _fallbackController;

  // Only create a fallback if no controller is provided
  late final TextEditingController _fallbackController;

  @override
  void initState() {
    super.initState();
    // Only create fallback if needed
    if (widget.nameController == null) {
      _fallbackController = TextEditingController();
    }
  }

  @override
  void dispose() {
    // Only dispose if we created the fallback
    if (widget.nameController == null) {
      _fallbackController.dispose();
    }
    super.dispose();
  }

  // Getter to access controller from parent
  TextEditingController get nameController => _effectiveController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (name) {
        if (name == null || name.isEmpty) {
          return 'Name field cannot be empty';
        } else if (name.length < 4) {
          return 'Please enter a correct name (min 4 characters)';
        }
        return null;
      },
      textAlign: TextAlign.start,
      controller: _effectiveController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        border: OutlineInputBorder(borderSide: const BorderSide()),
        labelStyle: const TextStyle(fontSize: 16),
      ),
      keyboardType: TextInputType.name,
      autofillHints: const [AutofillHints.name],
    );
  }
}
