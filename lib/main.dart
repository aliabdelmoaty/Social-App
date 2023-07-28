import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
// ignore: duplicate_import
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/layout.dart';
import 'package:social/models/login/loginScreen.dart';
import 'package:social/shared/blocObserver.dart';
import 'package:social/shared/constants.dart';
import 'package:social/shared/network/local/cache_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background ${message.data.toString()}');
  Fluttertoast.showToast(
      msg: 'on background ${message.data.toString()}',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp${event.data.toString()}');
    Fluttertoast.showToast(
        msg: 'onMessageOpenedApp${event.data.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  });
  FirebaseMessaging.onMessage.listen((event) {
    print('onMessage${event.data.toString()}');
    Fluttertoast.showToast(
        msg: 'onMessage${event.data.toString()}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget? widget;
  uId = CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = const LayoutScreen();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getPosts()
        ..getAllUsers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: startWidget,
      ),
    );
  }
}
