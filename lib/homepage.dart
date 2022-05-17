// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/app_localizations.dart';
import 'package:localization/controller.dart';

import 'language.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Get.put(LocaleCont());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter " +
              AppLocalization.of(context)
                  .getTranslatedValue("home_appBar_title")
                  .toString(),
          maxLines: 3,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: Language.languageList()
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.find<LocaleCont>()
                        .updateLocale(_changeLanguage(e, context));
                  },
                  child: Text("${e.name} ${e.flag}"),
                ),
              ),
            )
            .toList(),
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            AppLocalization.of(context).getTranslatedValue("demo").toString(),
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/book.jpg"),
                    fit: BoxFit.fitHeight)),
          ),
          Text(
            AppLocalization.of(context)
                .getTranslatedValue("bookname")
                .toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            AppLocalization.of(context).getTranslatedValue("author").toString(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              final snackBar = SnackBar(
                duration: Duration(seconds: 1),
                content: Text(
                  AppLocalization.of(context)
                      .getTranslatedValue("link")
                      .toString(),
                ),
              );
              FlutterClipboard.copy(
                      'https://www.amazon.com/Make-Yourself-Software-Developer-Flutter-ebook/dp/B09NNXNT6X')
                  .then((value) {
                return ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            child: Text(AppLocalization.of(context)
                .getTranslatedValue("buy")
                .toString()),
          ),
          Spacer(),
        ],
      )),
    );
  }

  Locale _changeLanguage(Language language, context) {
    Locale _a;
    switch (language.languageCode) {
      case ENGLISH: // here ENGLISH is a constant that I've created in another file called `constant.dart` file and same for other languages
        _a = Locale(language.languageCode, "US");

        break;
      case NEPALI:
        _a = Locale(language.languageCode, "NP");

        break;
      case SPANISH:
        _a = Locale(language.languageCode, 'AR');

        break;

      default:
        _a = Locale(language.languageCode, 'US');
    }
    return _a;
  }
}

const String ENGLISH = "en";
const String NEPALI = "ne";
const String SPANISH = "es";
