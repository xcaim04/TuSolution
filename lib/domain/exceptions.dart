/// Errores de reglas de negocio: la UI los traduce a mensajes para el técnico.
sealed class WorkshopException implements Exception {
  const WorkshopException(this.message);

  final String message;

  @override
  String toString() => message;
}

class InvalidTransitionException extends WorkshopException {
  const InvalidTransitionException(String from, String to)
      : super('No se puede cambiar de "$from" a "$to".');
}

class AlreadyAssignedException extends WorkshopException {
  const AlreadyAssignedException()
      : super('Otro técnico ya tomó esta orden. Actualiza la lista.');
}

class OrderNotEditableException extends WorkshopException {
  const OrderNotEditableException(String state)
      : super('La orden está $state. Solo se puede editar en reparación.');
}

class InsufficientStockException extends WorkshopException {
  const InsufficientStockException(String part, int available, int requested)
      : super(
          'Existencias insuficientes de $part: hay $available y se piden $requested.',
        );
}

class CannotCancelStartedException extends WorkshopException {
  const CannotCancelStartedException()
      : super(
          'No se puede cancelar: la orden ya tiene trabajos o repuestos registrados.',
        );
}

class ValidationException extends WorkshopException {
  const ValidationException(super.message);
}

class NotFoundException extends WorkshopException {
  const NotFoundException(this.entity)
      : super('No se encontró $entity.');

  final String entity;
}
