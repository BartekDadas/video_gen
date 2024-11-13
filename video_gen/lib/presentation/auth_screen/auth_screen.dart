import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../domain/googleauth/google_auth_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/auth_bloc.dart';
import 'models/auth_model.dart';

// ignore_for_file: must_be_immutable
class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();
  static Widget builder(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthState(
        authModelObj: AuthModel(),
      ))
        ..add(AuthInitialEvent()),
      child: AuthScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgNewScreen1,
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(26.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [_buildWelcomeSection(context)],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(18.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_welcome_back".tr,
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 16.h),
          const Text("Login: test@test.com"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.h),
            child: BlocSelector<AuthBloc, AuthState, TextEditingController?>(
              selector: (state) => login,
              builder: (context, userNameController) {
                return CustomTextFormField(
                  controller: userNameController,
                  hintText: "lbl_username".tr,
                  contentPadding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 10.h),
                  validator: (value) {
                    if (!isText(value)) {
                      return "err_msg_please_enter_valid_text".tr;
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          const Text("Password: test123"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.h),
            child: BlocSelector<AuthBloc, AuthState, TextEditingController?>(
              selector: (state) => password,
              builder: (context, passwordController) {
                return CustomTextFormField(
                  controller: passwordController,
                  hintText: "lbl_password".tr,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.visiblePassword,
                  obscureText: true,
                  contentPadding: EdgeInsets.fromLTRB(8.h, 8.h, 8.h, 10.h),
                  validator: (value) {
                    if (value == null ||
                        (!isValidPassword(value, isRequired: true))) {
                      return "err_msg_please_enter_valid_password".tr;
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
          CustomElevatedButton(
            text: "lbl_log_in".tr,
            margin: EdgeInsets.symmetric(horizontal: 4.h),
            onPressed: () {
              // _formKey.currentState?.validate();
              if (login.text.isNotEmpty && password.text.isNotEmpty) {
                if (login.text != dotenv.env["LOGIN"] ||
                    password.text != dotenv.env['PASSWORD']) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Wrong Authentication Data")));
                } else {
                  context.read<AuthBloc>().add(AuthLoginEvent(
                        login: login.text,
                        password: password.text,
                      ));
                }
              }
            },
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// Navigates to the genScreen when the action is triggered.
  onSuccessGoogleAuthResponse(
    GoogleSignInAccount googleUser,
    BuildContext context,
  ) {
    NavigatorService.popAndPushNamed(
      AppRoutes.genScreen,
    );
  }

  /// Displays a snackBar message when the action is triggered.
  /// The snackbar displays the message `Wrong Authentication Data`.
  onErrorGoogleAuthResponse(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wrong Authentication Data")));
  }
}
