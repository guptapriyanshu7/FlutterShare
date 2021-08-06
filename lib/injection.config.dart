// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_messaging/firebase_messaging.dart' as _i5;
import 'package:firebase_storage/firebase_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth/auth_bloc.dart' as _i19;
import 'application/auth/sign_in_form/sign_in_form_bloc.dart' as _i17;
import 'application/post/post_bloc.dart' as _i14;
import 'application/post/save_post/save_post_bloc.dart' as _i16;
import 'application/user_actions/user_actions_bloc.dart' as _i18;
import 'domain/auth/i_auth_facade.dart' as _i8;
import 'domain/posts/i_post_repository.dart' as _i10;
import 'domain/user_actions/i_user_actions_repository.dart' as _i12;
import 'infrastructure/auth/firebase_auth_facade.dart' as _i9;
import 'infrastructure/core/firebase_injectable_module.dart' as _i20;
import 'infrastructure/post/post_repository_impl.dart' as _i11;
import 'infrastructure/user_actions/user_actions_repository_impl.dart' as _i13;
import 'presentation/routes/router.dart' as _i21;
import 'presentation/routes/router.gr.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final routerInjectableModule = _$RouterInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.firestore);
  gh.lazySingleton<_i5.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  gh.lazySingleton<_i6.FirebaseStorage>(
      () => firebaseInjectableModule.firebaseStorage);
  gh.lazySingleton<_i7.GoogleSignIn>(
      () => firebaseInjectableModule.googleSignIn);
  gh.lazySingleton<_i8.IAuthFacade>(() => _i9.FirebaseAuthFacade(
      get<_i3.FirebaseAuth>(),
      get<_i4.FirebaseFirestore>(),
      get<_i7.GoogleSignIn>(),
      get<_i5.FirebaseMessaging>()));
  gh.lazySingleton<_i10.IPostRepository>(() => _i11.PostRepositoryImpl(
      get<_i4.FirebaseFirestore>(), get<_i6.FirebaseStorage>()));
  gh.lazySingleton<_i12.IUserActionsRepository>(
      () => _i13.UserActionsRepositoryImpl(get<_i4.FirebaseFirestore>()));
  gh.factory<_i14.PostBloc>(() => _i14.PostBloc(get<_i10.IPostRepository>()));
  gh.lazySingleton<_i15.Router>(() => routerInjectableModule.router);
  gh.factory<_i16.SavePostBloc>(
      () => _i16.SavePostBloc(get<_i10.IPostRepository>()));
  gh.factory<_i17.SignInFormBloc>(
      () => _i17.SignInFormBloc(get<_i8.IAuthFacade>()));
  gh.factory<_i18.UserActionsBloc>(
      () => _i18.UserActionsBloc(get<_i12.IUserActionsRepository>()));
  gh.factory<_i19.AuthBloc>(() => _i19.AuthBloc(get<_i8.IAuthFacade>()));
  return get;
}

class _$FirebaseInjectableModule extends _i20.FirebaseInjectableModule {}

class _$RouterInjectableModule extends _i21.RouterInjectableModule {}
