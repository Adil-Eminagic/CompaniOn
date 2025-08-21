import 'package:companion_mobile/utils/util.dart';
import 'package:companion_mobile/views/profile/familyMembers/menu_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:companion_mobile/core/components/network_image.dart';
import 'package:companion_mobile/models/familyLink.dart';
import 'package:companion_mobile/models/users.dart';
import 'package:companion_mobile/providers/familyLink_provider.dart';
import 'package:companion_mobile/providers/users_provider.dart';
import 'package:companion_mobile/core/constants/constants.dart';
import 'package:companion_mobile/views/profile/familyMembers/add_basic_user_page.dart';

class BasicUsersMenuPage extends StatefulWidget {
  const BasicUsersMenuPage({super.key});

  @override
  State<BasicUsersMenuPage> createState() => _BasicUsersMenuPageState();
}

class _BasicUsersMenuPageState extends State<BasicUsersMenuPage> {
  late UsersProvider _usersProvider;
  late FamilyLinkProvider _familyLinkProvider;

  List<Users> usersResult = [];
  List<FamilyLink> familyLink = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _usersProvider = context.read<UsersProvider>();
    _familyLinkProvider = context.read<FamilyLinkProvider>();

    _initForm();
  }

  Future<void> _initForm() async {
    usersResult = await _usersProvider.getBasicUsers(loggedUser!.id ?? 0);
    familyLink =
        await _familyLinkProvider.getByFamilyMembeId(loggedUser!.id ?? 0);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:
            (loggedUser!.roleId==2)?
            const Text('Family members', style: TextStyle(color: Colors.white)):
            const Text('Menu', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 4.0,
      ),
      body: isLoading
          ? const SpinKitRing(color: Colors.greenAccent)
          : familyLink.isEmpty
              ? _buildNoFamilyLinksView(context)
              : _buildFamilyLinksView(context),
    );
  }

  Widget _buildNoFamilyLinksView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "There are no family links! Create one below.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: "no-user",
            onPressed: () async {
              var refresh = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddBasicUserPage(),
              ));

              if (refresh == 'reload') {
                _initForm();
              }
            },
            backgroundColor: AppColors.primary,
            splashColor: AppColors.primary,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyLinksView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.only(top: AppDefaults.padding),
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                     onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuContainer(familyMember: usersResult[index]),
        ));
                  },
                  leading: const Icon(
                    Icons.account_circle_sharp,
                    size: 60,
                  ),
                  title: Text(
                      "${usersResult[index].firstName ?? ""} ${usersResult[index].lastName ?? ""}"),
                  subtitle: Text(familyLink[index].kinship ?? ''),
                ),
              );
            },
            itemCount: usersResult.length,
            separatorBuilder: (context, index) => const Divider(thickness: 0.2),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              heroTag: "all-basic",
              onPressed: () async {
                var refresh =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddBasicUserPage(),
                ));

                if (refresh == 'reload') {
                  _initForm();
                }
              },
              backgroundColor: AppColors.primary,
              splashColor: AppColors.primary,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class FamilyMemberTile extends StatelessWidget {
  const FamilyMemberTile(
      {super.key,
      this.imageLink,
      required this.title,
      required this.subtitle,
      required this.time,
      this.familyMmeber});

  final String? imageLink;
  final String title;
  final String subtitle;
  final String time;
  final Users? familyMmeber;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MenuContainer(familyMember: familyMmeber),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: imageLink != null
                  ? AspectRatio(
                      aspectRatio: 1 / 1,
                      child: NetworkImageWithLoader(imageLink!),
                    )
                  : null,
              title: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 4),
                  Text(subtitle),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 86),
              child: Divider(thickness: 0.1),
            ),
          ],
        ),
      ),
    );
  }
}
