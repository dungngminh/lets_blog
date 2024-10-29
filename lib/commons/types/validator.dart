/// A sealed class representing a generic validator with a value of type [T]
/// and an error of type [E] which extends [ValidatorError].
///
/// The [Validator] class has three constructors:
/// - `Validator.pure`: Represents a pure state with no error and not dirty.
/// - `Validator.valid`: Represents a valid state with no error and dirty.
/// - `Validator.error`: Represents an error state with an optional error and dirty.
///
/// The class contains:
/// - [value]: The value being validated.
/// - [isDirty]: A boolean indicating if the value has been modified.
/// - [error]: An optional error of type [E].
sealed class Validator<T, E extends ValidatorError> {
  const Validator.pure(this.value)
      : error = null,
        isDirty = false;

  const Validator.dirty(this.value)
      : isDirty = true,
        error = null;

  const Validator.error({required this.value, this.error}) : isDirty = true;

  static bool validate(List<Validator> validators) {
    return validators.every((element) => element.isValid);
  }

  final T value;
  final bool isDirty;
  final E? error;
}

/// The [PureValidator], [DirtyValidator], and [ErrorValidator] classes extend
/// [Validator] to represent specific states of validation.
class PureValidator<T, E extends ValidatorError> extends Validator<T, E> {
  const PureValidator(super.value) : super.pure();

  @override
  String toString() {
    return 'PureValidator{value: $value}';
  }
}

/// The [PureValidator], [DirtyValidator], and [ErrorValidator] classes extend
/// [Validator] to represent specific states of validation.
class DirtyValidator<T, E extends ValidatorError> extends Validator<T, E> {
  const DirtyValidator(super.value) : super.dirty();

  @override
  String toString() {
    return 'DirtyValidator{value: $value}';
  }
}

/// The [PureValidator], [DirtyValidator], and [ErrorValidator] classes extend
/// [Validator] to represent specific states of validation.
class ErrorValidator<T, E extends ValidatorError> extends Validator<T, E> {
  const ErrorValidator({required super.value, required E super.error})
      : super.error();

  @override
  String toString() {
    return 'ErrorValidator{value: $value, error: $error}';
  }
}

/// The [ValidatorError] class represents an error with a specific code.
class ValidatorError {
  ValidatorError(this.code);
  final String code;
}

/// The [ValidatorExt] extension provides additional utility methods for
/// [Validator] instances:
extension ValidatorExt<T, E extends ValidatorError> on Validator<T, E> {
  /// Maps the error to a new error of type [E2].
  E2 mapErrorOrNull<E2>(E2 Function(E?) onError) {
    return onError(error);
  }

  /// Checks if the validator is in an error state.
  bool get isError => this is ErrorValidator<T, E>;

  /// Checks if the validator is in a pure state.
  bool get isPure => this is PureValidator<T, E>;

  /// Checks if the validator is in a valid state.
  bool get isDirty => this is DirtyValidator<T, E>;

  bool get isValid => isDirty && !isError;
}
