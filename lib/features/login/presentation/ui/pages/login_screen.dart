import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cleanarchitecture/core/component/button/p_button.dart';
import 'package:cleanarchitecture/core/component/custom_toast/p_toast.dart';
import 'package:cleanarchitecture/core/component/text/p_text.dart';
import 'package:cleanarchitecture/core/component/text_field/p_textfield.dart';
import 'package:cleanarchitecture/core/data/assets_helper/app_svg_icon.dart';
import 'package:cleanarchitecture/core/data/constants/shared_preferences_constants.dart';
import 'package:cleanarchitecture/core/extensions/string_extensions.dart';
import 'package:cleanarchitecture/core/global/global_func.dart';
import 'package:cleanarchitecture/core/global/state/base_state.dart';
import 'package:cleanarchitecture/di.dart';
import 'package:cleanarchitecture/features/login/presentation/bloc/login_bloc.dart';
import '../../../../../core/component/bottom_sheet/custom_bottom_sheet.dart';
import '../../../../../core/component/image/p_image.dart';
import '../../../../../core/data/assets_helper/app_icon.dart';
import '../../../../../core/data/constants/app_colors.dart';
import '../../../../../core/global/enums/global_enum.dart';
import '../../../../../core/services/local_storage/secure_storage/secure_storage_service.dart';
import '../../../data/model/login_request_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final loginBloc = LoginBloc(loginUseCase: getIt());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  late final Future<String?> email;
  late final Future<String?> password;
  @override
  void initState() {
    email = SecureStorageService().read(key: SharPrefConstants.emailKey);
    password = SecureStorageService().read(key: SharPrefConstants.passwordKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (BuildContext context) => loginBloc,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: PImage(
                        source: isDark ? AppIcons.whiteLogo : AppIcons.logo,
                        height: 150,
                        width: 160,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PText(
                      title: 'login'.tr(),
                      size: PSize.text18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 48),
                    BlocBuilder<LoginBloc, BaseState>(
                      builder: (context, state) {
                        return PTextField(
                          hintText: 'username',
                          labelAbove: 'username',
                          controller: emailController,
                          currentFocus: emailFocus,
                          nextFocus: passwordFocus,
                          isFieldRequired: true,
                          isHasSpecialCharcters: true,
                          maxLines: 1,
                          feedback: (value) async {
                            loginBloc.add(
                              ValidationEvent(
                                loginRequestModel: LoginRequestModel(
                                  userName: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                          },
                          validator: (value) {
                            if (value!.length > 50) {
                              return 'input_alert'.tr();
                            } else {
                              return null;
                            }
                          },
                          enabled: (state is! ButtonLoadingState),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LoginBloc, BaseState>(
                      builder: (context, state) {
                        return PTextField(
                          hintText: 'password',
                          labelAbove: 'password',
                          controller: passwordController,
                          currentFocus: passwordFocus,
                          isFieldRequired: true,
                          isHasSpecialCharcters: true,
                          isPassword: true,
                          maxLines: 1,
                          feedback: (value) {
                            loginBloc.add(
                              ValidationEvent(
                                loginRequestModel: LoginRequestModel(
                                  userName: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                          },
                          validator: (value) {
                            if (value!.length > 50) {
                              return 'input_alert'.tr();
                            } else {
                              return null;
                            }
                          },
                          enabled: (state is! ButtonLoadingState),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          // flex: 4,
                          child: PButton<LoginBloc, BaseState>(
                            isButtonAlwaysExist: false,
                            isFirstButton: true,
                            isFitWidth: true,
                            onPressed: () async {
                              bool saveLogin = false;
                              final savedEmail = await email;
                              if (savedEmail == null ||
                                  (savedEmail != emailController.text)) {
                                final result = await showCustomBottomSheet(
                                  body: const PText(
                                    title: 'هل تريد تفعيل السمات الحيوية ؟',
                                  ),
                                  withYesNoActions: true,
                                );
                                if (result == true) {
                                  saveLogin = true;
                                } else {
                                  saveLogin = false;
                                }
                              } else if (savedEmail == emailController.text) {
                                saveLogin = true;
                              }
                              FocusManager.instance.primaryFocus?.unfocus();
                              // if (globalFcmToken.isEmptyOrNull) {
                              //   globalFcmToken =
                              //       await FirebaseMessaging.instance.getToken();
                              // }
                              loginBloc.add(
                                NormalLoginEvent(
                                  saveLogin: saveLogin,
                                  loginRequestModel: LoginRequestModel(
                                    userName: emailController.text.trim(),
                                    password: passwordController.text,
                                    deviceToken: "globalFcmToken",
                                  ),
                                ),
                              );
                              // context.goNamed(AppRouter.initial);
                            },
                            title: 'login'.tr(),
                          ),
                        ),
                        FutureBuilder(
                          future: email,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (!snapshot.data.isEmptyOrNull) {
                                loginBloc.add(const EnableBiometricEvent());
                              }

                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 60,
                                height: 48,
                                child: PButton<LoginBloc, BaseState>(
                                  isButtonAlwaysExist: false,
                                  isFitWidth: true,
                                  fillColor:
                                      isDark
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor,
                                  borderColor:
                                      isDark
                                          ? AppColors.primaryColor
                                          : AppColors.primaryColor,
                                  mainAxisSize: MainAxisSize.max,
                                  isFirstButton: false,
                                  onPressed: () async {
                                    if (snapshot.data.isEmptyOrNull) {
                                      SafeToast.show(
                                        // context: navigatorKey.currentState!.context,
                                        message:
                                            'الرجاء تسجيل الدخول ليتم تفعيل بصمة الوجه "Face ID"',
                                        type: MessageType.warning,
                                        duration: const Duration(seconds: 5),
                                      );
                                      return;
                                    }
                                    loginBloc.add(const BiomatricLoginEvent());
                                  },
                                  icon: SvgPicture.asset(
                                    AppSvgIcons.loginBiomatric,
                                    height: 30,
                                    width: 30,
                                    colorFilter: ColorFilter.mode(
                                      isDark
                                          ? AppColors.whiteColor
                                          : AppColors.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
