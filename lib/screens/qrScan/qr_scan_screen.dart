import 'dart:io';

import 'package:cutfx_salon/screens/requestDetails/request_detail_screen.dart';
import 'package:cutfx_salon/utils/color_res.dart';
import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanScreen extends StatefulWidget {
  final bool needResult;
  Function(String code)? function;

  QrScanScreen({Key? key, this.needResult = false, this.function})
      : super(key: key);

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.transparent,
      body: Column(
        children: [
          ToolBarWidget(
            title: AppLocalizations.of(context)!.qRScan,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Row(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .scanTheBookingQRToGetTheDetailsQuickly,
                    style: const TextStyle(fontSize: 15, color: ColorRes.white),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: Get.width / 1.7,
                        height: Get.width / 1.7,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: ColorRes.themeColor,
                          width: 3,
                        )),
                        child: QRView(
                          key: qrKey,
                          overlayMargin: EdgeInsets.zero,
                          onQRViewCreated: (controller) {
                            widget.needResult
                                ? controller.scannedDataStream.listen((event) {
                                    controller.dispose();
                                    widget.function!(event.code.toString());
                                    return;
                                  })
                                : _onQRViewCreated(controller);
                          },
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(
          () {
            result = scanData;
            if (result?.code != null) {
              Get.off(() => const RequestDetailsScreen(), arguments: {
                ConstRes.bookingId: result?.code,
                ConstRes.type: 1,
              });
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
