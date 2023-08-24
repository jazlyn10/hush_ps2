import 'package:flutter/material.dart';
import 'package:hush/main_page.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// import 'package:untitled/screens/home_page/pages/new-main.dart';

// import '../home_page/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const spimg = 'assets/images/newsplashmid.png';
  static const bgimg = 'assets/images/newsplashbg.png';
  bool animate = false;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  Future<void> startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => animate = true);
    await Future.delayed(const Duration(milliseconds: 4000));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnBoardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgimg),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              AnimatedPositioned(
                height: 400,
                top: animate ? MediaQuery.of(context).size.height / 2 - 220 : -400,
                right: animate ? MediaQuery.of(context).size.height / -75 : -5,
                duration: const Duration(milliseconds: 1600),
                curve: Curves.easeInOut,
                child: const Image(image: AssetImage(spimg)),
              ),
              // SizedBox(height: 1,),
               Positioned(
                bottom: 110, // Adjust the position as needed
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      'Hush',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: 'Your journey to a better sleep'),
                          TextSpan(text: '\n                   with hush!'),
                        ],
                      ),
                    ),

                  ],
                ),
              ),],
          ),
        ),
      );

  }
}

//Splash Screen Ends Here//



//OnBoarding Screen starts from here//

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;


    final pages = [
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardPg1img,
          title: onBoardPg1title,
          subTitle: onBoardPg1subtitle,
          bgColor: onBoardPg1color,
          size: size.height,
        ),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardPg2img,
          title: onBoardPg2title,
          subTitle: onBoardPg2subtitle,
          bgColor: onBoardPg2color,
          size: size.height,
        ),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardPg3img,
          title: onBoardPg3title,
          subTitle: onBoardPg3subtitle,
          bgColor: onBoardPg3color,
          size: size.height,
        ),
      ),
      OnBoardingPageWidget(
        model: OnBoardingModel(
          image: onBoardPg4img,
          title: onBoardPg4title,
          subTitle: onBoardPg4subtitle,
          bgColor: onBoardPg4color,
          size: size.height,
        ),
      ),
    ];

    void onPageChangedCallBack(int activePageIndex) {
      setState(() {
        currentPage = activePageIndex;
      });
    }

    return Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            LiquidSwipe(
              liquidController: controller,
              pages: pages,
              slideIconWidget: const Icon(Icons.arrow_back_ios),
              // enableSideReveal: true,
              onPageChangeCallback: onPageChangedCallBack,
            ),
            Positioned(
              bottom: 64.0,
              child: OutlinedButton(
                onPressed: () {
                  int nextPage = controller.currentPage + 1;
                  if (nextPage < 4) {
                    print(nextPage);
                    controller.animateToPage(page: nextPage);
                  } else {
                    print("working");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white60),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(5),
                  // primary: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),

            ),         //button
            Positioned(
              bottom:14,
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentPage,
                count: 4,
                effect: const JumpingDotEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.black54,
                  dotHeight: 12.0,
                  dotWidth: 12.0,
                  spacing: 10.0,
                ),
              ),
            )     //round page indicator

          ],
        ));
  }
}



class OnBoardingPageWidget extends StatelessWidget {

  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    final defaultSize = 16.0;

    return Container(
      padding: EdgeInsets.all(defaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(model.image), height: model.size * 0.5),
          Column(
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                model.subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 150),
            ],
          ),
        ],
      ),
    );
  }
}

class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;
  final Color bgColor;
  final double size;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.bgColor,
    required this.size,
  });
}


//Various constant values for image, color, and texts for different color//
const onBoardPg1color = Color(0xFF307185); // Update color value
const onBoardPg2color = Color(0xFF8E4162); // Update color value
const onBoardPg3color = Color(0xFFF65656);
const onBoardPg4color = Color(0xFF6B1EB7);
const String onBoardPg1img = "assets/images/sleeponbo.png";

const String onBoardPg2img = "assets/images/journalonbo.png";
const String onBoardPg3img = "assets/images/quizonbo.png";
const String onBoardPg4img = "assets/images/gameonbo.png";
const splashImg = "assets/images/splashimg.png";
const splashimg = "assets/intro_app_1-removebg-preview.png";

const defaultSize = 15.0;

const String onBoardPg1title = "TRACK SLEEP";
const String onBoardPg2title = "JOURNAL";
const String onBoardPg3title = "QUEST";
const String onBoardPg4title = "GAMES";

const String onBoardPg1subtitle =
    "Track your sleep and Gain insights into your sleep patterns";
const String onBoardPg2subtitle =
    "Capture your thoughts, experiences, and any sleep-related information in our dedicated journal section.";
const String onBoardPg3subtitle =
    "Testing your knowledge and expanding your understanding of sleep.";
const String onBoardPg4subtitle =
    "Unwind and have a great time with our entertaining games.";

//OnBoarding Screen Ends Here//


