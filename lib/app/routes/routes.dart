import 'package:flutter/widgets.dart';

import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../bloc/app_bloc.dart';

/// uygulamanın appstatus state'i AppStatus.authenticated olursa Home Page sayfasına gitsin
/// uygulamanın appstatus state'i AppStatus.unauthenticated olursa Login Page sayfasına gitsin
List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
