import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/project_paddings.dart';
import '../model/time_quote_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: TimeQuoteList.quotes.length, vsync: this);
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  // connect the page controller to the tab controller
  void _onPageChanged(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: Padding(
        padding: const ProjectPaddings.all(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: TimeQuoteList.quotes.length,
                  itemBuilder: (context, index) {
                    final quote = TimeQuoteList.quotes[index];
                    return _pageViewItem(quote, context);
                  }),
            ),
            TabPageSelector(
              indicatorSize: 10,
              controller: _tabController,
              selectedColor: ProjectColors.vividBlue,
              color: ProjectColors.aluminium,
              borderStyle: BorderStyle.none,
            ),
            const SizedBox(height: 64),
            _startButton(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton _startButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/pomodoro');
      },
      style: ElevatedButton.styleFrom(
        primary: ProjectColors.blueLotus,
        minimumSize: const Size(double.infinity, 50),
        shape: const StadiumBorder(),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.032,
        width: double.infinity,
        child: Center(
            child: Text(
          'Start',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ProjectColors.linkWater, fontWeight: FontWeight.w600),
        )),
      ),
    );
  }

  AppBar _appBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  Column _pageViewItem(TimeQuoteModel quote, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          quote.quote,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: ProjectColors.almostBlack,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 64),
        Image.asset(
          quote.imageAsset,
          height: 200,
        ),
      ],
    );
  }
}
