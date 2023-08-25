import 'package:cutfx_salon/utils/const_res.dart';
import 'package:cutfx_salon/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(
          Get.arguments == AppLocalizations.of(context)!.termsOfUse
              ? ConstRes.termsOfUseUrl
              : ConstRes.privacyPolicyUrl));
    return Scaffold(
      body: Column(
        children: [
          ToolBarWidget(
            title: Get.arguments,
          ),
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
