import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../models/recurring_payment.dart';
import '../../../state/recurring_payments/recurring_payment_provider.dart';
import '../../../state/groups/group_provider.dart';

class RecurringPaymentFormScreen extends HookConsumerWidget {
  final RecurringPayment? payment;
  const RecurringPaymentFormScreen({super.key, this.payment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final descController =
        useTextEditingController(text: payment?.description ?? '');
    final amountController = useTextEditingController(
        text: payment != null ? payment!.amount.toString() : '');
    final dateController = useTextEditingController(
        text: payment?.nextDate != null
            ? DateFormat('yyyy-MM-dd').format(payment!.nextDate!)
            : '');

    final frequency = useState<String?>(payment?.frequency);
    final nextDate = useState<DateTime?>(payment?.nextDate);
    final groupId = useState<String?>(payment?.groupId);

    final rpState = ref.watch(recurringPaymentNotifierProvider);
    final groupsState = ref.watch(groupNotifierProvider);

    useEffect(() {
      ref.read(groupNotifierProvider.notifier).fetchGroups();
      return null;
    }, const []);

    Future<void> pickDate() async {
      final initial = nextDate.value ?? DateTime.now();
      final picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        nextDate.value = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(payment == null
              ? 'Nuevo Pago Recurrente'
              : 'Editar Pago Recurrente')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Monto'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: frequency.value,
              decoration: const InputDecoration(labelText: 'Frecuencia'),
              items: const [
                DropdownMenuItem(value: 'weekly', child: Text('Semanal')),
                DropdownMenuItem(value: 'monthly', child: Text('Mensual')),
                DropdownMenuItem(value: 'yearly', child: Text('Anual')),
              ],
              onChanged: (v) => frequency.value = v,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: const InputDecoration(labelText: 'Próxima fecha'),
              onTap: pickDate,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: groupId.value,
              decoration: const InputDecoration(labelText: 'Grupo'),
              items: groupsState.groups
                  .map((g) =>
                      DropdownMenuItem(value: g.id, child: Text(g.name)))
                  .toList(),
              onChanged: payment == null ? (v) => groupId.value = v : null,
            ),
            const SizedBox(height: 20),
            if (rpState.error != null) ...[
              Text(rpState.error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
            ],
            ElevatedButton(
              onPressed: rpState.isLoading
                  ? null
                  : () async {
                      final amount =
                          double.tryParse(amountController.text) ?? 0;
                      if (payment == null) {
                        await ref
                            .read(recurringPaymentNotifierProvider.notifier)
                            .createRecurringPayment(
                              groupId: groupId.value ?? '',
                              description: descController.text,
                              amount: amount,
                              frequency: frequency.value ?? '',
                              nextDate: nextDate.value,
                            );
                      } else {
                        await ref
                            .read(recurringPaymentNotifierProvider.notifier)
                            .updateRecurringPayment(
                              payment!.id,
                              description: descController.text,
                              amount: amount,
                              frequency: frequency.value,
                              nextDate: nextDate.value,
                            );
                      }
                      final error =
                          ref.read(recurringPaymentNotifierProvider).error;
                      if (context.mounted && error == null) {
                        context.pop();
                      }
                    },
              child: rpState.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}

