import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/shared_prefs_provider.dart';
import 'package:flutter_pos/utils/tab_provider.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:provider/provider.dart';
import '../../service/api.dart';
import '../../model/contact_us_model.dart';

class ContactUsProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var mobileController = TextEditingController();
  var contentController = TextEditingController();
  var _isLoading = false;
  bool get isLoading => _isLoading;

  init(BuildContext context) {
    var prefs = Provider.of<SharedPrefsProvider>(context, listen: false).prefs;
    nameController.text = prefs.getString('user_name');
    emailController.text = prefs.getString('user_email');
    mobileController.text = prefs.getString('mobile');
  }

  String nameValidate(String v, context) {
    if (v.isEmpty) {
      return '${getTransrlate(context, 'name_required')}';
    }
    return null;
  }

  String emailValidate(String v, context) {
    if (v.isEmpty) {
      return '${getTransrlate(context, 'email_required')}';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(v)) {
      return getTransrlate(context, 'invalidemail');
    }
    return null;
  }

  String mobileValidate(String v, context) {
    if (v.isEmpty) {
      return '${getTransrlate(context, 'phone_required')}';
    }
    if (v.length < 9) {
      return "${getTransrlate(context, 'shorterphone')}";
    }
    return null;
  }

  String contentValidate(String v, context) {
    if (v.isEmpty) {
      return '${getTransrlate(context, 'content_required')}';
    }

    return null;
  }

  Future<void> contactUs(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var prefs = Provider.of<SharedPrefsProvider>(context, listen: false).prefs;
    var isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    var response = await API(context).post(
      'contact',
      {
        'email': emailController.text,
        'name': nameController.text,
        'mobile': mobileController.text,
        'content': contentController.text,
        'user_id': prefs.getInt('user_id'),
      },
    );
    _isLoading = false;
    notifyListeners();
    if (response != null) {
      var model = ContactUsModel.fromJson(response);
      if (model.status) {
        showDialog(
            context: context,
            builder: (_) => ResultOverlay(
                  '${model.message}',
                  success: true,
                )).whenComplete(() {
          Provider.of<TabProvider>(context, listen: false).toHome();
        });
      } else {
        showDialog(
            context: context,
            builder: (_) => ResultOverlay(
                  '${model.message}',
                  success: false,
                )).whenComplete(() {});
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
