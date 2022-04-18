import 'package:flutter/material.dart';
import 'package:food/screens/home.dart';
import 'package:food/widget/custom_theme.dart';
void main() {
  runApp(const FoodMater());
}
class FoodMater extends StatelessWidget {
  const FoodMater({Key? key}) : super(key: key);

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