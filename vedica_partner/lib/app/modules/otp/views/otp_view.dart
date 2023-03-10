import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vedica_partner/app/modules/otp/controllers/otp_controller.dart';
import 'package:vedica_partner/utils/my_colors.dart';
import 'package:vedica_partner/utils/textthem.dart';

class OtpView extends StatelessWidget {
  final authController = Get.put(OtpController());
  final _formKey = GlobalKey<FormState>();

  OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColor.bgcolor,
      body: Stack(children: [
        Obx(() => authController.isOtpSent.value
            ? _buildVerifyOtpForm()
            : _buildGetOtpForm())
      ]),
    );
  }

  Widget _buildGetOtpForm() {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: Texttheme.heading.copyWith(fontSize: 48),
              ),
              const SizedBox(
                height: 180,
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColor.bgcolor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(() => Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          style: TextStyle(
                            color: MyColor.accentWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onChanged: (val) {
                            authController.phoneNo.value = val;
                            authController.showPrefix.value = val.length > 0;
                          },
                          onSaved: (val) => authController.phoneNo.value = val!,
                          validator: (val) => (val!.isEmpty || val.length < 10)
                              ? "Enter valid number"
                              : null,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Phone No.",
                            labelText: "Phone No.",
                            labelStyle: Texttheme.headingTwo,
                            alignLabelWithHint: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: MyColor.accentWhite.withOpacity(0.2)),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: MyColor.accentWhite),
                            ),
                            prefix: authController.showPrefix.value
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      '(+91)',
                                      style: TextStyle(
                                        color: MyColor.accentWhite,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : null,
                            suffixIcon: _buildSuffixIcon(),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form!.validate()) {
                                form.save();
                                authController.getOtp();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              // foregroundColor: Colors.white,
                              backgroundColor: MyColor.yellowColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Get OTP',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 220,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyOtpForm() {
    List<TextEditingController> otpFieldsControler = [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController()
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'OTP',
              style: Texttheme.heading.copyWith(fontSize: 38),
            ),
            const SizedBox(
              height: 180,
            ),
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(
                          first: true,
                          last: false,
                          controller: otpFieldsControler[0]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[1]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[2]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[3]),
                      _textFieldOTP(
                          first: false,
                          last: false,
                          controller: otpFieldsControler[4]),
                      _textFieldOTP(
                          first: false,
                          last: true,
                          controller: otpFieldsControler[5]),
                    ],
                  ),
                  Text(
                    authController.statusMessage.value,
                    style: TextStyle(
                        color: authController.statusMessageColor.value,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        authController.otp.value = "";
                        otpFieldsControler.forEach((controller) {
                          authController.otp.value += controller.text;
                        });
                        authController.verifyOTP();
                      },
                      style: ButtonStyle(
                        // foregroundColor:
                        //     MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          MyColor.yellowColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          'Verify',
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColor.accentWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              "Didn't receive any code?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyColor.accentWhite,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 18,
            ),
            Obx(
              () => TextButton(
                onPressed: () => authController.resendOTP.value
                    ? authController.resendOtp()
                    : null,
                child: Text(
                  authController.resendOTP.value
                      ? "Resend New Code"
                      : "Wait ${authController.resendAfter} seconds",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuffixIcon() {
    return AnimatedOpacity(
        opacity: authController.phoneNo.value.length == 10 ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: const Icon(Icons.check_circle, color: Colors.green, size: 32));
  }

  Widget _textFieldOTP({bool first = true, last, controller}) {
    var height = (Get.width - 82) / 6;
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          autofocus: true,
          controller: controller,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              Get.focusScope?.nextFocus();
            }
            if (value.length == 0 && first == false) {
              Get.focusScope?.previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: height / 2,
            fontWeight: FontWeight.bold,
            color: MyColor.accentWhite,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: MyColor.accentWhite,
                ),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
