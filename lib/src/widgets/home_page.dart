import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_downloader_flutter/src/models/download_manager.dart';
import 'package:youtube_downloader_flutter/src/models/settings.dart';
import 'package:youtube_downloader_flutter/src/widgets/downloads_view/downloads_page.dart';
import 'package:youtube_downloader_flutter/src/widgets/settings_page.dart';
import 'package:youtube_downloader_flutter/src/widgets/youtube_page.dart';
import '../search_bar.dart';
import 'app_drawer.dart';

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2>  {
  
 

  @override
  Widget build(BuildContext context) {
  //  TabController index =
  //       TabController(length: 3, vsync: this, initialIndex: 1);


    return DefaultTabController(length: 3,initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            YoutubePage(),
            DownloadsPage(),
            SettingsPage(),
          ],
        ),
        // body: Center(child: Text(AppLocalizations.of(context)!.startSearch)),
    
        appBar: AppBar(
          bottom: TabBar(
            // onTap: (int num) {
            //   index.index = num;
            //   setState(() {
            //     index.animateTo(num,
            //         duration: const Duration(milliseconds: 500),
            //         curve: Curves.bounceIn);
            //   });
            // },
            onTap: (int num){
         
            },
            tabs: [
              Tab(
                icon: Icon(Icons.video_call_outlined),
              ),
              Tab(
                icon: Icon(Icons.video_collection),
              ),
              Tab(
                icon: Icon(Icons.settings),
              ),
            ],
          ),
          title: PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight), child: SearchBar()),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     showSearch(context: context, delegate: CustomSearchDelegate());
        //   },
        //   child: Icon(Icons.search),
        // ),
      ),
    );
  }
}
