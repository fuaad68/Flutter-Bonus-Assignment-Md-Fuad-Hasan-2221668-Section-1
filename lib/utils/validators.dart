/// Custom validators for task management forms
class CustomValidators {
  /// Validates task title - must not be empty and have minimum length
  static String? validateTaskTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a task title';
    }
    if (value.length < 3) {
      return 'Task title must be at least 3 characters long';
    }
    if (value.length > 100) {
      return 'Task title must not exceed 100 characters';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    else if(!RegExp(r'^\d{11}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  static String? validateAssignedTo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the name of the person assigned to the task';
    }
    return null;
  }


  /// Validates task description - must have meaningful content
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a task description';
    }

    if (value.length < 10) {
      return 'Description must be at least 10 characters long';
    }
    if (value.length > 500) {
      return 'Description must not exceed 500 characters';
    }
    return null;
  }




}