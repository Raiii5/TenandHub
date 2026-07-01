import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'services/tenant_hub_service.dart';
import 'cubit/event_cubit.dart';
import 'cubit/booth_cubit.dart';
import 'pages/home_page.dart';
import 'services/auth_service.dart';

const String _supabaseUrl = 'https://kyvtwugdgtxdxyeikmlb.supabase.co';
const String _supabaseAnonKey = 'sb_publishable_KtI053dZkTho6tzbqaC0JQ_-r3Ehvds';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
    url: _supabaseUrl,
    publishableKey: _supabaseAnonKey, // <-- Ubah di sini
  );

  sl.registerLazySingleton<SupabaseClient>(() => supabase.client);
  sl.registerLazySingleton<AuthService>(() => AuthService(sl()));
  sl.registerLazySingleton<TenantHubService>(() => TenantHubService(sl()));
  sl.registerFactory<EventCubit>(() => EventCubit(sl()));
  sl.registerFactory<BoothCubit>(() => BoothCubit());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const TenantHubApp());
}

class TenantHubApp extends StatelessWidget {
  const TenantHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<EventCubit>()),
        BlocProvider(create: (_) => sl<BoothCubit>()),
      ],
      child: MaterialApp(
        title: 'TenantHub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
