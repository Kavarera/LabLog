import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:lab_log/app/data/UserData.dart';
import '../../../widgets/classCard.dart';
import '../../../../utils/logo.dart';
import '../../../../utils/textStyle.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Obx(
          () => controller.isTokenCheckerActive.value == true
              ? Text('Loading....', style: GoogleTextStyle.regularWeb())
              : Text(
                  'Welcome, ${UserData().displayName}',
                  style: GoogleTextStyle.regularWeb(),
                ),
        ),
        actions: [
          Obx(() => controller.isTokenCheckerActive.value == true
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    controller.signOut();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/logout.svg',
                    width: 34,
                  )))
        ],
      ),
      body: Obx(
        () {
          if (controller.kelasResponse.value.kelas.isEmpty) {
            return Center(
                child: Text(
              'Tidak Ada Kelas',
              style: GoogleTextStyle.largeWeb(),
            ));
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 610,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                mainAxisExtent: 190,
              ),
              itemCount: controller.kelasResponse.value.kelas.length,
              itemBuilder: (context, index) => ClassCard(
                className: controller.kelasResponse.value.kelas
                        .elementAt(index)
                        .nama ??
                    '',
                classCode: controller.kelasResponse.value.kelas
                        .elementAt(index)
                        .kode ??
                    '',
                classLogo: LogoMapByIndex[controller.kelasResponse.value.kelas
                            .elementAt(index)
                            .logo ??
                        1] ??
                    LogoMapByIndex[0]!,
                onStatusClicked: () {
                  if (MediaQuery.of(context).size.width > 10) {
                    //FOR VIEW WIDTH BIGGER THAN 700
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          final _listTugas = controller
                              .kelasResponse.value.kelas
                              .elementAt(index)
                              .items
                              ?.tugas;

                          final _widgetTugas = _listTugas
                                  ?.asMap()
                                  .map(
                                    (i, e) => MapEntry(
                                      i,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Tugas ${i + 1}',
                                              style:
                                                  GoogleTextStyle.regularWeb()
                                                      .copyWith(
                                                          color: Colors.black),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size: 30,
                                            color: e == 0
                                                ? Colors.white
                                                : Colors.green,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            e.toString(),
                                            style: GoogleTextStyle.regularWeb()
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .values
                                  .toList() ??
                              [];
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            surfaceTintColor: Colors.white,
                            title: Center(
                              child: Obx(
                                () => Text(
                                  controller.kelasResponse.value.kelas
                                          .elementAt(index)
                                          .nama ??
                                      '',
                                  style: GoogleTextStyle.regularWeb()
                                      .copyWith(color: Colors.black),
                                ),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 10,
                                  child: Divider(),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Nama',
                                        style: GoogleTextStyle.regularWeb()
                                            .copyWith(
                                                fontSize: 15,
                                                color: Colors.black),
                                      ),
                                    ),
                                    Text(
                                      'Status',
                                      style: GoogleTextStyle.regularWeb()
                                          .copyWith(
                                              fontSize: 15,
                                              color: Colors.black),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      'Nilai',
                                      style: GoogleTextStyle.regularWeb()
                                          .copyWith(
                                              fontSize: 15,
                                              color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                ..._widgetTugas,
                                controller.kelasResponse.value.kelas
                                            .elementAt(index)
                                            .items!
                                            .kuis ==
                                        null
                                    ? SizedBox.shrink()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Kuis',
                                              style:
                                                  GoogleTextStyle.regularWeb()
                                                      .copyWith(
                                                          color: Colors.black),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size: 30,
                                            color: controller.kelasResponse
                                                        .value.kelas
                                                        .elementAt(index)
                                                        .items!
                                                        .kuis ==
                                                    null
                                                ? Colors.white
                                                : Colors.green,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            controller.kelasResponse.value.kelas
                                                .elementAt(index)
                                                .items!
                                                .kuis
                                                .toString(),
                                            style: GoogleTextStyle.regularWeb()
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                controller.kelasResponse.value.kelas
                                            .elementAt(index)
                                            .items!
                                            .responsi ==
                                        null
                                    ? SizedBox.shrink()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Responsi',
                                              style:
                                                  GoogleTextStyle.regularWeb()
                                                      .copyWith(
                                                          color: Colors.black),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size: 30,
                                            color: controller.kelasResponse
                                                        .value.kelas
                                                        .elementAt(index)
                                                        .items!
                                                        .responsi ==
                                                    null
                                                ? Colors.white
                                                : Colors.green,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            controller.kelasResponse.value.kelas
                                                .elementAt(index)
                                                .items!
                                                .responsi
                                                .toString(),
                                            style: GoogleTextStyle.regularWeb()
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                controller.kelasResponse.value.kelas
                                            .elementAt(index)
                                            .items!
                                            .project ==
                                        null
                                    ? SizedBox.shrink()
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Project',
                                              style:
                                                  GoogleTextStyle.regularWeb()
                                                      .copyWith(
                                                          color: Colors.black),
                                            ),
                                          ),
                                          Icon(
                                            Icons.check,
                                            size: 30,
                                            color: controller.kelasResponse
                                                        .value.kelas
                                                        .elementAt(index)
                                                        .items!
                                                        .project ==
                                                    0
                                                ? Colors.white
                                                : Colors.green,
                                          ),
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            controller.kelasResponse.value.kelas
                                                .elementAt(index)
                                                .items!
                                                .project
                                                .toString(),
                                            style: GoogleTextStyle.regularWeb()
                                                .copyWith(color: Colors.black),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          );
                        });
                  }
                },
                onDownloadClicked: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
