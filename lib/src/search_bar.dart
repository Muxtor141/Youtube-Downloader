import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:youtube_downloader_flutter/src/providers.dart';
import 'package:youtube_downloader_flutter/src/widgets/search_view/search_result.dart';

import 'widgets/search_view/suggestion_list.dart';

class SearchBar extends HookWidget {



  @override
  Widget build(BuildContext context) {
      final settings = useProvider(settingsProvider);
    return SafeArea(
      child: Material(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shadowColor: settings.state.theme.themeData.appBarTheme.shadowColor,
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.only(left: 10),
          height: kToolbarHeight,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [

            Text(
              'Youtube Downloader',
              style: Theme.of(context).textTheme.headline5,
            ),

          ]),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchResult(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SuggestionList(query, (value) {
      query = value;
      showResults(context);
    });
  }
}
