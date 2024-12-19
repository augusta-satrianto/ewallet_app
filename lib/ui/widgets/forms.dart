import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:tabler_icons/tabler_icons.dart';

class CustomFormField extends StatefulWidget {
  final String title;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitted;
  final bool? isPassword;
  const CustomFormField({
    super.key,
    required this.title,
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
    this.onFieldSubmitted,
    this.isPassword = false,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
          ),
        if (widget.isShowTitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          obscureText: widget.isPassword == true && !isShow,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              suffixIcon: widget.isPassword == true
                  ? IconButton(
                      icon: Icon(
                        isShow ? TablerIcons.eye : TablerIcons.eye_off,
                        color: greyColor,
                      ),
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                    )
                  : null,
              hintText: widget.title,
              hintStyle: greyTextStyle.copyWith(fontSize: 14),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              contentPadding: const EdgeInsets.all(12)),
          onFieldSubmitted: widget.onFieldSubmitted,
        )
      ],
    );
  }
}
