
import 'package:firebase_chat_app/app/bloc/app_bloc.dart';
import 'package:firebase_chat_app/app/routes/routes.dart';
import 'package:firebase_chat_app/repository/authentication_repository/src/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      /// RepositoryProvider.value Flutter için provider paketi tarafından sağlanan bir widget'dir. 
      /// Bu widget, bir Repository nesnesini mevcut widget ağacındaki alt widgetlere geçirir ve bir değer sağlayıcısı olarak işlev görür.
      /// RepositoryProvider.value widget'i, bağımlılık enjeksiyonu (dependency injection) yapmak için kullanılır.
      /// Veri deposu (repository) bir kez oluşturulur ve daha sonra bu nesne, uygulamanın farklı yerlerindeki widget'lar tarafından kullanılabilir hale getirilir.
      /// Bu, uygulamanın daha az bellek kullanmasına ve daha düşük bağımlılıkla daha yeniden kullanılabilir bir kod oluşturmasına yardımcı olur.   
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: FlowBuilder<AppStatus>( // uyguulamanın state değişimine göre sayfayı build eder
        state: context.select((AppBloc bloc) => bloc.state.status), // her state değiştiğinde gezinme rotası(açılan sayfa) değişir
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
