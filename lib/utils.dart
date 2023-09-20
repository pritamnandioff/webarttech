import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toast/toast.dart';
import 'package:web_art_technology/home2.dart';
import 'package:web_art_technology/loading_helper.dart';
import 'package:web_art_technology/login.dart';
import 'package:web_art_technology/otp_screen.dart';
import 'package:web_art_technology/services.dart';

class ControlerServices {
  final box = GetStorage();
  RequestMethod _requestMethod = RequestMethod();
  register(data, context) {
    return _requestMethod
        .apiRequest("/v1/student", METHOD.POST, data, "")
        .then((value) {
      LoadingHelper.showLoading();
      if (value["success"] == 1) {
        print(value["data"]["otp"]);
        // Toast.show(value["data"]["otp"],
        //     duration: Toast.lengthLong, gravity: Toast.top);

        Get.showSnackbar(
          GetSnackBar(
            title: value["data"]["otp"],
            message: 'OTP sent Successfully',
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          ),
        );

        LoadingHelper.hideLoading();
        return Get.to(() => OTPVerify(
            otp: value["data"]["otp"], emailId: value["data"]["emailId"]));
      } else {
        Toast.show("Some thing went wrong",
            duration: Toast.lengthLong, gravity: Toast.top);
      }
      LoadingHelper.hideLoading();
    });
  }

  userCheck() {
    print("hui");
    if (box.read("user_hash_id") == 1) {
      print("hi");
      return Get.to(() => const Home2());
    } else if (box.read("user_hash_id") == null) {
      print("dui");
      return Get.to(() => const MyLogin());
    }
  }

  login(data) {
    return _requestMethod
        .apiRequest("/v1/student/login", METHOD.POST, data, "")
        .then((value) {
      LoadingHelper.showLoading();

      if (value["success"] == 1) {
        Get.showSnackbar(
          const GetSnackBar(
            title: "Successfull login",
            message: 'User loggedin Successfully',
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          ),
        );

        return Get.offAll(() => const Home2());
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: "check credential",
            message: 'Login credential does not match',
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          ),
        );
      }
      LoadingHelper.hideLoading();
    });
  }

  otpverify(data) {
    return _requestMethod
        .apiRequest("/v1/student/opt/verification", METHOD.PATCH, data, "")
        .then((value) {

      LoadingHelper.showLoading();

      if (value["success"] == 1) {
        print(value["success"]);
        box.write("user_hash_id", value["success"]);
        print(box.read("user_hash_id"));
        Get.showSnackbar(
          const GetSnackBar(
            title: "Login Successfull",
            message: 'User Registered Successfully',
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          ),
        );

        return Get.offAll(() => const Home2());
      } else {
        Toast.show(value, duration: Toast.lengthLong, gravity: Toast.top);
      }
      LoadingHelper.hideLoading();
    });
  }

  logout() {
    box.erase();
  }
}
