import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleTextStyle {
  static TextStyle superLarge() =>
      GoogleFonts.poppins(fontSize: 128, fontWeight: FontWeight.w700);
  static TextStyle regularWeb() =>
      GoogleFonts.poppins(fontSize: 20, color: Colors.white);
  static TextStyle largeWeb() => GoogleFonts.poppins(
        fontSize: 48,
      );
  static TextStyle buttonText() =>
      GoogleFonts.poppins(fontSize: 20, color: Colors.black);
}
