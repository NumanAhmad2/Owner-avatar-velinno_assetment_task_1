import 'package:flutter/material.dart';
import 'package:velinno_assestment_task/features/home/view/widget/error_builder_state.dart';
import 'package:velinno_assestment_task/features/home/view/widget/load_state_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final String url;
  const DetailsScreen({super.key, required this.url});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              isLoading = false;
              hasError = true;
              errorMessage = error.description;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.setBackgroundColor(Theme.of(context).scaffoldBackgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Article Details',
          style: TextStyle(
            color:
                Theme.of(context).appBarTheme.titleTextStyle?.color ??
                Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color:
                Theme.of(context).appBarTheme.iconTheme?.color ??
                Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color:
                  Theme.of(context).appBarTheme.iconTheme?.color ??
                  Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (hasError)
            ErrorBuilderState(error: errorMessage, theme: Theme.of(context))
          else
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: WebViewWidget(controller: controller),
            ),
          if (isLoading)
            LoadingStateWidget(
              theme: Theme.of(context),
              loadingText: 'Loading article...',
            ),
        ],
      ),
    );
  }
}
