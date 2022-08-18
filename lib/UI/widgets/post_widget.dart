import 'package:flutter/material.dart';
import 'package:kortoba_task/constant/colors.dart';
import 'package:sizer/sizer.dart';
import '../../constant/style.dart';
import '../../models/post_model.dart';


Widget postWidget(BuildContext context, PostModel post){
  return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    'assets/images/p.jpg',
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.share,color: lineColor,),
                    Icon(Icons.bookmark,color: lineColor,),
                    Icon(Icons.thumb_up_alt_rounded,color: lineColor,),
                  ],
                )
              ],
            ),
            SizedBox(height: 1.h,),
            Image.network(post.image!,fit: BoxFit.fill,),
            SizedBox(height: 2.h,),
            Text(post.text!,
            style: headerStyle.copyWith(fontSize: 12.sp),),
            SizedBox(height: 2.h,),
          ],
        ),
      ));
}