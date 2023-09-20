import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:web_art_technology/home2.dart';
import 'package:web_art_technology/utils.dart';

class OTPVerify extends StatefulWidget {
  final String otp;
  final String emailId;
  const OTPVerify({super.key, required this.otp, required this.emailId});

  @override
  State<OTPVerify> createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  final ControlerServices _controlerServices = ControlerServices();
  @override
  Widget build(BuildContext context) {
    final TextEditingController otpTextController = TextEditingController();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Enter the code sent to your email"),
          PinCodeTextField(
            controller: otpTextController,
            appContext: context,
            length: 6,
            obscureText: true,
            onChanged: (value) {},
            onCompleted: (value) {
              var data = {
                "emailId": widget.emailId,
                "otp": otpTextController.value.text
              };
              print(data);
              _controlerServices.otpverify(data);
            },
            blinkWhenObscuring: true,
            keyboardType: TextInputType.number,
            autoFocus: true,
          ),
        ],
      ),
    );
  }
}
