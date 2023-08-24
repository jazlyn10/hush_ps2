import 'package:hush/Pages/SlumberQuest/quizz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:quizz_app/screens/quizz_screen.dart';
// import 'package:quizz_app/ui/shared/color.dart';
// import 'package:untitled/screens/Slumber_quest/screens/quizz_screen.dart';

// import '../ui/shared/color.dart';
import 'color.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF235767),
        title: Center(child: Text('Test Your Knowledge on Sleep',
          style: TextStyle(
            color: Colors.white,
          ),),),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          // Background image
          Image.asset(
            'assets/images/bgquiz.png',
            fit: BoxFit.cover,
          ),
          // Centered image
          Center(
            child: Image.asset(
              'assets/images/quiz-top-mainscreen.png',
              width: 640,
              height: 500,
            ),
          ),
          // Start Quiz button at the bottom
          SizedBox(
            height: 100,
            width: 200,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(56.0),
                child: RawMaterialButton(
                  onPressed: () {
                    // Navigating to the QuizScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizzScreen(),
                      ),
                    );
                  },
                  shape: StadiumBorder(),
                  fillColor: AppColor.secondaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 28.0,
                    ),
                    child: Text(
                      "Start Quiz",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: Text('Quiz Screen'),
      ),
    );
  }
}













// backgroundColor: AppColor.pripmaryColor,
// body: Padding(
//   padding: const EdgeInsets.symmetric(
//     vertical: 48.0,
//     horizontal: 30.0,
//   ),
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       const Padding(
//         padding: EdgeInsets.all(19.0),
//         child: Center(
//           child: Text(
//             "Quizz App",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 48,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 150,
//         child: Expanded(
//           child: Center(
//             child: RawMaterialButton(
//               onPressed: () {
//                 //Navigating the the Quizz Screen
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => QuizzScreen(),
//                     ));
//               },
//               shape: const StadiumBorder(),
//               fillColor: AppColor.secondaryColor,
//               child: const Padding(
//                 padding:
//                     EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
//                 child: Text(
//                   "Start the Quizz",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 26.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//       const Center(
//         child: Text(
//           "Made with ❤ by Mouheb Boucherb",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),

