import 'package:flutter/material.dart';


class IntroLoginBackgroundWrapper extends StatelessWidget {
  const IntroLoginBackgroundWrapper({
    super.key,
    required this.imageURL,
  });

  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return _NetworkImageWithLoader(
      imageURL: imageURL,
    );
  }
}

class _NetworkImageWithLoader extends StatefulWidget {
  final String imageURL;

  const _NetworkImageWithLoader({required this.imageURL});

  @override
  _NetworkImageWithLoaderState createState() => _NetworkImageWithLoaderState();
}

class _NetworkImageWithLoaderState extends State<_NetworkImageWithLoader> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image loaded from network
        Image.network(
          widget.imageURL,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              setState(() {
                _isLoading = false;
              });
              return child; // Image is loaded
            } else {
              setState(() {
                _isLoading = true;
              });
              return const Skeleton(); // Placeholder while loading
            }
          },
          errorBuilder: (context, error, stackTrace) {
            setState(() {
              _hasError = true;
            });
            return const Icon(Icons.error); // Error widget
          },
        ),
        // Gradient overlay
        Positioned(
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black12.withOpacity(0.1),
                  Colors.black12,
                  Colors.black54,
                  Colors.black54,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IntroLoginBody extends StatelessWidget {
  const _IntroLoginBody({
    required this.image,
  });

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
