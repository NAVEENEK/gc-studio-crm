import 'package:flutter/material.dart';
import 'package:frontend/core/network/api_service.dart';
import 'package:frontend/core/network/dio_client.dart';
import 'package:frontend/core/routes/app_router.dart';
import 'package:frontend/core/storage/storage_service.dart';
import 'package:frontend/features/auth/provider/auth_provider.dart';
import 'package:frontend/features/auth/service/auth_service.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        //create a single StorageService object
        Provider<StorageService>(create: (_) => StorageService()),
        //create a single DioClient object
        Provider<DioClient>(
          create: (context) => DioClient(context.read<StorageService>()),
        ),
        //create a single ApiService object
        //and inject the existing DioClient
        Provider<ApiService>(
          create: (context) => ApiService(context.read<DioClient>()),
        ),
        //create a single AuthService object
        //and inject the existing ApiService
        Provider<AuthService>(
          create: (context) => AuthService(context.read<ApiService>()),
        ),
        //create a single AuthProvider object
        //and inject the existing AuthService
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(
            context.read<AuthService>(),
            context.read<StorageService>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
