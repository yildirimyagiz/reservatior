import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:reservatior/core/theme/app_theme.dart';

class SmartDevicesScreen extends StatefulWidget {
  const SmartDevicesScreen({super.key});

  @override
  State<SmartDevicesScreen> createState() => _SmartDevicesScreenState();
}

class _SmartDevicesScreenState extends State<SmartDevicesScreen> {
  final List<_SmartDevice> _devices = [
    _SmartDevice(id: '1', name: 'Front Door Lock', type: 'Lock', icon: Icons.lock_outlined, isOnline: true, value: 'Locked'),
    _SmartDevice(id: '2', name: 'Living Room Thermostat', type: 'Climate', icon: Icons.thermostat_outlined, isOnline: true, value: '22°C'),
    _SmartDevice(id: '3', name: 'Main Entrance Camera', type: 'Security', icon: Icons.videocam_outlined, isOnline: true, value: 'Recording'),
    _SmartDevice(id: '4', name: 'Smart TV — Bedroom', type: 'Entertainment', icon: Icons.tv_outlined, isOnline: false, value: 'Off'),
    _SmartDevice(id: '5', name: 'Kitchen Lights', type: 'Lighting', icon: Icons.light_mode_outlined, isOnline: true, value: '80%'),
    _SmartDevice(id: '6', name: 'Water Leak Sensor', type: 'Safety', icon: Icons.water_drop_outlined, isOnline: true, value: 'Dry'),
  ];

  @override
  Widget build(BuildContext context) {
    final online = _devices.where((d) => d.isOnline).length;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text('Smart Devices', style: GoogleFonts.outfit(fontWeight: FontWeight.w800, color: Colors.white)),
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: AppColors.primary),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(children: [
                  _StatusKpi('Online', '$online', AppColors.success),
                  const SizedBox(width: 12),
                  _StatusKpi('Offline', '${_devices.length - online}', AppColors.error),
                  const SizedBox(width: 12),
                  _StatusKpi('Total', '${_devices.length}', AppColors.primary),
                ]),
                const SizedBox(height: 24),
                Text('Devices', style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 12),
                ..._devices.map((d) => _DeviceTile(
                  device: d,
                  onToggle: () => setState(() {
                    final idx = _devices.indexOf(d);
                    _devices[idx] = _SmartDevice(
                      id: d.id, name: d.name, type: d.type,
                      icon: d.icon, isOnline: !d.isOnline,
                      value: !d.isOnline ? d.value : 'Off',
                    );
                  }),
                )),
                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmartDevice {
  final String id;
  final String name;
  final String type;
  final IconData icon;
  final bool isOnline;
  final String value;
  const _SmartDevice({required this.id, required this.name, required this.type, required this.icon, required this.isOnline, required this.value});
}

class _StatusKpi extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatusKpi(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Column(
          children: [
            Text(value, style: GoogleFonts.outfit(color: color, fontWeight: FontWeight.w800, fontSize: 20)),
            Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  final _SmartDevice device;
  final VoidCallback onToggle;
  const _DeviceTile({required this.device, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final color = device.isOnline ? AppColors.success : Colors.white24;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: device.isOnline ? color.withValues(alpha: 0.3) : AppColors.darkBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(device.icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device.name, style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                Text('${device.type} · ${device.value}', style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11)),
              ],
            ),
          ),
          Switch.adaptive(value: device.isOnline, onChanged: (_) => onToggle(), activeColor: AppColors.primary),
        ],
      ),
    );
  }
}
