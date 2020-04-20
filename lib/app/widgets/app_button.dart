import 'package:Moview/app/app_color.dart';
import 'package:Moview/app/app_module.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color color;
  final bool fillRow;
  final bool isLoading;
  const AppButton({
    Key key,
    this.text,
    this.textStyle,
    this.onPressed,
    this.padding,
    this.color,
    this.margin,
    this.fillRow = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: fillRow
          ? Row(children: <Widget>[Expanded(child: _containerButton())])
          : _containerButton(),
    );
  }

  AnimatedContainer _containerButton() {
    AppColor appColor = AppModule.to.getDependency();
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: 48.0,
      width: isLoading ? 48 : 102.0,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: color ?? appColor.primary,
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            appColor.primary,
            appColor.input,
          ],
        ),
      ),
      child: isLoading ? _loader() : _button(appColor),
    );
  }

  Widget _loader() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  RawMaterialButton _button(AppColor appColor) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      elevation: 0,
      constraints: BoxConstraints(minHeight: (36.0 + 12.0), minWidth: 102.0),
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: appColor.textButton,
              fontSize: 18,
            ),
      ),
    );
  }
}
