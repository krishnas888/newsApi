import 'package:flutter/material.dart';

import '../api_maneger/api.dart';
import '../model/testla.dart';
import '../widget/custom_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Testla>? _newTestla;

  @override
  void initState() {
    super.initState();
    _newTestla = API_Maneger().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Testla>(
          future: _newTestla,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final articles = snapshot.data!.articles ?? [];
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: articles.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) => buildCard(articles[index]),
              );
            } else {
              return const Center(child: Text("No data available."));
            }
          },
        ),
      ),
    );
  }

  Widget buildCard(Article article) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            article.urlToImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                article.urlToImage!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                : Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(
                child: Text(
                  "Image not found",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              article.title ?? "No Title",
              style: UiTheme.lightTextTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text("Source: ", style: UiTheme.darkTextTheme.displaySmall),
                Expanded(
                  child: Text(
                    article.source?.name ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text("Author: ", style: UiTheme.darkTextTheme.displaySmall),
                Expanded(
                  child: Text(
                    article.author ?? "Unknown",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description: ", style: UiTheme.darkTextTheme.displaySmall),
                Expanded(
                  child: Text(
                    article.description ?? "N/A",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Content: ", style: UiTheme.darkTextTheme.displaySmall),
                Expanded(
                  child: Text(
                    article.content ?? "N/A",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
