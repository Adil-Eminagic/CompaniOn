import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/background_provider.dart';

class PayPalSuccessPage extends StatelessWidget {
  final String? backgroundUrl;
  
  const PayPalSuccessPage({Key? key, this.backgroundUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success'), backgroundColor: Colors.green),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Purchase completed!',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            const SizedBox(height: 40),
            if (backgroundUrl != null) ...[
              SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    context.read<BackgroundProvider>().updateBackground(backgroundUrl!);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Change Background Immediately'),
                ),
              ),
              const SizedBox(height: 20),
            ],
            SizedBox(
              width: 200,
              height: 60,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 22),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
