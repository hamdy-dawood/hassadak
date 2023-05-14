String? emailValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل البريد الاكتروني !";
  } else if (!(value.endsWith("@gmail.com") ||
      value.endsWith("@admin.com") ||
      value.endsWith("@yahoo.com") ||
      value.endsWith("@outlook.com"))) {
    return "ادخل بريد الكتروني صحيح!";
  } else {
    return null;
  }
}

String? phoneValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل رقم الهاتف !";
  } else if (!(value.startsWith("010") ||
      value.startsWith("011") ||
      value.startsWith("012") ||
      value.startsWith("015"))) {
    return "ادخل رقم الهاتف صحيح !";
  } else if (value.length < 11) {
    return "يجب الا يقل رقم الهاتف عن 11 رقم !";
  } else if (value.length > 11) {
    return "رقم خاطئ !";
  } else {
    return null;
  }
}

String? passwordValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل كلمة المرور !";
  } else {
    return null;
  }
}

String? regPasswordValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل كلمة المرور !";
  } else if (value.length < 9) {
    return "يجب الا تقل كلمة المرور عن 9 رموز !";
  } else {
    return null;
  }
}

String? firstNameValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل الاسم الاول !";
  } else if (value.length < 5) {
    return "يجب الا يقل الاسم الاول عن 5 احرف !";
  } else {
    return null;
  }
}

String? lastNameValidator(value) {
  if (value.isEmpty) {
    return "من فضلك ادخل الاسم الاخير !";
  } else if (value.length < 5) {
    return "يجب الا يقل الاسم الاخير عن 5 احرف !";
  } else {
    return null;
  }
}

String? imageValidator(value) {
  if (value.isEmpty) {
    return 'من فضلك ادخل لينك الصورة !';
  } else {
    return null;
  }
}

String? userNameValidator(value) {
  if (value.isEmpty) {
    return 'من فضلك ادخل اسم المستخدم !';
  } else if (value.length < 9) {
    return "يجب الا يقل اسم المستخدم  عن 9 احرف او ارقام !";
  } else {
    return null;
  }
}
