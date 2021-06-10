import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hk_clothes/constants/app_color.dart';

class TextFieldCustom extends StatelessWidget {
  final typeInput;
  final hintText;
  final controllerInput;
  final validate;
  final changePassword;
  const TextFieldCustom(
      {Key key,
      this.hintText,
      this.typeInput,
      this.validate,
      this.changePassword,
      @required this.controllerInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controllerInput,
        keyboardType: typeInput == 0
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        obscureText: typeInput == 0 ? false : true,
        cursorColor: AppColors.app,
        cursorWidth: 3,
        cursorRadius: Radius.circular(10),
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            typeInput == 0 ? Icons.mail : Icons.lock,
            color: AppColors.app,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20),
          hintText: hintText,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: AppColors.app[100],
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: AppColors.app,
              width: 3,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: AppColors.app,
              width: 3,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              color: AppColors.app,
              width: 3,
            ),
          ),
        ),
      ),
    );
  }
}
