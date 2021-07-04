import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travelwithme/api/api.dart';
import 'package:http/http.dart' as http;
import 'package:travelwithme/models/travel_story.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double scrollOffset = 0.0;
  ScrollController controller = ScrollController();
  late TravelStory _travelStory;
  List<Widget> componentsToShow = [];
  @override
  void initState() {
    fetchTravelStory(http.Client()).then((value) {
      print("object");
      _travelStory = value;
      fillComponents(_travelStory);
      print(_travelStory.components[3].description);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.cyan,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text("Travel With Me",
                style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: InkWell(
              onTap: () {
                showTheMagic(context, _travelStory);
              },
              child: Container(
                height: 120,
                width: 250,
                child: Card(
                  elevation: 1,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.orange,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Let's Start",
                        style: TextStyle(
                            fontSize: 25, color: Colors.black),
                      )
                    ],
                  )),
                ),
              ),
            ),
          )),
    );
  }

  fillComponents(TravelStory travelStory) {
    componentsToShow.add(
      Container(
        color: Colors.white,
        height: 600,
        child: Stack(
          children: [
            Container(
              height: 600,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: travelStory.headerImage,
              ),
            ),
            Positioned(
              child: Text(
                travelStory.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              bottom: 25,
              left: 15,
            )
          ],
        ),
      ),
    );
    for (var item in travelStory.components) {
      if (item.type == PostType.text) {
        componentsToShow.add(textComponent(item));
      } else {
        componentsToShow.add(imageComponent(item));
      }
    }
  }

  void showTheMagic(BuildContext context, TravelStory travelStory) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              clipBehavior: Clip.antiAlias,
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.all(12),
              child: Container(
                width: double.infinity,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Scrollbar(
                  controller: controller,
                  child: SingleChildScrollView(
                      child: Column(children: componentsToShow)),
                ),
              ));
        });
  }

  Widget imageComponent(Post item) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      height: 300,
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Container(
                    height: 50,
                    width: 50,
                    color: Colors.orange,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                Container(
                  width: 200,
                  child: ListTile(
                    dense: true,
                    title: Text(
                      "Zostel",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("@ZostelHostel"),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text("The 'm' ub work from home stands for",
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w400)),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 2),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textComponent(Post item) {
    return Container(
      height: 320,
      width: double.infinity,
      color: Colors.yellow[200],
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 17),
                  ),
                )),
            Flexible(
                flex: 7,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    item.description,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 17),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
