import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'paypal_success_page.dart';
import 'paypal_cancel_page.dart';

class PayPalScreen extends StatefulWidget {
  final double price;
  final VoidCallback onSuccess;

  const PayPalScreen({
    Key? key, 
    required this.price,
    required this.onSuccess,
  }) : super(key: key);

  @override
  _PayPalScreenState createState() => _PayPalScreenState();
}

class _PayPalScreenState extends State<PayPalScreen> {
  bool isLoading = true;
  String? approvalUrl;
  final String clientId = 'AY2OUScscRr96J0OgR0P9z3m9MUIDcf9rL1yQiPDWZ7Km1qctQ3wkrtuNqBhTmx0YyGLK_Hn2HFPJegr';
  final String clientSecret = 'EEX3oSKJP7U4DLIEwRSwkXFWZ4OfYOby3wIVy3D-h4X8M12YdGShgElb2K7X-MF_K97PQtBOOcTWFx34';
  final String _paypalBaseUrl = 'https://api.sandbox.paypal.com';

  @override
  void initState() {
    super.initState();
    _startPaymentProcess();
  }

  Future<void> _startPaymentProcess() async {
    try {
      final accessToken = await _getAccessToken();
      final orderUrl = await _createOrder(accessToken, widget.price);
      setState(() {
        approvalUrl = orderUrl;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<String> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('$_paypalBaseUrl/v1/oauth2/token'),
      headers: {
        'Authorization': 'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'grant_type=client_credentials',
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to obtain PayPal access token');
    }
  }

  Future<String> _createOrder(String accessToken, double total) async {
    final response = await http.post(
      Uri.parse('$_paypalBaseUrl/v2/checkout/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode({
        'intent': 'CAPTURE',
        'purchase_units': [
          {
            'amount': {
              'currency_code': 'EUR',
              'value': total.toStringAsFixed(2),
            },
          },
        ],
        'application_context': {
          'return_url': 'https://your-success-url.com',
          'cancel_url': 'https://your-cancel-url.com',
        }
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final approvalUrl = data['links']
          .firstWhere((link) => link['rel'] == 'approve')['href'];
      return approvalUrl;
    } else {
      throw Exception('Failed to create PayPal order');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PayPal Payment'), backgroundColor: Colors.green),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : approvalUrl == null
              ? const Center(child: Text('Failed to load PayPal payment.'))
              : WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setNavigationDelegate(
                      NavigationDelegate(
                        onNavigationRequest: (request) {
                          final url = request.url;
                          if (url.startsWith('https://your-success-url.com')) {
                            widget.onSuccess();
                            return NavigationDecision.prevent;
                          }
                          if (url.startsWith('https://your-cancel-url.com')) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (_) => const PayPalCancelPage()),
                            );
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        },
                      ),
                    )
                    ..loadRequest(Uri.parse(approvalUrl!)),
                ),
    );
  }
}
