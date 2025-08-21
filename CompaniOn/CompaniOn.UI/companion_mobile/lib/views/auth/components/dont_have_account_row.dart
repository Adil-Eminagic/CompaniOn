import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Don\'t Have Account?',
            style: TextStyle(color: Colors.white)),
        TextButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
          child: Text('Sign Up'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        )
      ],
    );
  }
}
