import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/themes/app_color.dart';
import '../config/themes/app_fonts.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isSecret;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color? bgColor;
  final TextInputType inputType;

  const InputTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isSecret = false,
    this.suffixIcon,
    this.bgColor = AppColor.grey,
    this.obscureText = false, // Fixed typo and default value syntax
    this.inputType = TextInputType.text,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool __isSecret = false;
  @override
  initState() {
    __isSecret = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: AppFonts.body
              .copyWith(fontWeight: FontWeight.w600, color: AppColor.black),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: widget.controller,
          obscureText: __isSecret,
          keyboardType: widget.inputType,
          obscuringCharacter: '*',
          style: AppFonts.caption
              .copyWith(fontWeight: FontWeight.w600, color: AppColor.black),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppFonts.caption
                .copyWith(fontWeight: FontWeight.w400, color: AppColor.grey),
            filled: true, // Background fill
            fillColor: AppColor.grey.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r), // Rounded corners
              borderSide: BorderSide.none, // No border line
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[100]!),
            ),
            suffixIcon: widget.isSecret == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        __isSecret = !__isSecret;
                      });
                    },
                    child: __isSecret
                        ? const Icon(
                            Icons.visibility_off,
                            color: AppColor.grey,
                          )
                        : const Icon(
                            Icons.visibility,
                            color: AppColor.grey,
                          ),
                  )
                : widget.suffixIcon,
          ),
        ),
      ],
    );
  }
}

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isSecret;
  final bool obscureText;
  final Widget? suffixIcon;
  final Color? bgColor;
  final TextInputType inputType;

  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isSecret = false,
    this.suffixIcon,
    this.bgColor = AppColor.grey,
    this.obscureText = false, // Fixed typo and default value syntax
    this.inputType = TextInputType.text,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool __isSecret = false;
  @override
  initState() {
    __isSecret = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: __isSecret,
      keyboardType: widget.inputType,
      obscuringCharacter: '*',
      style: AppFonts.caption
          .copyWith(fontWeight: FontWeight.w600, color: AppColor.black),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppFonts.caption
            .copyWith(fontWeight: FontWeight.w400, color: AppColor.grey),
        filled: true, // Background fill
        fillColor: AppColor.grey.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r), // Rounded corners
          borderSide: BorderSide.none, // No border line
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[100]!),
        ),
        suffixIcon: widget.isSecret == true
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    __isSecret = !__isSecret;
                  });
                },
                child: __isSecret
                    ? const Icon(
                        Icons.visibility_off,
                        color: AppColor.grey,
                      )
                    : const Icon(
                        Icons.visibility,
                        color: AppColor.grey,
                      ),
              )
            : widget.suffixIcon,
      ),
    );
  }
}

