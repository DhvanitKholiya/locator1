import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'Global.dart';

void main() async {
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
}

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (Platform.isAndroid) {
          await inAppWebViewController!.reload();
        } else if (Platform.isIOS) {
          await inAppWebViewController!.loadUrl(
              urlRequest:
                  URLRequest(url: await inAppWebViewController!.getUrl()));
        }
      },
      options: PullToRefreshOptions(color: Colors.transparent),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map data1 = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text("${data1['name']}",style: const TextStyle(fontSize: 22),),
        actions: [
          IconButton(onPressed: () async{
            await inAppWebViewController!.goBack();
          }, icon: const Icon(Icons.arrow_back_ios_rounded)),
          IconButton(onPressed: () async{
            await inAppWebViewController!.goForward();
          }, icon: const Icon(Icons.arrow_forward_ios_rounded)),
        ],
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: SafeArea(
        child: InAppWebView(
          pullToRefreshController: pullToRefreshController,
          initialUrlRequest: URLRequest(url: Uri.parse(data1['webSite'])),
          onLoadStop: (controller,url) async {
            await pullToRefreshController.endRefreshing();
          },
          onWebViewCreated: (val){
            setState(() {
              inAppWebViewController = val;
            });
          },
        ),
      ),
    );
  }
}
