import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kortoba_task/models/post_model.dart';
import 'package:kortoba_task/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../constant/global_variables.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  void userRegister(String email, String password, String vPassword,
      String fName, String lName) {
    emit(RegisterLoading());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      createUser(email, fName, lName, value.user!.uid);
    }).catchError((error) {
      emit(RegisterError(error.toString()));
    });
  }

  void createUser(String email, String fName, String lName, String uId) {
    emit(CreateLoading());
    UserModel model = UserModel(
        uId: uId, email: email, fName: fName, lName: lName);
    FirebaseFirestore.instance.collection('users').doc(uId)
        .set(model.toMap())
        .then((value) {
      prefs.setString('token', uId);
      prefs.setBool("ISLOGGED", true);
      emit(CreateSuccess());
    }).catchError((error) {
      emit(CreateError(error.toString()));
    });
  }

  UserModel? userModel;

  void getUserData(String uId) {
    emit(UserDataLoading());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(UserDataSuccess(userModel!));
    }).catchError((e) {
      emit(UserDataError(e));
    });
  }

  List<PostModel> posts =[];

  void getPosts() {
    emit(PostsLoading());
    FirebaseFirestore.instance.collection('posts').snapshots().
    listen((event) {
        posts =[];
        event.docs.forEach((element) {
          posts.add(PostModel.fromJson(element.data()));
        });
        emit(PostsSuccess());
    });
  }

  void userLogin(String email, String password) {
    emit(LoginLoading());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      prefs.setString('token', value.user!.uid);
      prefs.setBool("ISLOGGED", true);
      emit(LoginSuccess());
    }).catchError((error) {
      emit(LoginError(error.toString()));
    });
  }

  File? image;
  var picker = ImagePicker();

  Future<void> pickImage() async {
   final pickedFile = await picker.getImage(source: ImageSource.gallery);
   if(pickedFile != null){
     image = File(pickedFile.path);
     emit(ImageLoaded());
   }else{
     emit(ImageError());
   }
  }

  void createNewPost(String text) {
    emit(NewPostLoading());
    firebase_storage.FirebaseStorage.instance.ref().child('post/${Uri
        .file(image!.path)
        .pathSegments
        .last}').putFile(image!).then((value){
          value.ref.getDownloadURL().then((value) {
            PostModel postModel = PostModel(image: value,text: text);
            FirebaseFirestore.instance.collection('posts').add(postModel.toMap())
                .then((value) {
              emit(NewPostSuccess(postModel));
            }).catchError((error) {
              emit(NewPostError(error.toString()));
            });
            print(value);
          }).catchError((e){
            emit(NewPostError(e.toString()));
          });
    }).catchError((e){
      emit(NewPostError(e.toString()));
    });
  }

  Icon suffix = const Icon(
    Icons.visibility_outlined,
    color: Colors.grey,
  );
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword
        ? const Icon(
      Icons.visibility_outlined,
      color: Colors.grey,
    )
        : const Icon(
      Icons.visibility_off_outlined,
      color: Colors.grey,
    );
    emit(PasswordVisibility());
  }
}
