import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_complete_app/temp/db.dart';



class MovieItem extends StatefulWidget {
  final Movie movie;
  final double pageNumber;
  final double index;

  const MovieItem(this.movie, this.pageNumber, this.index, {Key? key}) : super(key: key);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem>
    with SingleTickerProviderStateMixin {
  Animation<double>? heightAnim;
  Animation<double>? elevAnim;
  Animation<double>? yOffsetAnim;
  Animation<double>? scaleAnim;
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    controller.addListener(() {
      setState(() {

      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    heightAnim = Tween(begin: 0.0, end: 150.0).animate(CurvedAnimation(
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      parent: controller,
    ));
    scaleAnim = Tween(begin: 0.95, end: 1.0).animate(CurvedAnimation(
      curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      parent: controller,
    ));
    yOffsetAnim = Tween(begin: 1.0, end: 10.0).animate(CurvedAnimation(
      curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      parent: controller,
    ));
    elevAnim = Tween(begin: 2.0, end: 10.0).animate(CurvedAnimation(
      curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      parent: controller,
    ));
    super.didChangeDependencies();
  }

  bool isExpanded = false;
  var textStyle = const TextStyle(fontSize: 18, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    double diff = widget.index - widget.pageNumber;
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(-pi / 4 * diff),
      alignment: diff>0 ? FractionalOffset.centerLeft:FractionalOffset.centerRight,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.movie.name),
              background: Image.asset(
                widget.movie.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.deepPurple.withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Text(
                          widget.movie.description,
                          style: textStyle,
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: scaleAnim!.value,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurple,
                            // gradient: const LinearGradient(
                            //   colors: [
                            //     Colors.green,
                            //     Colors.orange,
                            //   ],
                            //   begin: Alignment.topCenter,
                            //   end: Alignment.bottomCenter,
                            // ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: elevAnim!.value,
                                spreadRadius: 1,
                                offset: Offset(0, yOffsetAnim!.value),
                              )
                            ]),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text(
                                widget.movie.name,
                                style: textStyle,
                              ),
                              subtitle: Text(
                                widget.movie.category,
                                style: textStyle,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    '${widget.movie.rating}',
                                    style: textStyle,
                                  )
                                ],
                              ),
                              onTap: () {
                                if (isExpanded) {
                                  controller.reverse();
                                } else {
                                  controller.forward();
                                }
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.deepPurple,
                                      Colors.deepPurpleAccent,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),

                                ),
                                alignment: Alignment.center,
                                height: heightAnim!.value,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child: ListView(
                                    children: [
                                      Text(
                                        "Produced by : ${widget.movie.producer}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "Directed by : ${widget.movie.director}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "Production : ${widget.movie.production}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "Language : ${widget.movie.language}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "Country : ${widget.movie.country}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "Running Time : ${widget.movie.runningTime}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "Budget : ${widget.movie.budget}",
                                        style: textStyle,
                                      ),
                                      Text(
                                        "BoxOffice : ${widget.movie.boxOffice}",
                                        style: textStyle,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ]))
        ],
      ),
    );
  }
}
