import 'package:flutter/material.dart';
import 'package:frontend/core/storage/storage_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:frontend/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void>checkLogin()async{
    final storageService=context.read<StorageService>();
    final token =await storageService.getToken();
    final userType=await storageService.getuserType();
    if(!mounted) return;

    if(token == null){
      //go to login
      context.go(AppRoutes.loginScreen);
    }else if(userType=="agency"){
      //go to agency dashboard
      context.go(AppRoutes.agencyDashboard);
    }else{
      //go to employee dashboard
      context.go(AppRoutes.employeeDashboard);
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}