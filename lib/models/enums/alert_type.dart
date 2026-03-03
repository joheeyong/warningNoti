import 'package:flutter/material.dart';

enum AlertType {
  typhoon('태풍', Icons.cyclone),
  heavyRain('호우', Icons.water_drop),
  heavySnow('대설', Icons.ac_unit),
  coldWave('한파', Icons.severe_cold),
  heatWave('폭염', Icons.wb_sunny),
  drought('가뭄', Icons.landscape),
  tsunami('쓰나미', Icons.tsunami),
  earthquake('지진', Icons.vibration),
  yellowDust('황사', Icons.blur_on),
  airPollution('대기오염', Icons.cloud),
  flood('홍수', Icons.flood),
  storm('폭풍', Icons.storm),
  fire('산불', Icons.local_fire_department),
  other('기타', Icons.info_outline);

  const AlertType(this.label, this.icon);

  final String label;
  final IconData icon;
}
