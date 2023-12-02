// // ignore_for_file: constant_identifier_names

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_clean_architecture_course/presentation/resources/string_manager.dart';

// enum StateRendererType {
//   // POPUP STATES
//   POPUP_LOADING_STATE,
//   POPUP_ERROR_STATE,
//   POPUP_SUCCESS,
//   // FULL SCREEN STATES
//   FULL_SCREEN_LOADING_STATE,
//   FULL_SCREEN_ERROR_STATE,
//   CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
//   EMPTY_SCREEN_STATE // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
// }

// class StateRenderer extends StatelessWidget {
//   StateRendererType stateRendererType;
//   String message;
//   String title;
//   Function? retryActionFunction;

//   StateRenderer({
//     Key? key,
//     required this.stateRendererType,
//     String? message,
//     String? title,
//     required this.retryActionFunction
//   }): message = message ?? AppStrings.loading.tr(),
//     title = title ?? EMPTY,
//     super(key: key)
//   ;

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
