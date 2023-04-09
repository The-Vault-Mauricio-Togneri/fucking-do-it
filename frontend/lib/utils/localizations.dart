import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class BaseLocalized {
  String get appName;

  String get buttonAccept;

  String get buttonCancel;

  String get buttonClose;

  String get buttonCompleted;

  String get buttonCopyLink;

  String get buttonCreate;

  String get buttonDelete;

  String get buttonReopen;

  String get buttonSignInWithGoogle;

  String get confirmationDeleteTask;

  String get inputDeadline;

  String get inputDescription;

  String get inputOptional;

  String get inputTags;

  String get inputTitle;

  String get labelAccepted;

  String get labelAssignedToMe;

  String labelCannotBeEmpty(String param1);

  String get labelCreated;

  String labelDeltaDaysFuture(String param1);

  String labelDeltaDaysPast(String param1);

  String get labelDeltaToday;

  String get labelEmpty;

  String get labelInReview;

  String get priorityHigh;

  String get priorityLow;

  String get priorityMedium;
}

class ENLocalized extends BaseLocalized {
  @override
  String get appName => 'Just Fucking Do it';

  @override
  String get buttonAccept => 'Accept';

  @override
  String get buttonCancel => 'Cancel';

  @override
  String get buttonClose => 'Close';

  @override
  String get buttonCompleted => 'Completed';

  @override
  String get buttonCopyLink => 'Copy link';

  @override
  String get buttonCreate => 'Create';

  @override
  String get buttonDelete => 'Delete';

  @override
  String get buttonReopen => 'Reopen';

  @override
  String get buttonSignInWithGoogle => 'Sign in with Google';

  @override
  String get confirmationDeleteTask =>
      'Do you confirm you want to delete the task?';

  @override
  String get inputDeadline => 'Deadline';

  @override
  String get inputDescription => 'Description';

  @override
  String get inputOptional => 'Optional';

  @override
  String get inputTags => 'Tags';

  @override
  String get inputTitle => 'Title';

  @override
  String get labelAccepted => 'Accepted';

  @override
  String get labelAssignedToMe => 'Assigned to me';

  @override
  String labelCannotBeEmpty(String param1) =>
      '${param1.toString()} cannot be empty';

  @override
  String get labelCreated => 'Created';

  @override
  String labelDeltaDaysFuture(String param1) => '${param1.toString()}d';

  @override
  String labelDeltaDaysPast(String param1) => '${param1.toString()}d ago';

  @override
  String get labelDeltaToday => 'Today';

  @override
  String get labelEmpty => 'Empty';

  @override
  String get labelInReview => 'In review';

  @override
  String get priorityHigh => 'High';

  @override
  String get priorityLow => 'Low';

  @override
  String get priorityMedium => 'Medium';
}

class ESLocalized extends BaseLocalized {
  @override
  String get appName => 'Just Fucking Do it';

  @override
  String get buttonAccept => 'Aceptar';

  @override
  String get buttonCancel => 'Cerrar';

  @override
  String get buttonClose => 'Cerrar';

  @override
  String get buttonCompleted => 'Competada';

  @override
  String get buttonCopyLink => 'Copiar enlace';

  @override
  String get buttonCreate => 'Crear';

  @override
  String get buttonDelete => 'Eliminar';

  @override
  String get buttonReopen => 'Reabrir';

  @override
  String get buttonSignInWithGoogle => 'Conectarse con Google';

  @override
  String get confirmationDeleteTask =>
      '¿Confirmas que quieres eliminar la tarea?';

  @override
  String get inputDeadline => 'Fecha límite';

  @override
  String get inputDescription => 'Descripción';

  @override
  String get inputOptional => 'Opcional';

  @override
  String get inputTags => 'Etiquetas';

  @override
  String get inputTitle => 'Título';

  @override
  String get labelAccepted => 'Aceptadas';

  @override
  String get labelAssignedToMe => 'Asignadas a mí';

  @override
  String labelCannotBeEmpty(String param1) =>
      '${param1.toString()} no puede estar vacío';

  @override
  String get labelCreated => 'Creadas';

  @override
  String labelDeltaDaysFuture(String param1) => '${param1.toString()}d';

  @override
  String labelDeltaDaysPast(String param1) => 'hace ${param1.toString()}d';

  @override
  String get labelDeltaToday => 'hoy';

  @override
  String get labelEmpty => 'Vacía';

  @override
  String get labelInReview => 'En revisión';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get priorityLow => 'Baja';

  @override
  String get priorityMedium => 'Media';
}

class Localized {
  static late BaseLocalized get;
  static late Locale current;

  static List<Locale> locales = localized.keys.map(Locale.new).toList();

  static Map<String, BaseLocalized> localized = <String, BaseLocalized>{
    'en': ENLocalized(),
    'es': ESLocalized()
  };

  static bool isSupported(Locale locale) =>
      locales.map((Locale l) => l.languageCode).contains(locale.languageCode);

  static void load(Locale locale) {
    current = locale;
    get = localized[locale.languageCode]!;
  }
}

class CustomLocalizationsDelegate extends LocalizationsDelegate<dynamic> {
  const CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => Localized.isSupported(locale);

  @override
  Future<dynamic> load(Locale locale) {
    Localized.load(locale);
    return SynchronousFuture<dynamic>(Object());
  }

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}
