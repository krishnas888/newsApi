import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food/api_maneger/api.dart';
import 'package:food/model/testla.dart';
import 'package:food/widget/custom_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Testla>? _newTestla;

  @override
  void initState() {
    _newTestla = API_Maneger().getNews() as Future<Testla>?;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Testla>(
          future: _newTestla,
          builder: (context, AsyncSnapshot<Testla> snapshot) {
            if (snapshot.hasData) {
              const CircularProgressIndicator();
              final testlaData = snapshot.data?.articles ?? [];
              /*return  Center(
                child: Container(
                  child: Image.network("${snapshot.data!.articles![0].urlToImage}",fit: BoxFit.fill,),
                ),
              );*/
              return ListView.separated(
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context, index) {
                  final newTestlaData = snapshot.data!;
                  return buildCard(newTestlaData, index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildCard(Testla newTestlaData, int index) {
    if (newTestlaData.articles!.isNotEmpty) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                newTestlaData.articles![index].urlToImage != null
                    ? Image.network(
                        "${newTestlaData.articles![index].urlToImage}")
                    : Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.height * 3,
                        color: Colors.white,
                        child:const Center(
                          child: Text(
                            "Image not found",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                Text(
                  "${newTestlaData.articles![index].title}",
                  style: UiTheme.lightTextTheme.headline5,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("Where we found : ",
                        style: UiTheme.darkTextTheme.headline3),
                    Text("${newTestlaData.articles![index].source!.name}",
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        )),
                  ],
                ),
                const SizedBox(height: 4),
                Row(children: [
                  Text("Author Name  : ",
                      style: UiTheme.darkTextTheme.headline3),
                  Text(
                    "${newTestlaData.articles![index].author}",
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                ]),
                const SizedBox(height: 4),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Description  : ",
                      style: UiTheme.darkTextTheme.headline3),
                  Expanded(
                    child: Text(
                      "${newTestlaData.articles![index].description}",
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 4),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Content  : ", style: UiTheme.darkTextTheme.headline3),
                  Expanded(
                    child: Text(
                      "${newTestlaData.articles![index].content}",
                      maxLines: 12,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 2,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      );
    } else {
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
