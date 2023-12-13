// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_clean_architecture_course/app/app_prefs.dart';
import 'package:flutter_clean_architecture_course/app/di.dart';
import 'package:flutter_clean_architecture_course/domain/model/model.dart';
import 'package:flutter_clean_architecture_course/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_clean_architecture_course/presentation/resources/assets_manager.dart';
import 'package:flutter_clean_architecture_course/presentation/resources/color_manager.dart';
import 'package:flutter_clean_architecture_course/presentation/resources/routes_manager.dart';
import 'package:flutter_clean_architecture_course/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/string_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final pageController = PageController(initialPage: 0);
  OnBoardingViewModel viewModel = OnBoardingViewModel();
  AppPreferences appPreferences = instance<AppPreferences>();

  _bind() {
    appPreferences.setOnBoardingScreenViewed();
    viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: viewModel.outputSliderViewObject,
      builder: (context, snapshot) => _getContentWidget(snapshot.data),
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: Spacing.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) => viewModel.onPageChanged(index),
          itemBuilder: (context, index) =>
              OnBoardingPage(sliderObject: sliderViewObject.sliderObject),
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          height: Spacing.s100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context).textTheme.subtitle2,
                    textAlign: TextAlign.end,
                  ).tr(),
                ),
              ),
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(Spacing.s14),
            child: GestureDetector(
              child: SizedBox(
                height: Spacing.s20,
                width: Spacing.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
              onTap: () {
                // go to previous slide
                pageController.animateToPage(viewModel.goPrevious(),
                    duration: const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          // circles indicator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(Spacing.s8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),

          // right arrow
          Padding(
            padding: const EdgeInsets.all(Spacing.s14),
            child: GestureDetector(
              child: SizedBox(
                height: Spacing.s20,
                width: Spacing.s20,
                child: SvgPicture.asset(ImageAssets.rightarrowIc),
              ),
              onTap: () {
                // go to next slide
                pageController.animateToPage(viewModel.goPrevious(),
                    duration: const Duration(milliseconds: DurationConstant.d300),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int _currentIndex) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}

// TODO: Might Change
class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;
  const OnBoardingPage({
    Key? key,
    required this.sliderObject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: Spacing.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(Spacing.s8),
          child: Text(
            sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Spacing.s8),
          child: Text(
            sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(
          height: Spacing.s60,
        ),
        SvgPicture.asset(sliderObject.image)
        // image widget
      ],
    );
  }
}
