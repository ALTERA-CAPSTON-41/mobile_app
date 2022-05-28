import 'dart:async';

import 'package:flutter/material.dart';

BoxShadow shadow(Color color, {blur = 22.0, spred = 5.0}) {
  return BoxShadow(
    color: color,
    blurRadius: blur,
    spreadRadius: spred,
    offset: const Offset(7.0, 7.0),
  );
}

// Padding
EdgeInsetsGeometry paddingAll(double val) => EdgeInsets.all(val);
EdgeInsetsGeometry paddingLeft(double val) => EdgeInsets.only(left: val);
EdgeInsetsGeometry paddingRight(double val) => EdgeInsets.only(right: val);
EdgeInsetsGeometry paddingTop(double val) => EdgeInsets.only(top: val);
EdgeInsetsGeometry paddingBottom(double val) => EdgeInsets.only(bottom: val);
EdgeInsetsGeometry paddingOnly({
  double left = 0.0,
  top = 0.0,
  right = 0.0,
  bottom = 0.0,
}) =>
    EdgeInsets.only(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
    );

extension StringExts on String {
  bool get isValid {
    return isNotEmpty && length > 0;
  }

  bool isEqual(String val) {
    return isValid && this == val;
  }

  int parseInt() {
    return int.parse(this);
  }
}

extension IntExts on int {
  bool isEqual(int val) {
    return this == val;
  }
}

Future<FutureOr<dynamic>> delay(Duration duration,
    [FutureOr<dynamic> Function()? func]) {
  return Future.delayed(duration, func);
}

extension ListExt on List {
  bool greaterThan(int val) {
    return length > val;
  }

  bool lessThan(int val) {
    return length < val;
  }
}

T cast<T>(dynamic x, {T? fallback}) => x is T ? x : fallback!;

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

Size textSize(String text, TextStyle style) {
  final TextPainter textPainter =
      TextPainter(text: TextSpan(text: text, style: style), maxLines: 1)
        ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

extension StringCasingExtension on String {
  String get capitalize {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeExtension on DateTime {
  String get dateAndtime => "$shortDayName $day, $hour:00";

  //* Getter to switching day name to short day name
  String get shortDayName {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      default:
        return 'Sun';
    }
  }

  //* Getter to switching day name
  String get dayName {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      default:
        return 'Minggu';
    }
  }

  //* Getter to generate month name
  String get monthName {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Augustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      default:
        return 'Desmber';
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
