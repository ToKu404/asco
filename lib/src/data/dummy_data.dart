import 'package:flutter/material.dart';
import 'package:asco/core/constants/color_const.dart';

const courses = <Course>[
  Course(
    1,
    'Mengenal Bahasa Pemrograman Kotlin',
    '27 Februari 2023',
    isLocked: false,
  ),
  Course(
    2,
    'Buat Aplikasi Android Pertamamu!',
    '3 Maret 2023',
    isLocked: false,
  ),
  Course(
    3,
    'Studi Kasus: E-Wallet App',
    '10 Maret 2023',
    isLocked: false,
  ),
  Course(
    4,
    'Migrase ke Framework Flutter',
    'Coming Soon',
  ),
  Course(
    5,
    'Statefull dan Stateless Widget',
    'Coming Soon',
  ),
];

const students = <Student>[
  Student(
    1,
    'You',
    'H071191051',
  ),
  Student(
    2,
    'Silverius S.',
    'H071191001',
  ),
  Student(
    3,
    'Muh. Ikhsan',
    'H071191002',
    isAttend: false,
  ),
  Student(
    4,
    'Eurico Devon',
    'H071191003',
  ),
  Student(
    5,
    'Raf Mas',
    'H071191004',
    isAttend: false,
  ),
  Student(
    2,
    'Ucup Cam',
    'H071191005',
  ),
  Student(
    1,
    'Muh. Ardan',
    'H071191006',
  ),
  Student(
    5,
    'Fauzi Asham',
    'H071191007',
  ),
  Student(
    4,
    'Maxi Millian Cristhoporus Columbus',
    'H071191008',
    isAttend: false,
  ),
  Student(
    3,
    'Siti Nisrina Nabila Putri Sulfi Yudo',
    'H071191009',
  ),
];

const listStatus = <FaceStatus>[
  FaceStatus(
    status: 'Alfa',
    icon: 'face_dizzy_filled.svg',
    color: Color(0xFFFA78A6),
  ),
  FaceStatus(
    status: 'Izin',
    icon: 'face_neutral_filled.svg',
    color: Color(0xFF788DFA),
  ),
  FaceStatus(
    status: 'Sakit',
    icon: 'face_sick_filled.svg',
    color: Color(0xFFFAC678),
  ),
  FaceStatus(
    status: 'Hadir',
    icon: 'face_smile_filled.svg',
    color: Palette.purple60,
  ),
];

class Course {
  final int number;
  final String topic;
  final String date;
  final bool? isLocked;

  const Course(this.number, this.topic, this.date, {this.isLocked = true});
}

class Student {
  final int id;
  final String name;
  final String nim;
  final bool? isAttend;

  const Student(this.id, this.name, this.nim, {this.isAttend = true});
}

// used at laboratorium attendance dialog
class FaceStatus {
  final String status;
  final String icon;
  final Color color;

  const FaceStatus({
    required this.status,
    required this.icon,
    required this.color,
  });
}
