import 'dart:io';

import 'package:ewallet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String formatCurrency(num number, {String symbol = 'Rp '}) {
  return NumberFormat.currency(locale: 'id', symbol: symbol, decimalDigits: 0)
      .format(number);
}

Future<File?> selectImageGalery() async {
  var resultGambar = await FilePicker.platform.pickFiles(type: FileType.image);
  File imageFile = File(resultGambar!.files.single.path.toString());

  return imageFile;
}
