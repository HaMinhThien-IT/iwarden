import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iWarden/common/autocomplete.dart';
import 'package:iWarden/common/bottom_sheet_2.dart';
import 'package:iWarden/models/location.dart';
import 'package:iWarden/models/site.dart';
import 'package:iWarden/providers/locations.dart';
import 'package:iWarden/theme/color.dart';
import 'package:iWarden/theme/text_theme.dart';
import 'package:iWarden/widgets/location/tab_bar_item.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final siteList = SiteList().sites.toList();

    return Scaffold(
      bottomSheet: BottomSheet2(buttonList: [
        BottomNavyBarItem(
          onPressed: () {},
          icon: SvgPicture.asset('assets/svg/IconNext.svg'),
          label: const Text(
            'Next',
            style: CustomTextStyle.h6,
          ),
        ),
      ]),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(
              bottom: screenHeight > 400 ? screenHeight / 10 : screenHeight / 5,
            ),
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(top: screenHeight / 10),
                  child: ListTile(
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircleAvatar(
                        child: Image.asset('assets/images/avatar.png'),
                      ),
                    ),
                    title: Text(
                      'Welcome Tom Smiths!',
                      style: CustomTextStyle.h6.copyWith(
                        color: ColorTheme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Email: tom.smiths@ukparkingcontrol.com',
                      style: CustomTextStyle.chart.copyWith(
                        color: ColorTheme.grey600,
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Set your location',
                          style: CustomTextStyle.body1.copyWith(
                            color: ColorTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          child: Consumer<Locations>(
                            builder: ((_, location, child) {
                              return AutoCompleteWidget(
                                labelText: const Text('Location'),
                                hintText: 'Select location',
                                controller: _typeAheadController,
                                onSuggestionSelected: (suggestion) {
                                  setState(() {
                                    _typeAheadController.text =
                                        (suggestion as Location).value;
                                  });
                                },
                                itemBuilder: (context, locationItem) {
                                  return ItemDataComplete(
                                    itemData: (locationItem as Location).label,
                                  );
                                },
                                suggestionsCallback: (pattern) {
                                  return location.onSuggest(pattern);
                                },
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TabbarItem(
                          sites: siteList,
                        ),
                      ],
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
