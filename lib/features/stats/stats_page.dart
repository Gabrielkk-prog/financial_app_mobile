import 'package:financial_app_project/commom/constants/app_colors.dart';
import 'package:financial_app_project/commom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  String _selectedPeriod = 'Este mês';

  @override
  Widget build(BuildContext context) {
    // Resumo visual enquanto as transações ainda não possuem persistência.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estatísticas'),
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          DropdownButtonFormField<String>(
            initialValue: _selectedPeriod,
            decoration: const InputDecoration(labelText: 'Período'),
            items: const [
              DropdownMenuItem(value: 'Esta semana', child: Text('Esta semana')),
              DropdownMenuItem(value: 'Este mês', child: Text('Este mês')),
              DropdownMenuItem(value: 'Este ano', child: Text('Este ano')),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _selectedPeriod = value);
            },
          ),
          const SizedBox(height: 24),
          _SummaryCard(
            title: 'Receitas',
            value: 'R\$ 0,00',
            icon: Icons.trending_up,
            color: AppColors.green,
          ),
          const SizedBox(height: 12),
          _SummaryCard(
            title: 'Despesas',
            value: 'R\$ 0,00',
            icon: Icons.trending_down,
            color: AppColors.red,
          ),
          const SizedBox(height: 28),
          Text('Transações por categoria', style: AppTextStyles.mediumText18),
          const SizedBox(height: 12),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text('Nenhuma transação registrada neste período.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        trailing: Text(value, style: AppTextStyles.mediumText18),
      ),
    );
  }
}
