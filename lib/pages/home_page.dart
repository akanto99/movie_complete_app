import 'package:flutter/material.dart';
import 'package:movie_complete_app/models/movie_model.dart';
import 'package:movie_complete_app/widgets/movie_item.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  double pageNumber = 0.0;
  @override
  void initState() {
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );

    pageController.addListener(() {
      setState(() {
        pageNumber = pageController.page!;
      });
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                'images/spotlight.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            PageView.builder(
              itemBuilder: (context, index) =>
                  MovieItem(movies[index], pageNumber, index.toDouble()),
              controller: pageController,
              itemCount: movies.length,
            ),
          ],
        ),
      ),
    );
  }
}
