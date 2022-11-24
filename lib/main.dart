
import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:visionaryhomepage/models/index.dart';

import 'IconDownLoad.dart';

late Config AppConfig;

void main() {
  initApp().then((value) {
    setPathUrlStrategy();
    runApp(const MyApp());
  });
}

Future initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig = Config.fromJson(jsonDecode(await rootBundle.loadString("config.json")));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage()
      },
    );
  }
}

_getAppList() {
  var apps = AppConfig.apps;

  return List.generate(apps.length, (index) {
    var app = apps[index];

    return _AppInfoCard(
      TextButton(
        onPressed: () {  },
        child: Text(app.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(app.platform.length, (index) {
          var plat = app.platform[index];
          return Container(
            margin: EdgeInsets.all(10),
            child: IconDownLoad(
                Image.asset(PlatFormIcon[plat.platform] ?? "", scale: 1.5,),
                onClick: () async {
                  await launchUrl(Uri.parse(plat.downloadurl));
                },
                "${plat.version} ${plat.comment}"
            ),
          );
        }),
      ),
      Uri.parse(app.homePage),
    );
  });
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var applist = _getAppList();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/homebg.jpeg",)
        ),
      ),
      child: Material.Scaffold(
        backgroundColor: Colors.transparent,
        appBar: Material.AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("V I S I O N", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
        ),
        body: Center(
          child: SizedBox(
            width: 800,
            child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: applist.length,
                itemBuilder: (context, index) {
                  return applist[index];
                }
            ),
          ),
        ),
      ),
    );
  }
}

class _AppInfoCard extends StatelessWidget {
  final Widget logo;
  final Widget body;
  final Uri homepage;

  _AppInfoCard(this.logo, this.body, this.homepage);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        width: 800,
        height: 200,
        child: Row(
          children: [
            Expanded(
                child: Stack(
                    children: [
                      const Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Acrylic(
                            // tintAlpha: tintOpacity,
                            // luminosityAlpha: luminosityOpacity,
                            // blurAmount: blurAmout,
                            elevation: 20,
                            tint: Colors.white,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: logo,
                          ),
                        ),
                      ),
                      Center(
                        child: body,
                      ),
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: HoverButton(
                          cursor: SystemMouseCursors.click,
                          builder: (c, s) {
                            return TextButton(
                              // style: ButtonStyle(backgroundColor: ButtonState.all(Colors.transparent)),
                              onPressed: () async { await launchUrl(homepage); },
                              child: const Text("了解更多", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                            );
                          },
                        )
                      )
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}

Map<String, String> PlatFormIcon = {
  "macOS": "assets/images/macos_icon.png",
  "Windows": "assets/images/windows_icon.png"
};
