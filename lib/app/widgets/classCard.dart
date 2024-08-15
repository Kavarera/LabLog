import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_log/utils/textStyle.dart';

class ClassCard extends StatelessWidget {
  final String className;
  final String classCode;
  final String classLogo;
  final VoidCallback onStatusClicked;
  final VoidCallback onDownloadClicked;

  const ClassCard({
    Key? key,
    required this.className,
    required this.classCode,
    required this.classLogo,
    required this.onStatusClicked,
    required this.onDownloadClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              SvgPicture.asset(
                classLogo,
                width: 24,
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      className,
                      style: GoogleTextStyle.buttonText()
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      classCode,
                      style: GoogleTextStyle.buttonText()
                          .copyWith(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                onPressed: onStatusClicked,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Text(
                  'Status',
                  style: GoogleTextStyle.buttonText()
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: onDownloadClicked,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    overlayColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Text(
                    'Download report',
                    style: GoogleTextStyle.buttonText()
                        .copyWith(color: Colors.white),
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
