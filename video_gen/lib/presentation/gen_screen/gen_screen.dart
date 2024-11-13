import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/gen_bloc.dart';
import 'models/gen_model.dart';

class GenScreen extends StatelessWidget {
  const GenScreen({super.key});

  static Widget builder(BuildContext context) {
    print("Hello");
    return const GenScreen();
  }

  static void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<GenBloc>(
        create: (context) => GenBloc(GenState(
          genModelObj: GenModel(),
        ))
          ..add(GenInitialEvent()),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => callback?.call(),
            child: const Text("Log out"),
          ),
          backgroundColor: appTheme.gray100,
          resizeToAvoidBottomInset: false,
          body: Container(
            // width: double.maxFinite,
            padding: EdgeInsets.all(8.h),
            child: BlocBuilder<GenBloc, GenState>(
              builder: (context, state) {
                callback = () {
                  context.read<GenBloc>().add(LogOutEvent());
                };
                print(state.loading);
                if (state.loading == true) {
                  print("Say hi");
                  final size = MediaQuery.of(context).size;
                  return Container(
                    color: Colors.transparent,
                    width: size.width,
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final textInputController = state.textInputController;
                final url = state.url;
                if (textInputController == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return url.isEmpty
                    ? InputPrompter(
                        textInputController: textInputController,
                        loading: state.loading,
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await launchUrlString(url);
                            },
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 24,
                                  decoration: TextDecoration.underline,
                                ),
                                text: url,
                                // """https://img.recraft.ai/TH4CG_8z2Ql8G1B_mx9tkVQk67i6TmdM9Av13L2-ERE/rs:fit:1024:1024:0/raw:1/plain/abs:/
// /prod/images/a9f881cb-7638-4fa8-88d2-cc65dbfd0375""",
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          InputPrompter(
                            textInputController: textInputController,
                            loading: state.loading,
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class InputPrompter extends StatelessWidget {
  const InputPrompter({
    required this.textInputController,
    required this.loading,
    super.key,
  });
  final TextEditingController textInputController;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenBloc, GenState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              controller: textInputController,
              hintText: "msg_enter_text_here".tr,
              textInputAction: TextInputAction.done,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8.h,
                vertical: 14.h,
              ),
              borderDecoration: TextFormFieldStyleHelper.outlineGrayTL24,
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              isDisabled: loading,
              onPressed: state.loading
                  ? null
                  : () => textInputController.text.isNotEmpty
                      ? context.read<GenBloc>().add(GenerateEvent(
                            prompt: textInputController.text,
                          ))
                      : null,
              height: 44.h,
              text: "lbl_generate".tr,
              buttonStyle: CustomButtonStyles.fillPrimaryTL22.copyWith(
                backgroundColor: WidgetStatePropertyAll(
                    !loading ? Colors.orange : Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
