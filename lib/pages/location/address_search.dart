import 'package:flutter/material.dart';
import 'package:food_app/models/place.dart';
import 'package:uuid/uuid.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  late final sessionToken;
  late PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, Suggestion("", ""));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(((snapshot.data as List<Suggestion>)[index]
                            as Suggestion)
                        .description),
                    onTap: () {
                      close(
                          context,
                          (snapshot.data as List<Suggestion>)[index]
                              as Suggestion);
                    },
                  ),
                  itemCount: (snapshot.data as List<Suggestion>).length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}
