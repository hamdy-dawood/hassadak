import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hassadak/constants/color_manager.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 60,
              child: TextFormField(
                autofocus: true,
                style: GoogleFonts.almarai(
                  textStyle: TextStyle(
                    color: ColorManager.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) => nextField(value, pin2FocusNode),
              ),
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                focusNode: pin2FocusNode,
                style: GoogleFonts.almarai(
                  textStyle: TextStyle(
                    color: ColorManager.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) => nextField(value, pin3FocusNode),
              ),
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                focusNode: pin3FocusNode,
                style: GoogleFonts.almarai(
                  textStyle: TextStyle(
                    color: ColorManager.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) => nextField(value, pin4FocusNode),
              ),
            ),
            SizedBox(
              width: 60,
              child: TextFormField(
                focusNode: pin4FocusNode,
                style: GoogleFonts.almarai(
                  textStyle: TextStyle(
                    color: ColorManager.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: otpInputDecoration,
                onChanged: (value) {
                  if (value.length == 1) {
                    pin4FocusNode!.unfocus();
                    // Then you need to check is the code is correct or not
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final otpInputDecoration = InputDecoration(
  filled: true,
  fillColor: ColorManager.white,
  contentPadding: const EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: focusInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.sp),
    borderSide: BorderSide(
      color: ColorManager.navGrey,
    ),
  );
}

OutlineInputBorder focusInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.sp),
    borderSide: const BorderSide(
      color: Colors.blue,
    ),
  );
}
