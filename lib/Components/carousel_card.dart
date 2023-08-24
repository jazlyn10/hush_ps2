import 'package:hush/Components/read_more_card.dart';
import 'package:hush/Components/read_more_card2.dart';
import 'package:hush/Components/read_more_card3.dart';
import 'package:hush/Components/read_more_card4.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:untitled/card-carousel/read_more-page.dart';


class Carousel extends StatelessWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<List<String>> imgList = [
      ['assets/images/card_carouse11.png',"A good night's sleep is\nlike a reset button for\nthe mind and body.", "0"],
      ['assets/images/card_carouse11.png',"The Science of Sleep:\nUnveiling the Secrets\nto a Restful Night", "1"],
      ['assets/images/card_carouse11.png',"The Impact of Sleep on\nMental Health: Exploring\nthe Vital Connection", "2"],
      ['assets/images/card_carouse11.png',"Unlocking the Power of\nDreams: Exploring\nSleep and Dreams", "3"
      ],
    ];

    final List<Widget> imageSliders = imgList
        .map((item) => Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: ClipRRect(
            child: Stack(
              children: <Widget>[
                Image.asset(item[0], fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  top: 13,
                  left: 20,bottom: 15,

                  child: Container(
                    child: Text(
                      "Article",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 40, 60),
                    child: Text(
                      item[1],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),Positioned(
                  top: 80,
                  left: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      var card = item[2];
                      if(card == "0"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage(),
                          ),
                        );
                      }if(card == "1"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage2(),
                          ),
                        );
                      }if(card == "2"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage3(),
                          ),
                        );
                      }if(card == "3"){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticlePage4(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(64, 23),
                        backgroundColor: Color(0xff99AFD8)
                    ),
                    child: Text(
                      "Read More",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black87
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ))
        .toList();

    return  SafeArea(
      child: Container(
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.9,
            viewportFraction: 1.0,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
          ),
          items: imageSliders,
        ),
      ),
    );
  }
}