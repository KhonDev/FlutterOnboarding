import 'package:flutter/material.dart';
import 'package:flutter9/resources/resources.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  int currentPage = 0;

  final Map<int, dynamic> onboardData = {
    0: {
      'image': Images.onboarding0,
      'title': 'Connect people\naround the world',
      'subtitle':
          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'
    },
    1: {
      'image': Images.onboarding1,
      'title': 'Live your life smarter\nwith us!',
      'subtitle':
          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'
    },
    2: {
      'image': Images.onboarding2,
      'title': 'Get a new experience\nof imagination',
      'subtitle':
          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.'
    },
  };

  toNextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  toSkip() {
    controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  toStart() {
    controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  changeCurrentPage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFF3594DD),
              Color(0xFF4563DB),
              Color(0xFF5036D5),
              Color(0xFF5B16D0),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: toSkip,
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0, top: 20.0),
                    child: Text(
                      'Skip',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 670.0,
                child: PageView.builder(
                  onPageChanged: (valeu) => changeCurrentPage(valeu),
                  controller: controller,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return OnboarditemWidget(
                      image: onboardData[index]['image'],
                      title: onboardData[index]['title'],
                      subtitle: onboardData[index]['subtitle'],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => CIRCULARINDICATOR(
                      isActive: currentPage == index ? true : false),
                ),
              ),
              const Spacer(),
              if (currentPage != 2)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    width: 91.0,
                    child: TextButton(
                      onPressed: toNextPage,
                      child: Row(
                        children: const <Widget>[
                          Text(
                            'Next',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
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
      bottomSheet: currentPage == 2
          ? Container(
              padding: const EdgeInsets.only(top: 20.0),
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: toStart,
                child: Text(
                  'get Started',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade800),
                ),
              ),
              width: double.infinity,
              height: 100.0,
            )
          : const SizedBox(),
    );
  }
}

class CIRCULARINDICATOR extends StatelessWidget {
  const CIRCULARINDICATOR({Key? key, required this.isActive}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width: isActive ? 22.0 : 15.0,
      height: 7,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

class OnboarditemWidget extends StatelessWidget {
  const OnboarditemWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0).copyWith(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  height: 1.5,
                  fontFamily: 'SansSerif'),
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
