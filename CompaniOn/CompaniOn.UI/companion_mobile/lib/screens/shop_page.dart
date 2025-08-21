import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../providers/background_provider.dart';
import '../providers/purchased_items_provider.dart';
import '../utils/util.dart';  // Import for loggedUser
import 'paypal_screen.dart';
import 'paypal_success_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool _isLoading = true;
  List<Map<String, String>> _backgroundItems = [];
  List<Map<String, String>> _avatarItems = [];
  String? _fetchError;

  @override
  void initState() {
    super.initState();
    _fetchShopItems();
  }

  Future<void> _fetchShopItems() async {
    try {
      // Fetch Backgrounds
      final backgroundsDoc = await FirebaseFirestore.instance.collection('Shop').doc('Backgrounds').get();
      List<Map<String, String>> backgrounds = [];
      final backgroundsData = backgroundsDoc.data();
      if (backgroundsData != null) {
        backgroundsData.forEach((name, url) {
          backgrounds.add({
            'name': name,
            'imageUrl': url.toString(),
            'price': '10',
          });
        });
      }
      // Fetch Avatars
      final avatarsDoc = await FirebaseFirestore.instance.collection('Shop').doc('Avatars').get();
      List<Map<String, String>> avatars = [];
      final avatarsData = avatarsDoc.data();
      if (avatarsData != null) {
        avatarsData.forEach((name, url) {
          avatars.add({
            'name': name,
            'imageUrl': url.toString(),
            'price': '10',
          });
        });
      }
      setState(() {
        _backgroundItems = backgrounds;
        _avatarItems = avatars;
        _isLoading = false;
        _fetchError = null;
      });
    } catch (e) {
      setState(() {
        _backgroundItems = [];
        _avatarItems = [];
        _isLoading = false;
        _fetchError = 'Error loading shop items: $e';
      });
    }
  }

  void _navigateToAddShopItem() async {
    // Placeholder for add item navigation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Shop Item feature coming soon!')),
    );
  }

  void _showItemDialog(Map<String, String> item, IconData icon) {
    final isPurchased = context.read<PurchasedItemsProvider>().isItemPurchased(item['name'] ?? '');
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item['imageUrl'] ?? '',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => 
                      Icon(icon, size: 120, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  item['name'] ?? '',
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                if (!isPurchased) ...[
                  const SizedBox(height: 16),
                  Text(
                    item['price'] != null ? 'Price: \$${item['price']}' : '',
                    style: const TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (isPurchased)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.read<BackgroundProvider>().updateBackground(item['imageUrl'] ?? '');
                        },
                        child: const Text('Equip', style: TextStyle(color: Colors.white)),
                      )
                    else
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PayPalScreen(
                                price: double.tryParse(item['price'] ?? '0') ?? 0,
                                onSuccess: () {
                                  context.read<PurchasedItemsProvider>().addPurchasedItem(item['name'] ?? '');
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => PayPalSuccessPage(
                                        backgroundUrl: item['imageUrl'],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text('Buy', style: TextStyle(color: Colors.white)),
                      ),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Back'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_fetchError != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_fetchError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_fetchError!)),
          );
          setState(() {
            _fetchError = null;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_backgroundItems.isEmpty && _avatarItems.isEmpty)
              ? const Center(child: Text('No shop items found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      if (_backgroundItems.isNotEmpty) ...[
                        const Text('Backgrounds', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ..._backgroundItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: item['imageUrl'] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        item['imageUrl']!,
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(Icons.image, size: 40, color: Colors.green),
                              title: Row(
                                children: [
                                  Text(
                                    item['name'] ?? '',
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item['price'] != null ? '\$${item['price']}' : '',
                                    style: const TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              trailing: context.watch<PurchasedItemsProvider>().isItemPurchased(item['name'] ?? '')
                                  ? const Icon(Icons.lock_open, color: Colors.green)
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item['price'] != null ? '\$${item['price']}' : '',
                                          style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.lock, color: Colors.grey),
                                      ],
                                    ),
                              onTap: () {
                                _showItemDialog(item, Icons.image);
                              },
                            ),
                          );
                        }),
                        const SizedBox(height: 24),
                      ],
                      if (_avatarItems.isNotEmpty) ...[
                        const Text('3D Avatars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ..._avatarItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: const Icon(Icons.threed_rotation, size: 40, color: Colors.green),
                              title: Row(
                                children: [
                                  Text(
                                    item['name'] ?? '',
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    item['price'] != null ? '\$${item['price']}' : '',
                                    style: const TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              trailing: context.watch<PurchasedItemsProvider>().isItemPurchased(item['name'] ?? '')
                                  ? const Icon(Icons.lock_open, color: Colors.green)
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          item['price'] != null ? '\$${item['price']}' : '',
                                          style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.lock, color: Colors.grey),
                                      ],
                                    ),
                              onTap: () {
                                _showItemDialog(item, Icons.threed_rotation);
                              },
                            ),
                          );
                        }),
                      ] else ...[
                        const Text('3D Avatars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('Currently, there are no avatars avalable, try again later :)',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ],
                  ),
                ),
    );
  }
}
