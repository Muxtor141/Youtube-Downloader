import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:youtube_downloader_flutter/src/providers.dart';
import 'package:youtube_downloader_flutter/src/widgets/search_view/streams_list.dart';

import '../providers.dart';
import 'package:youtube_downloader_flutter/src/models/query_video.dart';




class YoutubePage extends HookWidget {
   late WebViewController webControl ;
  @override
  Widget build(BuildContext context) {
 

    final yt = useProvider(ytProvider);
    Future openStream() async {
      var url = await webControl.currentUrl();
      if (url != null) {
        print(url);
        var video = await yt.videos.get(url);

        Future.delayed(
          Duration(seconds: 1),
        );

        QueryVideo field = QueryVideo(video.title, video.id.toString(),
            video.author, Duration(seconds: 1), 'good');
        showDialog(
            context: context, builder: (context) => StreamsList(field));
      } else {
        print('NUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUL');
      }
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download),
        onPressed: () {
          openStream();
        },
      ),
      body: WebView(
        
        onWebViewCreated: (WebViewController contr) {
          webControl=contr;
          print('URLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL');
        },
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        allowsInlineMediaPlayback: true,
        initialUrl: 'https://youtube.com',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
