
import 'package:tech_pay/features/home/domain/entities/transaccion_entity.dart';
import 'package:tech_pay/features/home/domain/repositories/transaccion_repository.dart';

class GetTransaccionesUseCase {
  final TransaccionRepository repository;

  GetTransaccionesUseCase(this.repository);

  Future<List<TransaccionEntity>> call() async {
    return await repository.getTransacciones();
  }
}