import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortoba_task/bussiness_logic/register/register_cubit.dart';
import 'package:kortoba_task/constant/strings.dart';
import 'package:sizer/sizer.dart';

import '../../constant/colors.dart';
import '../../constant/style.dart';
import '../widgets/loading_indecator.dart';
import '../widgets/text_button.dart';
import '../widgets/text_form_filed.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController vPassword = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterLoading){
            LoadingScreen.show(context);
          }if(state is RegisterError){
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }if(state is CreateSuccess){
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(context, home, (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: backgroundColor,
              centerTitle: true,
              title: Text(
                'إنشاء حساب',
                style: headerStyle,
              ),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: textFieldColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        'البريد الالكتروني',
                        style: textFieldStyle,
                      ),
                      SizedBox(height: 1.h),
                      MyTextFormFieldWidget(
                        controller: email,
                        style:
                            const TextStyle(fontSize: 23, color: Colors.grey),
                        type: TextInputType.name,
                        validation: (v) {
                          if (v == '') {
                            return 'برجاء ادخال البريد الالكترونى';
                          }
                          return null;
                        },
                        color: fieldColor,
                        isPass: false,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'كلمة المرور',
                        style: textFieldStyle,
                      ),
                      SizedBox(height: 1.h),
                      MyTextFormFieldWidget(
                        controller: password,
                        style:
                        const TextStyle(fontSize: 23, color: Colors.grey),
                        type: TextInputType.name,
                        validation: (v) {
                          if (v == '') {
                            return 'برجاء ادخال كلمة السر';
                          }
                          return null;
                        },
                        icon: IconButton(
                          onPressed: () {
                            BlocProvider.of<RegisterCubit>(context)
                                .changePasswordVisibility();
                          },
                          icon: BlocProvider.of<RegisterCubit>(context)
                              .suffix,
                        ),
                        color: fieldColor,
                        isPass: BlocProvider.of<RegisterCubit>(context)
                            .isPassword,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'تأكيد كلمة المرور',
                        style: textFieldStyle,
                      ),
                      SizedBox(height: 1.h),
                      MyTextFormFieldWidget(
                        controller: password,
                        style:
                        const TextStyle(fontSize: 23, color: Colors.grey),
                        type: TextInputType.name,
                        validation: (v) {
                          if (v == '') {
                            return 'برجاء ادخال كلمة السر';
                          }
                          return null;
                        },
                        icon: IconButton(
                          onPressed: () {
                            BlocProvider.of<RegisterCubit>(context)
                                .changePasswordVisibility();
                          },
                          icon: BlocProvider.of<RegisterCubit>(context)
                              .suffix,
                        ),
                        color: fieldColor,
                        isPass: BlocProvider.of<RegisterCubit>(context)
                            .isPassword,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'الاسم الأول',
                        style: textFieldStyle,
                      ),
                      SizedBox(height: 1.h),
                      MyTextFormFieldWidget(
                        controller: fName,
                        style:
                            const TextStyle(fontSize: 23, color: Colors.grey),
                        type: TextInputType.name,
                        validation: (v) {
                          if (v == '') {
                            return 'برجاء ادخال الاسم الأول';
                          }
                          return null;
                        },
                        color: fieldColor,
                        isPass: false,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'الاسم الأخير',
                        style: textFieldStyle,
                      ),
                      SizedBox(height: 1.h),
                      MyTextFormFieldWidget(
                        controller: lName,
                        style:
                            const TextStyle(fontSize: 23, color: Colors.grey),
                        type: TextInputType.name,
                        validation: (v) {
                          if (v == '') {
                            return 'برجاء ادخال الاسم الأخير';
                          }
                          return null;
                        },
                        color: fieldColor,
                        isPass: false,
                      ),
                      SizedBox(height: 4.h),
                      MyButtonWidget(
                          btnTxt: 'إنشاء حساب',
                          btnWidth: 100.w,
                          btnHeight: 6.h,
                          onPressed: () => _validate(context),
                          color: buttonColor,
                          borderColor: buttonColor,
                          weight: FontWeight.w600,
                          textSize: 14.sp,
                          textColor: whiteColor),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _validate(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      // Navigator.pop(context);
      BlocProvider.of<RegisterCubit>(context).userRegister(
          email.text, password.text, vPassword.text, fName.text, lName.text);
    }
  }
}
