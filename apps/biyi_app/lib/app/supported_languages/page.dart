import 'package:biyi_app/generated/locale_keys.g.dart';
import 'package:biyi_app/utilities/language_util.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/language_label/language_label.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:influxui/influxui.dart';
import 'package:preference_list/preference_list.dart';

class SupportedLanguagesPage extends StatefulWidget {
  const SupportedLanguagesPage({
    super.key,
    this.selectedLanguage,
  });

  final String? selectedLanguage;

  @override
  State<StatefulWidget> createState() => _SupportedLanguagesPageState();
}

class _SupportedLanguagesPageState extends State<SupportedLanguagesPage> {
  String? _selectedLanguage;

  @override
  void initState() {
    _selectedLanguage = widget.selectedLanguage;
    super.initState();
  }

  void _handleClickOk() {
    context.pop<String?>(_selectedLanguage);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: Text(
        LocaleKeys.app_supported_languages_title.tr(),
      ),
      actions: [
        Button(
          label: LocaleKeys.ok.tr(),
          variant: ButtonVariant.subtle,
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        PreferenceListSection(
          header: Text(
            LocaleKeys.app_supported_languages_all_title.tr(),
          ),
          children: [
            for (var supportedLanguage in kSupportedLanguages)
              PreferenceListTile(
                title: LanguageLabel(supportedLanguage),
                additionalInfo: _selectedLanguage == supportedLanguage
                    ? Icon(
                        FluentIcons.checkmark_circle_16_filled,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  _selectedLanguage = supportedLanguage;
                  setState(() {});
                },
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
