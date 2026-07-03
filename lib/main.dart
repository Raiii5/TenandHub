import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'cubit/ticket_cubit.dart';
import 'pages/splash_page.dart';
import 'services/auth_service.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  sl.registerLazySingleton<AuthService>(() => AuthService(sl()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kyvtwugdgtxdxyeikmlb.supabase.co',
    anonKey: 'sb_publishable_KtI053dZkTho6tzbqaC0JQ_-r3Ehvds',
  );

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TicketCubit>(
          create: (context) => TicketCubit()..loadTickets(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TenantHub',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF673AB7)),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
