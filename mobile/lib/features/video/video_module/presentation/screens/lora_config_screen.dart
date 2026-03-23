import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../../domain/entities/video_content_entity.dart';

// ── LoRA Config Screen ──────────────────────────────────────────
// AI model fine-tuning konfigürasyonu. LoRA tipi, güç, adım sayısı,
// öğrenme hızı, tetikleyici kelime ve eğitim parametreleri.

class LoRAConfigScreen extends StatefulWidget {
  final VideoContentEntity? video;
  final LoRAConfig? existing;
  const LoRAConfigScreen({super.key, this.video, this.existing});

  @override
  State<LoRAConfigScreen> createState() => _LoRAConfigScreenState();
}

class _LoRAConfigScreenState extends State<LoRAConfigScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  final _formKey = GlobalKey<FormState>();

  // Form fields
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _triggerCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();

  LoRAType _type = LoRAType.style;
  double _strength = 0.8;
  int _steps = 1000;
  double _learningRate = 0.0001;
  bool _isTraining = false;
  double _trainingProgress = 0.0;
  LoRAStatus _loraStatus = LoRAStatus.training;

  // Advanced params
  int _batchSize = 4;
  int _epochs = 10;
  double _textEncoderLr = 0.00005;
  bool _useXformers = true;
  bool _savePrecision = true;
  String _scheduler = 'cosine';
  int _warmupSteps = 100;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    if (widget.existing != null) {
      final e = widget.existing!;
      _nameCtrl.text = e.name;
      _descCtrl.text = e.description;
      _triggerCtrl.text = e.triggerWord ?? '';
      _tagsCtrl.text = e.tags.join(', ');
      _type = e.type;
      _strength = e.strength;
      _steps = e.steps;
      _learningRate = e.learningRate;
      _loraStatus = LoRAStatus.ready;
    }
  }

  @override
  void dispose() {
    _tabs.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _triggerCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  void _startTraining() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isTraining = true; _trainingProgress = 0; _loraStatus = LoRAStatus.training; });
    // Simulated training progress
    for (int i = 0; i <= 100; i += 2) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (mounted) setState(() => _trainingProgress = i / 100);
    }
    if (mounted) setState(() { _isTraining = false; _loraStatus = LoRAStatus.ready; });
    if (mounted) ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${_nameCtrl.text}" LoRA eğitimi tamamlandı!'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existing != null ? 'LoRA Düzenle' : 'Yeni LoRA Konfigürasyonu'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Temel Ayarlar'),
            Tab(text: 'Eğitim Parametreleri'),
            Tab(text: 'Durum & Test'),
          ],
        ),
        actions: [
          if (!_isTraining)
            FilledButton.icon(
              onPressed: _startTraining,
              icon: const Icon(Icons.play_arrow, size: 18),
              label: const Text('Eğit'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                visualDensity: VisualDensity.compact,
              ),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Form(
        key: _formKey,
        child: TabBarView(
          controller: _tabs,
          children: [
            _BasicTab(
              nameCtrl: _nameCtrl, descCtrl: _descCtrl,
              triggerCtrl: _triggerCtrl, tagsCtrl: _tagsCtrl,
              type: _type, strength: _strength,
              onTypeChanged: (v) => setState(() => _type = v),
              onStrengthChanged: (v) => setState(() => _strength = v),
            ),
            _TrainingTab(
              steps: _steps, learningRate: _learningRate,
              batchSize: _batchSize, epochs: _epochs,
              textEncoderLr: _textEncoderLr, useXformers: _useXformers,
              savePrecision: _savePrecision, scheduler: _scheduler,
              warmupSteps: _warmupSteps,
              onStepsChanged: (v) => setState(() => _steps = v),
              onLrChanged: (v) => setState(() => _learningRate = v),
              onBatchChanged: (v) => setState(() => _batchSize = v),
              onEpochsChanged: (v) => setState(() => _epochs = v),
              onXformersChanged: (v) => setState(() => _useXformers = v),
              onPrecisionChanged: (v) => setState(() => _savePrecision = v),
              onSchedulerChanged: (v) => setState(() => _scheduler = v),
              onWarmupChanged: (v) => setState(() => _warmupSteps = v),
            ),
            _StatusTab(
              status: _loraStatus, isTraining: _isTraining,
              progress: _trainingProgress, steps: _steps,
              currentStep: (_trainingProgress * _steps).round(),
              onTest: () => _showTestDialog(context),
              onDeploy: () => _deploy(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showTestDialog(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('LoRA Test'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Test prompt girin:'),
        const SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(
            hintText: _triggerCtrl.text.isNotEmpty
                ? 'Örn: ${_triggerCtrl.text}, modern villa...'
                : 'Bir prompt girin',
            border: const OutlineInputBorder(),
          ),
          maxLines: 3,
        ),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
        FilledButton(onPressed: () { Navigator.pop(ctx); }, child: const Text('Test Et')),
      ],
    ));
  }

  void _deploy(BuildContext context) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.rocket_launch, color: Colors.deepPurple, size: 40),
      title: const Text('LoRA Modeli Deploy Et'),
      content: Text('"${_nameCtrl.text}" modelini production\'a almak istediğinize emin misiniz?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('İptal')),
        FilledButton(onPressed: () {
          Navigator.pop(ctx);
          setState(() => _loraStatus = LoRAStatus.deployed);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('LoRA modeli deploy edildi'), backgroundColor: Colors.green),
          );
        }, child: const Text('Deploy Et')),
      ],
    ));
  }
}

// ── Basic Settings Tab ─────────────────────────────────────────
class _BasicTab extends StatelessWidget {
  final TextEditingController nameCtrl, descCtrl, triggerCtrl, tagsCtrl;
  final LoRAType type;
  final double strength;
  final void Function(LoRAType) onTypeChanged;
  final void Function(double) onStrengthChanged;

  const _BasicTab({
    required this.nameCtrl, required this.descCtrl,
    required this.triggerCtrl, required this.tagsCtrl,
    required this.type, required this.strength,
    required this.onTypeChanged, required this.onStrengthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SectionHeader('Model Bilgileri'),
        TextFormField(
          controller: nameCtrl,
          decoration: const InputDecoration(labelText: 'Model Adı *', prefixIcon: Icon(Icons.label), border: OutlineInputBorder()),
          validator: (v) => v?.isEmpty == true ? 'Model adı zorunlu' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: descCtrl,
          decoration: const InputDecoration(labelText: 'Açıklama', prefixIcon: Icon(Icons.notes), border: OutlineInputBorder()),
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        _SectionHeader('LoRA Türü'),
        Wrap(
          spacing: 8, runSpacing: 8,
          children: LoRAType.values.map((t) => ChoiceChip(
            label: Text(t.name, style: const TextStyle(fontSize: 13)),
            selected: type == t,
            onSelected: (_) => onTypeChanged(t),
            avatar: Icon(_typeIcon(t), size: 16),
          )).toList(),
        ),
        const SizedBox(height: 16),
        _SectionHeader('Model Gücü: ${strength.toStringAsFixed(2)}'),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
          ),
          child: Column(children: [
            Row(children: [
              const Text('0.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Expanded(child: Slider(
                value: strength, min: 0, max: 1, divisions: 20,
                activeColor: Colors.deepPurple,
                onChanged: onStrengthChanged,
              )),
              const Text('1.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ]),
            Text(
              strength < 0.4 ? 'Hafif etki — orijinal stili korur'
                  : strength < 0.7 ? 'Orta etki — dengeli sonuç'
                  : 'Güçlü etki — LoRA baskın',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ]),
        ),
        const SizedBox(height: 16),
        _SectionHeader('Tetikleyici Kelime'),
        TextFormField(
          controller: triggerCtrl,
          decoration: const InputDecoration(
            labelText: 'Tetikleyici Kelime (opsiyonel)',
            hintText: 'Örn: <lora_style>',
            prefixIcon: Icon(Icons.key),
            border: OutlineInputBorder(),
            helperText: 'Promptlarda modeli aktive etmek için kullanılan özel kelime',
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: tagsCtrl,
          decoration: const InputDecoration(
            labelText: 'Etiketler',
            hintText: 'mimari, modern, lüks',
            prefixIcon: Icon(Icons.tag),
            border: OutlineInputBorder(),
          ),
        ),
      ]),
    );
  }

  IconData _typeIcon(LoRAType t) {
    switch (t) {
      case LoRAType.style: return Icons.palette;
      case LoRAType.character: return Icons.person;
      case LoRAType.concept: return Icons.lightbulb;
      case LoRAType.object: return Icons.category;
      case LoRAType.background: return Icons.landscape;
      case LoRAType.lighting: return Icons.wb_sunny;
      case LoRAType.composition: return Icons.grid_on;
      case LoRAType.color: return Icons.color_lens;
    }
  }
}

// ── Training Parameters Tab ───────────────────────────────────
class _TrainingTab extends StatelessWidget {
  final int steps, batchSize, epochs, warmupSteps;
  final double learningRate, textEncoderLr;
  final bool useXformers, savePrecision;
  final String scheduler;
  final void Function(int) onStepsChanged, onBatchChanged, onEpochsChanged, onWarmupChanged;
  final void Function(double) onLrChanged;
  final void Function(bool) onXformersChanged, onPrecisionChanged;
  final void Function(String) onSchedulerChanged;

  const _TrainingTab({
    required this.steps, required this.learningRate, required this.batchSize,
    required this.epochs, required this.textEncoderLr, required this.useXformers,
    required this.savePrecision, required this.scheduler, required this.warmupSteps,
    required this.onStepsChanged, required this.onLrChanged, required this.onBatchChanged,
    required this.onEpochsChanged, required this.onXformersChanged,
    required this.onPrecisionChanged, required this.onSchedulerChanged, required this.onWarmupChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SectionHeader('Temel Eğitim Parametreleri'),
        _SliderParam(
          label: 'Eğitim Adımları: $steps',
          value: steps.toDouble(), min: 100, max: 5000, divisions: 49,
          onChanged: (v) => onStepsChanged(v.round()),
          hint: 'Daha fazla adım = daha iyi kalite, daha uzun süre',
        ),
        _SliderParam(
          label: 'Batch Boyutu: $batchSize',
          value: batchSize.toDouble(), min: 1, max: 16, divisions: 15,
          onChanged: (v) => onBatchChanged(v.round()),
          hint: 'GPU belleğinize göre ayarlayın',
        ),
        _SliderParam(
          label: 'Epoch Sayısı: $epochs',
          value: epochs.toDouble(), min: 1, max: 50, divisions: 49,
          onChanged: (v) => onEpochsChanged(v.round()),
          hint: 'Veri üzerinden kaç kez geçileceği',
        ),
        _SliderParam(
          label: 'Warmup Adımları: $warmupSteps',
          value: warmupSteps.toDouble(), min: 0, max: 500, divisions: 50,
          onChanged: (v) => onWarmupChanged(v.round()),
          hint: 'LR warmup için gereken adım sayısı',
        ),
        const SizedBox(height: 16),
        _SectionHeader('Öğrenme Hızı'),
        _LrInput(label: 'UNet LR', value: learningRate, onChanged: onLrChanged),
        const SizedBox(height: 12),
        _LrInput(label: 'Text Encoder LR', value: textEncoderLr, onChanged: (_) {}),
        const SizedBox(height: 16),
        _SectionHeader('Zamanlayıcı'),
        DropdownButtonFormField<String>(
          value: scheduler,
          decoration: const InputDecoration(border: OutlineInputBorder(), prefixIcon: Icon(Icons.schedule)),
          items: ['cosine', 'linear', 'constant', 'cosine_with_restarts', 'polynomial']
              .map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (v) => onSchedulerChanged(v!),
        ),
        const SizedBox(height: 16),
        _SectionHeader('Optimizasyon'),
        SwitchListTile(
          title: const Text('xFormers Kullan'),
          subtitle: const Text('Bellek verimliliği için — GPU uyumluysa aktif edin', style: TextStyle(fontSize: 12)),
          value: useXformers,
          onChanged: onXformersChanged,
        ),
        SwitchListTile(
          title: const Text('fp16 Hassasiyeti'),
          subtitle: const Text('Daha hızlı eğitim, biraz daha düşük kalite', style: TextStyle(fontSize: 12)),
          value: savePrecision,
          onChanged: onPrecisionChanged,
        ),
        const SizedBox(height: 16),
        // Estimated time
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: Row(children: [
            const Icon(Icons.timer_outlined, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Tahmini Eğitim Süresi', style: TextStyle(fontWeight: FontWeight.w600)),
              Text(
                '~${((steps * batchSize) / 1000).ceil()} dakika (GPU hızına bağlı)',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ])),
          ]),
        ),
      ]),
    );
  }
}

// ── Status & Test Tab ─────────────────────────────────────────
class _StatusTab extends StatelessWidget {
  final LoRAStatus status;
  final bool isTraining;
  final double progress;
  final int steps, currentStep;
  final VoidCallback onTest, onDeploy;

  const _StatusTab({
    required this.status, required this.isTraining, required this.progress,
    required this.steps, required this.currentStep,
    required this.onTest, required this.onDeploy,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SectionHeader('Eğitim Durumu'),
        Card(child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            // Status icon + label
            Row(children: [
              _statusIcon(status, isTraining),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(_statusLabel(status), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Adım $currentStep / $steps', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
              ])),
              Text('${(progress * 100).toInt()}%',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: _statusColor(status))),
            ]),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress, minHeight: 10,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation(_statusColor(status)),
              ),
            ),
          ]),
        )),

        const SizedBox(height: 16),
        _SectionHeader('Eğitim Metrikleri'),
        Card(child: Column(children: [
          _MetricRow('Loss', isTraining ? '${(0.8 - progress * 0.6).toStringAsFixed(4)}' : '—'),
          _MetricRow('LR', isTraining ? '${(0.0001 * (1 - progress * 0.3)).toStringAsExponential(2)}' : '—'),
          _MetricRow('Kalan Süre', isTraining ? '~${((1 - progress) * steps / 10).ceil()} sn' : '—'),
          _MetricRow('GPU Kullanımı', isTraining ? '78%' : '—'),
        ])),

        const SizedBox(height: 16),

        // Action buttons
        if (!isTraining && status == LoRAStatus.ready || status == LoRAStatus.testing) ...[
          _SectionHeader('Model Aksiyonları'),
          Row(children: [
            Expanded(child: OutlinedButton.icon(
              onPressed: onTest,
              icon: const Icon(Icons.science),
              label: const Text('Test Et'),
            )),
            const SizedBox(width: 12),
            Expanded(child: FilledButton.icon(
              onPressed: onDeploy,
              icon: const Icon(Icons.rocket_launch),
              label: const Text('Deploy Et'),
              style: FilledButton.styleFrom(backgroundColor: Colors.deepPurple),
            )),
          ]),
        ],

        if (status == LoRAStatus.deployed) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Row(children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 12),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Production\'da Aktif', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                Text('Bu model şu anda görüntü üretiminde kullanılıyor', style: TextStyle(fontSize: 12)),
              ])),
            ]),
          ),
        ],

        const SizedBox(height: 16),
        _SectionHeader('Günlükler'),
        Container(
          height: 160,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Text(
              isTraining
                  ? '[${DateTime.now().toIso8601String()}] Eğitim başlatıldı\n'
                    '[INFO] Model yükleniyor...\n'
                    '[INFO] Veri seti hazırlanıyor...\n'
                    '[STEP ${currentStep}/${steps}] loss=${(0.8 - progress * 0.6).toStringAsFixed(4)}\n'
                  : '[INFO] Eğitim bekleniyor\n',
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.green,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _statusIcon(LoRAStatus s, bool training) {
    if (training) return SizedBox(width: 32, height: 32,
        child: CircularProgressIndicator(strokeWidth: 3, color: Colors.orange));
    switch (s) {
      case LoRAStatus.ready: return const Icon(Icons.check_circle, color: Colors.green, size: 32);
      case LoRAStatus.deployed: return const Icon(Icons.rocket_launch, color: Colors.deepPurple, size: 32);
      case LoRAStatus.failed: return const Icon(Icons.error, color: Colors.red, size: 32);
      case LoRAStatus.archived: return const Icon(Icons.inventory_2, color: Colors.grey, size: 32);
      default: return const Icon(Icons.hourglass_empty, color: Colors.orange, size: 32);
    }
  }

  Color _statusColor(LoRAStatus s) {
    switch (s) {
      case LoRAStatus.ready: return Colors.green;
      case LoRAStatus.deployed: return Colors.deepPurple;
      case LoRAStatus.failed: return Colors.red;
      default: return Colors.orange;
    }
  }

  String _statusLabel(LoRAStatus s) {
    switch (s) {
      case LoRAStatus.training: return 'Eğitim Devam Ediyor';
      case LoRAStatus.ready: return 'Eğitim Tamamlandı';
      case LoRAStatus.deployed: return 'Production\'da Aktif';
      case LoRAStatus.failed: return 'Eğitim Başarısız';
      case LoRAStatus.testing: return 'Test Aşamasında';
      case LoRAStatus.archived: return 'Arşivlendi';
    }
  }
}

// ── Shared helpers ─────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
  );
}

class _SliderParam extends StatelessWidget {
  final String label, hint;
  final double value, min, max;
  final int divisions;
  final void Function(double) onChanged;
  const _SliderParam({required this.label, required this.value, required this.min,
      required this.max, required this.divisions, required this.onChanged, required this.hint});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
    Slider(value: value.clamp(min, max), min: min, max: max, divisions: divisions, onChanged: onChanged),
    Text(hint, style: TextStyle(fontSize: 11, color: Colors.grey[500])),
    const SizedBox(height: 8),
  ]);
}

class _LrInput extends StatelessWidget {
  final String label;
  final double value;
  final void Function(double) onChanged;
  const _LrInput({required this.label, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) => TextFormField(
    initialValue: value.toStringAsExponential(4),
    decoration: InputDecoration(labelText: label, border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.tune), helperText: 'Önerilen: 1e-4 ile 1e-5 arası'),
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    onSaved: (v) => onChanged(double.tryParse(v ?? '') ?? value),
  );
}

class _MetricRow extends StatelessWidget {
  final String label, value;
  const _MetricRow(this.label, this.value);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(children: [
      Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      const Spacer(),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, fontFamily: 'monospace')),
    ]),
  );
}
