import 'package:drivolution/app_router.dart';
import 'package:drivolution/logic/internet_cubit/internet_cubit.dart';
import 'package:drivolution/presentation/themes/app_colors.dart';
import 'package:drivolution/presentation/themes/themes.dart';
import 'package:drivolution/presentation/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: MaterialApp(
        builder: (context, child) => Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => BlocListener<InternetCubit, InternetState>(
                listenWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is InternetConnected) {
                    showToastMessage(
                      context,
                      'Internet Connection Restored',
                      const Icon(Icons.done,
                          color: AppColors.successGreen, size: 18),
                    );
                  } else {
                    showToastMessage(
                      context,
                      'No Internet Connection',
                      const Icon(Icons.error,
                          color: AppColors.alertRed, size: 18),
                    );
                  }
                },
                child: child,
              ),
            ),
          ],
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
        theme: CustomTheme.appTheme,
      ),
    );
  }

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }
}
