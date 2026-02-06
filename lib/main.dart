import 'package:braille_app/components/fase.dart';
import 'package:braille_app/models/historico.dart';
import 'package:braille_app/services/historico_list.dart';
import 'package:braille_app/services/information_1.dart';
import 'package:braille_app/services/topico.dart';
import 'package:braille_app/models/user_data.dart';
import 'package:braille_app/screens/acertos_screen.dart';
import 'package:braille_app/screens/auth_screen.dart';
import 'package:braille_app/screens/fase2_screen.dart';
import 'package:braille_app/screens/forgot_password.dart';
import 'package:braille_app/screens/historico_screen.dart';
import 'package:braille_app/screens/quest_1_screen.dart';
import 'package:braille_app/screens/register_screen.dart';
import 'package:braille_app/screens/about_you_1_screen.dart';
import 'package:braille_app/screens/about_you_2_screen.dart';
import 'package:braille_app/screens/about_you_3_screen.dart';
import 'package:braille_app/screens/account_created_screen.dart';
import 'package:braille_app/screens/login_screen.dart';
import 'package:braille_app/services/auth.dart';
import 'package:braille_app/components/ball.dart';
import 'package:braille_app/models/balls_list.dart';
import 'package:braille_app/services/cells_list.dart';
import 'package:braille_app/models/modulos_list.dart';
import 'package:braille_app/services/graphic.dart';
import 'package:braille_app/services/passer.dart';
import 'package:braille_app/services/fase_service.dart'; 
import 'package:braille_app/screens/fase_screen.dart';
import 'package:braille_app/screens/ready_screen.dart';
import 'package:braille_app/screens/tabs_screen_2.dart';
import 'package:braille_app/screens/testar_screen.dart';
import 'package:braille_app/screens/topic_1_screen.dart';
import 'package:braille_app/screens/topico_1_conteudo_screen.dart';
import 'package:braille_app/screens/users_chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/modulos_screen.dart';
import 'package:braille_app/screens/interface_screen.dart';
import 'package:braille_app/models/modulos.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:braille_app/screens/force_password_update.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
// IMPORT NECESSÁRIO PARA LOCALIZAÇÃO
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // A persistência LOCAL é padrão no Android/iOS, não precisa do setPersistence que trava no mobile
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const BrailleApp());
  });
}

class BrailleApp extends StatelessWidget {
  const BrailleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => ModulosList()),
        ChangeNotifierProvider(create: (_) => BallsList()),
        ChangeNotifierProvider(create: (_) => CellsList()),
        ChangeNotifierProvider(create: (_) => Modulo()),
        ChangeNotifierProvider(create: (_) => Topico()),
        ChangeNotifierProvider(create: (_) => Ball()),
        ChangeNotifierProvider(create: (_) => Graphic()),
        ChangeNotifierProvider(create: (_) => Historico()),
        ChangeNotifierProxyProvider<Auth, HistoricoList>(
          create: (_) => HistoricoList('', ''),
          update: (ctx, auth, _) => HistoricoList(auth.token ?? '', auth.userId ?? ''),
        ),
        ChangeNotifierProxyProvider<Auth, Passer>(
          create: (_) => Passer('', ''),
          update: (ctx, auth, _) => Passer(auth.token ?? '', auth.userId ?? ''),
        ),
        ChangeNotifierProvider(create: (_) => Information1()),
        ChangeNotifierProxyProvider<Auth, UserData>(
          create: (_) => UserData('', ''),
          update: (ctx, auth, _) => UserData(auth.token ?? '', auth.userId ?? ''),
        ),
        ProxyProvider<Auth, FaseService>(
          update: (ctx, auth, _) => FaseService(
            token: auth.token ?? '',
            userId: auth.userId ?? '',
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // --- CONFIGURAÇÃO DE LÍNGUA PORTUGUESA ---
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt', 'BR'),
        // -----------------------------------------
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFDDE9DD),
          appBarTheme: const AppBarTheme(color: Color(0xFFDDE9DD)),
          tabBarTheme: const TabBarThemeData(
            indicatorColor: Colors.black,
            labelColor: Colors.black,
          ),
          primaryColor: const Color(0xFF208B52),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF208B52)),
          progressIndicatorTheme: const ProgressIndicatorThemeData(color: Color(0xFF208B52)),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF208B52)),
            )
          )
        ),
        routes: {
          '/': (ctx) => const AuthScreen(),
          '/modulos-screen': (ctx) => ModulosScreen(),
          '/interface-screen': (ctx) => const Interface(),
          '/tabs-screen-2': (ctx) => const TabsScreen2(),
          '/fases-screen': (ctx) => const FaseScreen(),
          '/users-chart-screen': (ctx) => const UsersChartScreen(),
          '/login-screen': (ctx) => const LoginScreen(),
          '/register-screen': (ctx) => const RegisterScreen(),
          '/account-created-screen': (ctx) => const AccountCreatedScreen(),
          '/about-you-1-screen': (ctx) => const AboutYou1Screen(),
          '/about-you-2-screen': (ctx) => const AboutYou2Screen(),
          '/about-you-3-screen': (ctx) => const AboutYou3Screen(),
          '/ready-screen': (ctx) => const ReadyScreen(),
          '/forgot-password-screen': (ctx) => ForgotPasswordScreen(),
          '/force-password-update': (ctx) => const ForcePasswordUpdateScreen(),
          '/topic-1-screen': (ctx) => Topic1Screen(),
          '/topico-1-conteudo-screen': (ctx) => Topico1ConteudoScreen(),
          '/testar-screen': (ctx) => TestarScreen(),
          '/quest-1-screen': (ctx) => Quest1Screen(),
          '/acertos-screen': (ctx) => AcertosScreen(),
          '/historico-screen': (ctx) => HistoricoScreen(),
          '/fase-screen': (ctx) {
            final args = ModalRoute.of(ctx)!.settings.arguments as Fase;
            final faseService = Provider.of<FaseService>(ctx, listen: false);
            return Fase2Screen(
              faseId: args.id,
              faseService: faseService,
            );
          },
        },
      ),
    );
  }
}