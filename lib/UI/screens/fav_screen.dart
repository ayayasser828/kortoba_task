import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kortoba_task/UI/widgets/drawer.dart';
import 'package:kortoba_task/bussiness_logic/register/register_cubit.dart';

import '../../constant/colors.dart';
import '../../constant/style.dart';
import '../widgets/post_widget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {

  @override
  void initState() {
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
          child: Scaffold(
            backgroundColor: whiteColor,
            drawer: drawer(context),
            appBar: AppBar(
              backgroundColor: textColor,
              title: Text(
                'المحفوظات',
                style: headerStyle.copyWith(color: Colors.white),
              ),
            ),
            body: ConditionalBuilder(
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
          ),
        );
      },
    );
  }
}
