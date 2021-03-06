import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shoplocalto/blocs/bloc.dart';
import 'package:shoplocalto/configs/config.dart';
import 'package:shoplocalto/screens/screen.dart';
import 'package:shoplocalto/screens/setting/settiing_controller.dart';
import 'package:shoplocalto/utils/language.dart';
import 'package:shoplocalto/utils/utils.dart';
import 'package:shoplocalto/widgets/widget.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() {
    return _SettingState();
  }
}

class _SettingState extends State<Setting> {
  bool _receiveNotification = false;
  DarkOption _darkOption = AppTheme.darkThemeOption;
  ThemeBloc _themeBloc;
  final SettingController _settingController =
  Get.put(SettingController());

  @override
  void initState() {
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
    super.initState();

  }

  ///On Change Dark Option
  void _onChangeDarkOption() {
    _themeBloc.add(ChangeTheme(darkOption: _darkOption));
  }

  ///On navigation
  void _onNavigate(String route) {
    Navigator.pushNamed(context, route);
  }

  ///Show notification received
  Future<void> _showDarkModeSetting() async {
    setState(() {
      _darkOption = AppTheme.darkThemeOption;
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Translate.of(context).translate('dark_mode')),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.dynamic),
                        ),
                      ),
                      value: _darkOption == DarkOption.dynamic,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.dynamic;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOn),
                        ),
                      ),
                      value: _darkOption == DarkOption.alwaysOn,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.alwaysOn;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text(
                        Translate.of(context).translate(
                          UtilTheme.exportLangTheme(DarkOption.alwaysOff),
                        ),
                      ),
                      value: _darkOption == DarkOption.alwaysOff,
                      onChanged: (bool value) {
                        setState(() {
                          _darkOption = DarkOption.alwaysOff;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(Translate.of(context).translate('close')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              child: Text(Translate.of(context).translate('apply')),
              onPressed: () {
                _onChangeDarkOption();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('setting'),
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
          ),
          children: <Widget>[
            // AppListTitle(
            //   title: Translate.of(context).translate('language'),
            //   onPressed: () {
            //     _onNavigate(Routes.changeLanguage);
            //   },
            //   trailing: Row(
            //     children: <Widget>[
            //       Text(
            //         UtilLanguage.getGlobalLanguageName(
            //           AppLanguage.defaultLanguage.languageCode,
            //         ),
            //         style: Theme.of(context).textTheme.bodyText1,
            //       ),
            //       RotatedBox(
            //         quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
            //         child: Icon(
            //           Icons.keyboard_arrow_right,
            //           textDirection: TextDirection.ltr,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            AppListTitle(
              title: Translate.of(context).translate('notification'),
              trailing: Switch(
                value: _settingController.notification.value,
                onChanged: (value) {
                  setState(() {

                      if(_settingController.notification == true.obs){
                        _settingController.notification = false.obs;
                      }else if(_settingController.notification == false.obs){
                        _settingController.notification = true.obs;
                      }


                  });
                },
              ),
            ),
            AppListTitle(
              title: Translate.of(context).translate('theme'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThemeSetting()),
                );

              },
              trailing: Container(
                margin: EdgeInsets.only(right: 10),
                width: 16,
                height: 16,
                color: Theme.of(context).primaryColor,
              ),
            ),
            AppListTitle(
              title: Translate.of(context).translate('dark_mode'),
              onPressed: _showDarkModeSetting,
              trailing: Row(
                children: <Widget>[
                  Text(
                    Translate.of(context).translate(
                      UtilTheme.exportLangTheme(AppTheme.darkThemeOption),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
            ),
            // AppListTitle(
            //   title: Translate.of(context).translate('font'),
            //   onPressed: () {
            //     _onNavigate(Routes.fontSetting);
            //   },
            //   trailing: Row(
            //     children: <Widget>[
            //       Text(
            //         AppTheme.currentFont,
            //         style: Theme.of(context).textTheme.bodyText1,
            //       ),
            //       RotatedBox(
            //         quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
            //         child: Icon(
            //           Icons.keyboard_arrow_right,
            //           textDirection: TextDirection.ltr,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            AppListTitle(
              title: Translate.of(context).translate('version'),
              onPressed: () {},
              trailing: Row(
                children: <Widget>[
                  Text(
                    Application.version,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  RotatedBox(
                    quarterTurns: UtilLanguage.isRTL() ? 2 : 0,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              border: false,
            ),
          ],
        ),
      ),
    );
  }
}
