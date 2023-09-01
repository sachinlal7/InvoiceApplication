import 'package:flutter/material.dart';
import 'package:invoice_app/constants_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  WebViewController controller = WebViewController();

  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  getInvoiceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    InvIdValue = prefs.getString(INVOICE_ID) ?? "";
    print(InvIdValue);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInvoiceId();
    // var webUrl = "http://192.168.1.31:8000/preview/";
    // print("webvieew $InvIdValue");
    // controller = WebViewController()
    // ..loadRequest(Uri.parse("https://pub.dev/"))
    // ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000));
    // NavigationDelegate(
    //   onProgress: (int progress) {
    //     // Update loading bar.
    //   },
    //   onPageStarted: (String url) {},
    //   onPageFinished: (String url) {},
    //   onWebResourceError: (WebResourceError error) {},
    //   onNavigationRequest: (NavigationRequest request) {
    //     if (request.url.startsWith('https://www.youtube.com/')) {
    //       return NavigationDecision.prevent;
    //     }
    //     return NavigationDecision.navigate;
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(
              url: Uri.parse("http://192.168.1.31:8000/termsof-uses/")),
          onWebViewCreated: (InAppWebViewController controller) {
            inAppWebViewController = controller;
            controller.clearCache();
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
        )
      ],
    ));
  }
}
