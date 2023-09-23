import 'package:flutter/material.dart';
import 'package:nadek/data/repository/repository.dart';
import 'package:nadek/data/webservices/WebServices.dart';
import 'package:nadek/logic/cubit/nadek_cubit.dart';
import 'package:nadek/presentation/screen/BestUsers.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Groups/AddUser.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Groups/Chats.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Groups/create_group.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Shopping/cart.dart';
import 'package:nadek/presentation/screen/BottombarScreen/Shopping/show_item.dart';
import 'package:nadek/presentation/screen/FollowMe.dart';
import 'package:nadek/presentation/screen/Home.dart';
import 'package:nadek/presentation/screen/Maps.dart';
import 'package:nadek/presentation/screen/Profile.dart';
import 'package:nadek/presentation/screen/ProfileOfUser.dart';
import 'package:nadek/presentation/screen/Splach_Screen.dart';
import 'package:nadek/presentation/screen/SportsSelection/sports_selection.dart';
import 'package:nadek/presentation/screen/Update_Account.dart';
import 'package:nadek/presentation/screen/Upload_Video.dart';
import 'package:nadek/presentation/screen/login/create_account.dart';
import 'package:nadek/presentation/screen/login/login.dart';
import 'package:nadek/presentation/screen/privacy_policy.dart';
import 'package:nadek/presentation/screen/repprt_screen.dart';
import 'package:nadek/presentation/screen/terms_and_conditions.dart';
import 'package:nadek/presentation/screen/viewpager/view_pager_screen.dart';

import 'screen/LiveUserNowPage.dart';
import 'screen/Live_Stream.dart';

class App_Routeing {
  late repository rpo;
  late NadekCubit cubit;

  App_Routeing() {
    rpo = repository(Web_Services());
    cubit = NadekCubit(rpo);
  }

  Route? create_app_route(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const splach_screen());
      case '/Home_screen':
        return MaterialPageRoute(builder: (_) => const Home_Screen());
      case '/View_pager':
        return MaterialPageRoute(builder: (_) => view_pager_screen());
      case '/Create_Account':
        return MaterialPageRoute(builder: (_) => const Create_Account());

      case '/login_user':
        return MaterialPageRoute(builder: (_) => const login_user());

      case '/Sports_Selection':
        var data = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => sports_selection(
                  data[0].toString(),
                  data[1].toString(),
                  data[2].toString(),
                  data[3].toString(),
                  data[4].toString(),
                ));
      case '/Live_Stream':
        return MaterialPageRoute(builder: (_) => const Live_Stream());
      case '/Chats':
        var data = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => Chats(
                  chat_name: data[0].toString(),
                  chat_id: data[1],
                  sender: data[2].toString(),
                  id: data[3].toString(),
                  owner: data[4],
                ));
      case '/AddUser':
        var data = settings.arguments as List;
        return MaterialPageRoute(builder: (_) => Add_User(chat_id: data[0]));

      case '/Create_Group':
        return MaterialPageRoute(builder: (_) => const create_group());
      case '/Update_Account':
        return MaterialPageRoute(builder: (_) => const Update_Account());

      case '/Upload_Video':
        return MaterialPageRoute(builder: (_) => const Upload_Video());

      case '/Show_Item':
        var data = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => Show_Item(
                  PID: data[0],
                  url: data[1],
                  title: data[2],
                  description: data[3],
                  price: data[4].toString(),
                ));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => const Cart());
      case '/Profile':
        return MaterialPageRoute(builder: (_) => const ProfileUser());
      case '/Maps':
        return MaterialPageRoute(builder: (_) => const Maps());
      case '/BestUsers':
        return MaterialPageRoute(builder: (_) => const BestUsers());
      case '/LiveUserNow':
        return MaterialPageRoute(builder: (_) => const LiveUserNow());

      case '/privacy_policy':
        return MaterialPageRoute(builder: (_) => const privacy_policy());
      case '/termsAndConditions':
        return MaterialPageRoute(builder: (_) => const terms_and_conditions());
      case '/ProfileOfUser':
        var data = settings.arguments as List;

        return MaterialPageRoute(
            builder: (_) => ProfileOfUser(user_id: data[0]));
      case '/FollowMe':
        return MaterialPageRoute(builder: (_) => const FollowMe());
      case '/report':
        return MaterialPageRoute(
            builder: (_) => repprt_screen(title: 'ابلاغ عن محتوي'));
    }
    return null;
  }
}
