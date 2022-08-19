import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kortoba_task/UI/widgets/drawer.dart';
import 'package:kortoba_task/UI/widgets/post_widget.dart';
import 'package:kortoba_task/bussiness_logic/register/register_cubit.dart';
import 'package:kortoba_task/constant/colors.dart';
import 'package:kortoba_task/constant/style.dart';
import 'package:sizer/sizer.dart';

import '../../constant/global_variables.dart';
import '../widgets/loading_indecator.dart';
import '../widgets/text_button.dart';
import '../widgets/text_form_filed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key,this.acc}) : super(key: key);

  final acc;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController text = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<RegisterCubit>(context).getUserData(prefs.getString('token')!);
    BlocProvider.of<RegisterCubit>(context).getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
              initialIndex: widget.acc == true ? 1 : 0,
              length: 2,
              child: Scaffold(
                backgroundColor: whiteColor,
                floatingActionButton: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20),
                      child: InkWell(
                        onTap: () => addPostDialog(context),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: buttonColor, shape: BoxShape.circle),
                          width: 14.w,
                          height: 7.h,
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                appBar: AppBar(
                  backgroundColor: textColor,
                  title: Text(
                    'الرئيسية',
                    style: headerStyle.copyWith(color: Colors.white),
                  ),
                  bottom: TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    tabs: <Widget>[
                      Tab(
                        child: Text(
                          'الرئيسية',
                          style: headerStyle.copyWith(color: Colors.white),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'حسابي',
                          style: headerStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    ConditionalBuilder(
                      condition: BlocProvider.of<RegisterCubit>(context).posts.isNotEmpty,
                      builder: (context){
                        var posts = BlocProvider.of<RegisterCubit>(context).posts;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 18),
                          child: ListView.separated(
                            itemCount: posts.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return postWidget(context,posts[index]);
                            },
                            separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                            shrinkWrap: true,
                          ),
                        );
                      },
                      fallback: (context) => const Center(child: CircularProgressIndicator()),
                    ),
                    profile()
                  ],
                ),
                drawer: drawer(context),
              )),
        );
      },
    );
  }

  Widget profile() {
    return SingleChildScrollView(
      child: ConditionalBuilder(
        condition: BlocProvider.of<RegisterCubit>(context).userModel != null,
        builder: (context) {
          var model = BlocProvider.of<RegisterCubit>(context).userModel;
          return SizedBox(
            child: Column(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 46.h,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/Rectangle 3.png',
                        width: 100.w,
                        height: 30.h,
                        fit: BoxFit.fill,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Center(
                          child: Container(
                              width: 53.w,
                              height: 30.h,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/images/Ellipse 1.png',
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${model!.fName!} ${model.lName!}',
                  style: headerStyle.copyWith(fontSize: 12.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  model.email!,
                  style:
                      textFieldStyle.copyWith(fontSize: 10.sp, color: fieldColor),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                                color: buttonColor, shape: BoxShape.circle),
                            width: 14.w,
                            height: 7.h,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'تعديل بياناتي',
                          style: headerStyle.copyWith(fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                                color: buttonColor, shape: BoxShape.circle),
                            width: 14.w,
                            height: 7.h,
                            child: const Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'الإعدادات',
                          style: headerStyle.copyWith(fontSize: 10.sp),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                                color: buttonColor, shape: BoxShape.circle),
                            width: 14.w,
                            height: 7.h,
                            child: const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'المفضلة',
                          style: headerStyle.copyWith(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        },
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void addPostDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              elevation: 2,
              backgroundColor: Colors.white,
              content: BlocProvider(
                create: (context) => RegisterCubit(),
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if(state is NewPostLoading){
                      LoadingScreen.show(context);
                    }
                    if(state is NewPostSuccess){
                      Navigator.pop(context);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post Uploaded')),
                      );
                    }
                    if(state is NewPostError){
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    var image = BlocProvider.of<RegisterCubit>(context).image;
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: SizedBox(
                        height: 44.h,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () =>
                                    BlocProvider.of<RegisterCubit>(context)
                                        .pickImage(),
                                child: SizedBox(
                                  height: 20.h,
                                  width: 100.w,
                                  child: image == null
                                      ? Image.asset(
                                          'assets/images/drag-drop-upload-1.png',
                                          fit: BoxFit.fill,
                                        )
                                      : Image.file(image),
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                'اكتب تعليقا حول الصورة',
                                style: textFieldStyle.copyWith(
                                    fontSize: 10.sp, color: fieldColor),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 90.w,
                                child: MyTextFormFieldWidget(
                                  controller: text,
                                  type: TextInputType.multiline,
                                  min: 5,
                                  isPass: false,
                                  color: Colors.white,
                                  hint: 'اكتب تعليقا حول الصورة',
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyButtonWidget(
                                      btnTxt: 'تجاهل',
                                      btnWidth: 15.w,
                                      btnHeight: 5.h,
                                      onPressed: () => Navigator.pop(context),
                                      color: Colors.white,
                                      borderColor: Colors.white,
                                      weight: FontWeight.w600,
                                      textSize: 10.sp,
                                      textColor: buttonColor),
                                  MyButtonWidget(
                                      btnTxt: 'نشر',
                                      btnWidth: 15.w,
                                      btnHeight: 5.h,
                                      onPressed: () => BlocProvider.of<
                                              RegisterCubit>(context)
                                          .createNewPost(text.text),
                                      color: buttonColor,
                                      borderColor: buttonColor,
                                      weight: FontWeight.w600,
                                      textSize: 10.sp,
                                      textColor: whiteColor),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ));
  }

  Widget buildImagePicker({File? image}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: image != null
                ? Image.file(
                    image,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  )
                : Container(),
          ),
        ),
        Positioned(
          right: 4.0,
          top: 0.0,
          child: InkWell(
            onTap: () {},
            child: Material(
                color: buttonColor,
                shape: const CircleBorder(),
                child: image != null
                    ? const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      )
                    : Container()),
          ),
        ),
      ],
    );
  }
}
