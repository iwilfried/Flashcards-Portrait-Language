import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flashcards_portrait/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state_managment/dark_mode_state_manager.dart';
import 'package:styled_text/styled_text.dart';

class LearnMore extends ConsumerWidget {
  final String text;
  final String categoryName;
  final Map<String, StyledTextTagBase> tags;
  const LearnMore(
      {Key? key,
      required this.text,
      required this.tags,
      required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shape: const Border(top: BorderSide(color: Colors.green, width: 3)),
          backgroundColor: Theme.of(context).cardColor,
          titleSpacing: 0,
          shadowColor: Theme.of(context).shadowColor,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: AutoSizeText(
                      AppLocalizations.of(context)!.translate('learn_more')!,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  child: Icon(
                    Icons.more_vert,
                    color: Theme.of(context).primaryColor,
                  ),
                  onSelected: (String value) => ref
                      .read(darkModeStateManagerProvider.notifier)
                      .switchDarkMode(),
                  itemBuilder: (BuildContext context) {
                    return {
                      Theme.of(context).brightness == Brightness.light
                          ? 'Dark mode'
                          : 'Light mode'
                    }.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).primaryColor, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: AutoSizeText(
                    categoryName,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 27,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: StyledText(
                      text: text,
                      style: TextStyle(
                        fontFamily: "RobotoSerif",
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                        height: 1.7,
                      ),
                      tags: tags,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
