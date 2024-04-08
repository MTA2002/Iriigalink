import 'package:flutter/material.dart';
import 'package:irrigalink/generated/l10n.dart';
import 'package:irrigalink/models/distributor_model.dart';
import 'package:irrigalink/screens/distributor/distributor_home_screen.dart';
import 'package:irrigalink/services/distributorService.dart';

class DistDrawer extends StatefulWidget {
  const DistDrawer({super.key});

  @override
  State<DistDrawer> createState() => _DistDrawerState();
}

class _DistDrawerState extends State<DistDrawer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Distributor>(
        stream: DistributorService.getDistStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Distributor distributor = snapshot.data!;
            List formattedPhoneNumber = ['+'];
            for (int i = 1;
                i < distributor.phoneNumber.characters.length;
                i++) {
              formattedPhoneNumber
                  .add(distributor.phoneNumber.characters.characterAt(i));
              if (i % 3 == 0) {
                formattedPhoneNumber.add('-');
              }
            }
            formattedPhoneNumber[formattedPhoneNumber.length - 1] = '';
            return ListView(
              children: [
                SizedBox(
                  height: 190,
                  child: UserAccountsDrawerHeader(
                    margin: const EdgeInsets.all(0),
                    accountName: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: Text(
                        distributor.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(137, 10, 3, 3),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    accountEmail: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        formattedPhoneNumber.join(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(137, 10, 3, 3),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      minRadius: 10,
                      backgroundImage: NetworkImage(distributor.profilePicture),
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(170, 217, 187, 1),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                drawerButton(
                  () {
                    DistributorHomePage.setIndex(context, 0);
                    Navigator.pop(context); // Close the drawer
                  },
                  S.of(context).drawer_home,
                  const Icon(
                    Icons.home,
                    size: 24,
                  ),
                ),
                drawerButton(
                  () {
                    Navigator.of(context).pushNamed('/manage_profile_dist',
                        arguments: distributor);
                  },
                  S.of(context).manageProfile,
                  const ImageIcon(
                    AssetImage(
                        'images/user (2) 1.png'), // Replace with the actual path
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                drawerButton(
                  () {
                    Navigator.of(context).pushNamed('/change_language');
                  },
                  S.of(context).drawer_change_language,
                  const Icon(
                    Icons.language,
                    size: 24,
                  ),
                ),
                drawerButton(
                  () {
                    Navigator.of(context).pushNamed('/contact_us');
                  },
                  S.of(context).contactUs,
                  const Icon(Icons.mail),
                ),
                drawerButton(
                  () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Logout"),
                            content:
                                const Text("Are you sure you want to log out?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(false); // User chose not to logout
                                },
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  bool hasLogedOut = await DistributorService
                                      .logoutDistributor();
                                  if (hasLogedOut) {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                      'routeName',
                                      (Route<dynamic> route) => false,
                                    );
                                  }
                                },
                                child: const Text("Logout"),
                              ),
                            ],
                          );
                        });
                  },
                  S.of(context).logout,
                  const Icon(Icons.logout),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Text('Error: ${snapshot.error}');
          }
        });
  }

  TextButton drawerButton(Function()? onPressed, String text, Widget iconData) {
    return TextButton(
      onPressed: onPressed,
      child: ListTile(
        leading: iconData,
        title: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: const Icon(Icons.chevron_right, size: 30),
      ),
    );
  }
}
