import 'package:flutter/material.dart';
import 'package:newsapi/screens/home.dart';
import 'package:newsapi/widget/custom_theme.dart';
void main() {
  runApp(const NewsMater());
}
class NewsMater extends StatelessWidget {
  const NewsMater({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = UiTheme.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Food Camp',
      home: const HomePage(),
    );
  }
}