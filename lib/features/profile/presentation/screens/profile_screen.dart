import 'package:crafty_bay/features/auth/presentation/providers/auth_controller.dart';
import 'package:crafty_bay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:crafty_bay/features/common/presentation/widget/center_circular_progress.dart';
import 'package:crafty_bay/features/common/presentation/widget/snack_bar_message.dart';
import 'package:crafty_bay/features/product_review/presentation/providers/update_review_provider.dart';
import 'package:crafty_bay/features/profile/data/update_profile_param.dart';
import 'package:crafty_bay/features/profile/presentation/providers/update_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String name = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _emailNameTEController = TextEditingController();
  final TextEditingController _phoneNameTEController = TextEditingController();
  final TextEditingController _cityNameTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UpdateProfileProvider _updateProfileProvider = UpdateProfileProvider();

  @override
  void initState() {
    super.initState();

    _firstNameTEController.text = AuthController.userModel!.firstName;
    _lastNameTEController.text = AuthController.userModel!.lastName;
    _emailNameTEController.text = AuthController.userModel!.email;
    _phoneNameTEController.text = AuthController.userModel!.phone;
    _cityNameTEController.text = AuthController.userModel!.city;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _updateProfileProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                  Center(child: CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 70,),)),
                  SizedBox(height: 8,),
          
                  TextFormField(
                    controller: _firstNameTEController,
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'input first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _lastNameTEController,
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'input last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailNameTEController,
                    enabled: false,
                  ),
                  TextFormField(
                    controller: _phoneNameTEController,
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'input phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cityNameTEController,
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'input city';
                      }
                      return null;
                    },
                  ),
          
                  SizedBox(height: 8,),
                  Consumer<UpdateProfileProvider>(
                    builder: (context, _, _) {
                      if(_updateProfileProvider.updateProfileProviderInProgress){
                        return CenterCircularProgress();
                      }

                      return FilledButton(onPressed: _onTapUpdateProfileButton,
                          child: Text('Update Profile'));
                    }
                  ),
                  SizedBox(height: 100,),
                  FilledButton(style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ), onPressed: _onTapLogoutButton, child: Text('Logout')),
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onTapUpdateProfileButton() async {
    if (_formKey.currentState!.validate()) {
      bool isSucess = await _updateProfileProvider.updateProfile(
          UpdateProfileParam(firstName: _firstNameTEController.text.trim(),
              lastName: _lastNameTEController.text.trim(),
              phone: _phoneNameTEController.text.trim(),
              city: _cityNameTEController.text.trim()));

      if(isSucess){
        showSnackBarMessage(context, 'Profile Update Successful!');
      }else{
        showSnackBarMessage(context, _updateProfileProvider.errorMessage!);
      }
    }

  }


  Future<void> _onTapLogoutButton() async {
    await AuthController.clearUserData();
    Navigator.pushNamed(context, SignInScreen.name);
  }
}
