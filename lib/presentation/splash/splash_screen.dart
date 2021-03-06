import 'package:factoryapp/domain/repository/api_repository.dart';
import 'package:factoryapp/domain/repository/local_storage_repository.dart';
import 'package:factoryapp/presentation/home/home_screen.dart';
import 'package:factoryapp/presentation/login/login_screen.dart';
import 'package:factoryapp/presentation/splash/splash_bloc.dart';
import 'package:factoryapp/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SplashBLoc(
            apiRepositoryInterface: context.read<ApiRepositoryInterface>(),
            localRepositoryInterface: context.read<LocalRepositoryInterface>()),
        builder: (_, __) => SplashScreen._());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _init() async {
    final bloc = context.read<SplashBLoc>();
    final result = await bloc.validateSession();
    if (result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen.init(context)));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => LoginScreen.init(context)));
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        _init();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: factoryGradients)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/factorysplash.json',
              width: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 10),
            Text('FactoryApp',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontWeight: FontWeight.bold, color: FactoryColors.white)),
          ],
        ),
      ),
    );
  }
}
