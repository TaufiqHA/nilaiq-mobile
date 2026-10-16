import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/env.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'providers/infrastructure_providers.dart';
import 'providers/session_provider.dart';
import 'providers/sync_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/absensi_list_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: NilaiQApp()));
}

class NilaiQApp extends ConsumerStatefulWidget {
  const NilaiQApp({super.key});

  @override
  ConsumerState<NilaiQApp> createState() => _NilaiQAppState();
}

class _NilaiQAppState extends ConsumerState<NilaiQApp> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(themeModeProvider.notifier).load());
  }

  @override
  Widget build(BuildContext context) {
    // Sync queue whenever connectivity is restored.
    ref.listen(connectivityStatusProvider, (previous, next) {
      if (next.value == true) {
        ref.read(syncControllerProvider.notifier).sync();
      }
    });

    // Kick off a sync as soon as the user becomes authenticated.
    ref.listen(sessionProvider, (previous, next) {
      final wasLoggedOut = previous?.value == null;
      final isLoggedIn = next.value != null;
      if (wasLoggedOut && isLoggedIn) {
        ref.read(syncControllerProvider.notifier).sync();
      }
    });

    // Surface the outcome of a sync so silent failures are visible.
    ref.listen(syncControllerProvider, (previous, next) {
      if (previous?.syncing == true && next.syncing == false) {
        final messenger = _messengerKey.currentState;
        final message = next.lastMessage;
        if (message != null) {
          messenger?.showSnackBar(SnackBar(content: Text(message)));
        } else if (next.lastPushed > 0) {
          messenger?.showSnackBar(
            SnackBar(
              content: Text('${next.lastPushed} data berhasil disinkronkan.'),
            ),
          );
        }
      }
    });

    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: Env.appName,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _messengerKey,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: const _RootGate(),
      onGenerateRoute: (settings) {
        Widget builder(BuildContext context) {
          switch (settings.name) {
            case '/absensi':
              return const AbsensiListScreen();
            case '/profile':
              return const ProfileScreen();
            case '/dashboard':
            default:
              return const DashboardScreen();
          }
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class _RootGate extends ConsumerWidget {
  const _RootGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    return session.when(
      loading: () => const _Splash(),
      error: (_, _) => const LoginScreen(),
      data: (user) =>
          user == null ? const LoginScreen() : const DashboardScreen(),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Scaffold(
      backgroundColor: palette.pageBg,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: palette.brand,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Env.appName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: palette.heading,
              ),
            ),
            const SizedBox(height: 16),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}
