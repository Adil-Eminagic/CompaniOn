import 'package:companion_mobile/models/location.dart';
import 'package:companion_mobile/models/search_result.dart';
import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/providers/location_provider.dart';
import 'package:companion_mobile/screens/location_tracker_screen.dart';
import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/utils/util_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/components/app_back_button.dart';
import '../../../core/constants/constants.dart';
import '../../../core/components/app_settings_tile.dart';

class LocationHistoryScreen extends StatefulWidget {
  const LocationHistoryScreen({super.key, this.familyMember});
  final Users? familyMember;

  @override
  State<LocationHistoryScreen> createState() => _LocationHistoryScreenState();
}

class _LocationHistoryScreenState extends State<LocationHistoryScreen> {
  LocationProvider _locationProvider = LocationProvider();

  bool isLoading = true;

  SearchResult<Location>? result;

  @override
  void initState() {
    super.initState();
    _locationProvider = context.read<LocationProvider>();
    _initForm();
  }

  Future<void> _initForm() async {
    try {
      var userId =
          loggedUser?.roleId == 1 ? loggedUser?.id : widget.familyMember?.id;

      result = await _locationProvider.getPaged(filter: {
        'userId': userId ?? 0,
        'OrderByCreatedDate': true,
        'pageSize': 100000,
      });
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      alertBox(context, "Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(
          'Locations of ${widget.familyMember?.firstName ?? ""} ${widget.familyMember?.lastName ?? ""}',
        ),
      ),
      backgroundColor: AppColors.cardColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(AppDefaults.padding),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDefaults.padding,
            vertical: AppDefaults.padding * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: AppDefaults.borderRadius,
          ),
          child: (result == null || result!.items.isEmpty)
              ? const Center(child: Text("No Locations"))
              : (isLoading
                  ? const SpinKitCircle(color: Colors.green)
                  : Column(
                      children: [
                        for (var location in result!.items)
                          AppSettingsListTile(
                            label:
                                'On ${DateFormat('dd.MM.yyyy HH:mm').format(location.createdAt!)}',
                            trailing: SvgPicture.asset(AppIcons.right),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LocationTrackerScreen(
                                    familyMember: null,
                                    locationId: location?.id),
                              ));
                            },
                          ),
                      ],
                    )),
        ),
      ),
    );
  }
}
