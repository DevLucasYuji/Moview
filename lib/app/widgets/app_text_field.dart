import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:Moview/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final String errorLabel;
  final TextInputType inputType;
  final bool obscureText;
  final EdgeInsetsGeometry padding;
  final IconData icon;
  final Function onSuffixPressed;
  final Function(String) validator;
  final TextEditingController controller;

  const AppTextField({
    Key key,
    this.hintText,
    this.inputType,
    this.obscureText,
    this.padding,
    this.icon,
    this.onSuffixPressed,
    this.validator,
    this.errorLabel,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppColor color = AppModule.to.getDependency();
    S translator = AppModule.to.getDependency();
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (value) =>
                value.isEmpty ? errorLabel ?? translator.emptyField : null,
        obscureText: obscureText ?? false,
        keyboardType: inputType,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 20.0,
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          filled: true,
          suffixStyle: TextStyle(color: Colors.red),
          suffixIcon: obscureText != null
              ? IconButton(
                  icon: FaIcon(
                    obscureText
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeSlash,
                    color: Colors.grey[500],
                    size: 20,
                  ),
                  highlightColor: Colors.transparent,
                  onPressed: onSuffixPressed,
                )
              : null,
          hintText: hintText,
          contentPadding: EdgeInsets.only(top: 16, bottom: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          hintStyle: TextStyle(
            color: Colors.grey[500],
            decoration: TextDecoration.none,
          ),
          fillColor: color.input,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color.secondary),
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color.input),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
