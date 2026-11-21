import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models.dart';
import '../theme.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../viewmodels/new_order_viewmodel.dart';
import '../widgets.dart';
import 'order_detail_screen.dart';

class NewOrderScreen extends ConsumerStatefulWidget {
  const NewOrderScreen({super.key});

  @override
  ConsumerState<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends ConsumerState<NewOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clienteNombre = TextEditingController();
  final _clienteTelefono = TextEditingController();
  final _marca = TextEditingController();
  final _modelo = TextEditingController();
  final _serie = TextEditingController();
  final _falla = TextEditingController();
  int? _clienteId;
  String _tipo = 'Laptop';

  static const _tipos = ['Laptop', 'Desktop', 'Tablet', 'Celular', 'Otro'];

  @override
  void dispose() {
    _clienteNombre.dispose();
    _clienteTelefono.dispose();
    _marca.dispose();
    _modelo.dispose();
    _serie.dispose();
    _falla.dispose();
    super.dispose();
  }

  void _selectClient(ClientOption? client) {
    setState(() {
      _clienteId = client?.id;
      _clienteNombre.text = client?.nombre ?? '';
      _clienteTelefono.text = client?.telefono ?? '';
    });
  }

  void _reset() {
    _formKey.currentState?.reset();
    for (final controller in [
      _clienteNombre,
      _clienteTelefono,
      _marca,
      _modelo,
      _serie,
      _falla,
    ]) {
      controller.clear();
    }
    setState(() {
      _clienteId = null;
      _tipo = 'Laptop';
    });
    ref.read(newOrderProvider.notifier).reset();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(newOrderProvider.notifier).submit(
          clienteNombre: _clienteNombre.text.trim(),
          clienteTelefono: _clienteTelefono.text.trim(),
          clienteId: _clienteId,
          tipo: _tipo,
          marca: _marca.text.trim(),
          modelo: _modelo.text.trim(),
          numeroSerie: _serie.text.trim(),
          fallaReportada: _falla.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newOrderProvider);
    final clients = ref.watch(clientsProvider).value ?? const [];

    if (state.createdOrderId != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Orden creada')),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle_outline,
                      size: 56, color: AppColors.primaryDark),
                ),
                const SizedBox(height: 22),
                const Text(
                  '¡Orden registrada!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 8),
                Text(
                  'Orden #${state.createdOrderId} creada correctamente. '
                  'El siguiente paso es tomarla y asignar un responsable.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: AppColors.muted),
                ),
                const SizedBox(height: 26),
                FilledButton.icon(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) =>
                          OrderDetailScreen(orderId: state.createdOrderId!),
                    ),
                  ),
                  icon: const Icon(Icons.visibility_outlined),
                  label: const Text('Ver orden creada'),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  onPressed: _reset,
                  child: const Text('Registrar otra orden'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva orden')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            SectionCard(
              title: 'Cliente',
              children: [
                DropdownButtonFormField<int?>(
                  initialValue: _clienteId,
                  decoration: const InputDecoration(
                    labelText: 'Cliente existente (opcional)',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem<int?>(
                      value: null,
                      child: Text('+ Cliente nuevo'),
                    ),
                    for (final client in clients)
                      DropdownMenuItem<int?>(
                        value: client.id,
                        child: Text(
                          '${client.nombre} · ${client.telefono}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      _selectClient(null);
                      return;
                    }
                    _selectClient(
                      clients.where((c) => c.id == value).cast<ClientOption?>().firstOrNull,
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _clienteNombre,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del cliente',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Ingresa el nombre'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _clienteTelefono,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Ingresa un teléfono'
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Equipo',
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _tipo,
                  decoration: const InputDecoration(
                    labelText: 'Tipo de equipo',
                    prefixIcon: Icon(Icons.devices_outlined),
                  ),
                  items: [
                    for (final tipo in _tipos)
                      DropdownMenuItem(value: tipo, child: Text(tipo)),
                  ],
                  onChanged: (value) =>
                      setState(() => _tipo = value ?? 'Laptop'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _marca,
                        decoration: const InputDecoration(labelText: 'Marca'),
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Requerido'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _modelo,
                        decoration: const InputDecoration(labelText: 'Modelo'),
                        textCapitalization: TextCapitalization.words,
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Requerido'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _serie,
                  decoration: const InputDecoration(
                    labelText: 'Número de serie (opcional)',
                    prefixIcon: Icon(Icons.numbers_outlined),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SectionCard(
              title: 'Falla reportada',
              children: [
                TextFormField(
                  controller: _falla,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Describe el problema',
                    alignLabelWithHint: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Icon(Icons.report_problem_outlined),
                    ),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Describe la falla'
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (state.error != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Color(0xFFB42318)),
                ),
              ),
              const SizedBox(height: 12),
            ],
            FilledButton.icon(
              onPressed: state.submitting ? null : _submit,
              icon: state.submitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(state.submitting ? 'Guardando...' : 'Crear orden'),
              style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            ),
          ],
        ),
      ),
    );
  }
}
