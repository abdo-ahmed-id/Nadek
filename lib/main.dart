import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nadek/data/repository/repository.dart';
import 'package:nadek/data/webservices/WebServices.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/presentation/App_Route.dart';
import 'package:nadek/sheard/constante/cache_hleper.dart';
import 'package:connection_notifier/connection_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp(app_routeing: App_Routeing(),));
  await CacheHelper.init();



}

class MyApp extends StatelessWidget {
  final App_Routeing app_routeing;
  const MyApp({Key? key, required this.app_routeing}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ConnectionNotifier(
      child:BlocProvider(
          create:(context) => NadekCubit(repository(Web_Services())),
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'Schyler'
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: app_routeing.create_app_route,

        ),
      ),
    );


  }

}
