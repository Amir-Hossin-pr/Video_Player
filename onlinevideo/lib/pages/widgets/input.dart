import 'package:flutter/material.dart';

class InputOutline extends StatefulWidget {
  final String hint;
  final String lable;
  final TextInputType inputType;
  final TextEditingController controller;
  final String errorText;
  final int maxLines;
  final bool isRequired;
  final Widget? prefixIcon;
  final bool readOnly;
  final bool clearable;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final Color? hintColor;
  final Color? lableColor;
  final Color? borderColor;
  final Color? fillColor;
  final bool filled;

  const InputOutline({
    super.key,
    required this.controller,
    required this.hint,
    required this.lable,
    required this.maxLines,
    required this.isRequired,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.errorText = '',
    this.readOnly = false,
    this.clearable = false,
    this.inputType = TextInputType.text,
    this.focusNode,
    this.borderColor,
    this.hintColor,
    this.lableColor,
    this.fillColor,
    this.filled = false,
  });

  @override
  State<InputOutline> createState() => _InputOutlineState();
}

class _InputOutlineState extends State<InputOutline> {
  late bool clearableCheck;

  @override
  void initState() {
    super.initState();
    clearableCheck = false;
  }

  @override
  Widget build(BuildContext context) {
    setClearble();
    widget.controller.addListener(() => setClearble());

    return TextFormField(
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: widget.readOnly,
      controller: widget.controller,
      keyboardType: widget.inputType,
      validator: validator,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        filled: widget.filled,
        fillColor: widget.fillColor,
        hintText: widget.hint,
        hintStyle: TextStyle(color: widget.hintColor),
        labelText: widget.lable,
        labelStyle: TextStyle(color: widget.lableColor),
        prefixIcon: widget.prefixIcon,
        suffixIcon: clearableCheck ? suffix() : const SizedBox(),
        focusedBorder: widget.borderColor != null
            ? OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor!),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }

  void setClearble() {
    clearableCheck =
        widget.clearable ? widget.controller.text.isNotEmpty : false;
    setState(() {});
  }

  Widget suffix() => IconButton(
        onPressed: () {
          widget.controller.clear();
        },
        icon: const Icon(Icons.close),
      );

  String? validator(String? value) {
    if (widget.isRequired) {
      return value == null || value.isEmpty ? widget.errorText : null;
    }
    return null;
  }
}
