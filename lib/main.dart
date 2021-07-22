import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_downloader_flutter/src/models/download_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/models/settings.dart';
import 'src/providers.dart';
import 'src/widgets/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [MainObserver()],
      child: AppInit(),
    );
  }
}

class MainObserver implements ProviderObserver {
  @override
  void didAddProvider(ProviderBase provider, Object? value) {
    print('Added: $provider : $value');
  }

  @override
  void didDisposeProvider(ProviderBase provider) {
    print('Disposed: $provider');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    print('Update: $provider : $newValue');
  }

  @override
  void mayHaveChanged(ProviderBase provider) {
    print('MayChange: $provider');
  }
}

class AppInit extends HookWidget {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    final fetched = useState<bool>(false);
    final settings = useProvider(settingsProvider);
    final downloadManager = useProvider(downloadProvider);

    useEffect(() {
      SharedPreferences.getInstance().then((value) async {
        downloadManager.state = DownloadManagerImpl.init(value);
        settings.state = await SettingsImpl.init(value);
        fetched.value = true;
      });
    }, []);

    if (!fetched.value) {
      return const  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Youtube Downloader',
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // TODO: Might be worth finding another way to achieve this
    return MaterialApp(
      
          scaffoldMessengerKey: scaffoldKey,
          debugShowCheckedModeBanner: false,
          home:  HomePage2(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: settings.state.locale,
          title: 'Youtube Downloader',
          theme: settings.state.theme.themeData,
        );
  }
}
