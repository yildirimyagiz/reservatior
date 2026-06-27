import { LightingNCore, LIGHTINGN_CORE_CONSTANTS } from '@/lib/lightingn-core';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';

// Visual Architecture Diagram Component
function LightingNCoreDiagram() {
  return (
    <svg viewBox="0 0 800 600" className="w-full max-w-4xl mx-auto">
      {/* Background */}
      <rect width="800" height="600" fill="#0B1121" />

      {/* Title */}
      <text x="400" y="30" textAnchor="middle" fill="#ffffff" fontSize="24" fontWeight="bold">
        LightingN Core - 4-Layer 3D Stacked Architecture
      </text>

      {/* Layer 4 - Bottom Layer */}
      <g transform="translate(50, 450)">
        {/* Layer background */}
        <rect x="0" y="0" width="700" height="80" fill="url(#layer4Gradient)" stroke="#7c3aed" strokeWidth="2" rx="8"/>
        <text x="350" y="25" textAnchor="middle" fill="#ffffff" fontSize="16" fontWeight="bold">
          Layer 4: Quantum Enhancement & Auxiliary Support
        </text>
        <text x="350" y="50" textAnchor="middle" fill="#e2e8f0" fontSize="12">
          Bosonic Error Correction • Quantum Memory • Entangled States
        </text>
        {/* Components */}
        <circle cx="100" cy="70" r="8" fill="#7c3aed" opacity="0.8"/>
        <text x="100" y="75" textAnchor="middle" fill="#ffffff" fontSize="10">GKP</text>
        <circle cx="200" cy="70" r="8" fill="#7c3aed" opacity="0.8"/>
        <text x="200" y="75" textAnchor="middle" fill="#ffffff" fontSize="10">Cat Codes</text>
        <circle cx="300" cy="70" r="8" fill="#7c3aed" opacity="0.8"/>
        <text x="300" y="75" textAnchor="middle" fill="#ffffff" fontSize="10">Q.Memory</text>
        <circle cx="400" cy="70" r="8" fill="#7c3aed" opacity="0.8"/>
        <text x="400" y="75" textAnchor="middle" fill="#ffffff" fontSize="10">Detectors</text>
        <circle cx="500" cy="70" r="8" fill="#7c3aed" opacity="0.8"/>
        <text x="500" y="75" textAnchor="middle" fill="#ffffff" fontSize="10">Squeezed Light</text>
        <text x="600" y="70" textAnchor="middle" fill="#7c3aed" fontSize="12" fontWeight="bold">99.9% Fidelity</text>
      </g>

      {/* Layer 3 - Electronic Control */}
      <g transform="translate(50, 350)">
        <rect x="0" y="0" width="700" height="80" fill="url(#layer3Gradient)" stroke="#f59e0b" strokeWidth="2" rx="8"/>
        <text x="350" y="25" textAnchor="middle" fill="#ffffff" fontSize="16" fontWeight="bold">
          Layer 3: Electronic Control & Orchestration
        </text>
        <text x="350" y="50" textAnchor="middle" fill="#e2e8f0" fontSize="12">
          RISC-V Cores • Real-time Scheduler • Error Correction Hardware
        </text>
        {/* Components */}
        <rect x="50" y="55" width="30" height="15" fill="#f59e0b" rx="2"/>
        <text x="65" y="65" textAnchor="middle" fill="#ffffff" fontSize="10">CPU</text>
        <rect x="150" y="55" width="30" height="15" fill="#f59e0b" rx="2"/>
        <text x="165" y="65" textAnchor="middle" fill="#ffffff" fontSize="10">Scheduler</text>
        <rect x="250" y="55" width="30" height="15" fill="#f59e0b" rx="2"/>
        <text x="265" y="65" textAnchor="middle" fill="#ffffff" fontSize="10">Error Corr</text>
        <rect x="350" y="55" width="30" height="15" fill="#f59e0b" rx="2"/>
        <text x="365" y="65" textAnchor="middle" fill="#ffffff" fontSize="10">Memory</text>
        <text x="600" y="65" textAnchor="middle" fill="#f59e0b" fontSize="12" fontWeight="bold">10-20W • 3-5GHz</text>
      </g>

      {/* Layer 2 - Interconnect */}
      <g transform="translate(50, 250)">
        <rect x="0" y="0" width="700" height="80" fill="url(#layer2Gradient)" stroke="#06b6d4" strokeWidth="2" rx="8"/>
        <text x="350" y="25" textAnchor="middle" fill="#ffffff" fontSize="16" fontWeight="bold">
          Layer 2: Hybrid Interconnect & Routing Fabric
        </text>
        <text x="350" y="50" textAnchor="middle" fill="#e2e8f0" fontSize="12">
          Photonic Switches • Quantum Links • Electro-Optic Transducers
        </text>
        {/* Components */}
        <polygon points="80,70 90,60 100,70 90,80" fill="#06b6d4"/>
        <text x="90" y="75" textAnchor="middle" fill="#ffffff" fontSize="10">Switch</text>
        <line x1="150" y1="65" x2="200" y2="65" stroke="#06b6d4" strokeWidth="3"/>
        <text x="175" y="75" textAnchor="middle" fill="#06b6d4" fontSize="10">Quantum Link</text>
        <circle cx="280" cy="67" r="10" fill="#06b6d4" opacity="0.8"/>
        <text x="280" y="72" textAnchor="middle" fill="#ffffff" fontSize="10">E-O</text>
        <text x="600" y="70" textAnchor="middle" fill="#06b6d4" fontSize="12" fontWeight="bold">100+ Tbps • Sub-ps</text>
      </g>

      {/* Layer 1 - Photonic Compute */}
      <g transform="translate(50, 150)">
        <rect x="0" y="0" width="700" height="80" fill="url(#layer1Gradient)" stroke="#3b82f6" strokeWidth="2" rx="8"/>
        <text x="350" y="25" textAnchor="middle" fill="#ffffff" fontSize="16" fontWeight="bold">
          Layer 1: Photonic-Qubit & Compute Core (Top)
        </text>
        <text x="350" y="50" textAnchor="middle" fill="#e2e8f0" fontSize="12">
          Hybrid Qubits • MZI Meshes • Nonlinear Optics • Detectors
        </text>
        {/* Components */}
        <circle cx="80" cy="67" r="8" fill="#3b82f6" opacity="0.8"/>
        <text x="80" y="72" textAnchor="middle" fill="#ffffff" fontSize="10">Qubit</text>
        <rect x="130" y="60" width="25" height="15" fill="#3b82f6" rx="2"/>
        <text x="142" y="70" textAnchor="middle" fill="#ffffff" fontSize="10">MZI</text>
        <polygon points="190,75 200,65 210,75 200,85" fill="#3b82f6"/>
        <text x="200" y="80" textAnchor="middle" fill="#ffffff" fontSize="10">{"χ(2)"}</text>
        <rect x="250" y="60" width="25" height="15" fill="#3b82f6" rx="2"/>
        <text x="262" y="70" textAnchor="middle" fill="#ffffff" fontSize="10">WG</text>
        <circle cx="320" cy="67" r="8" fill="#3b82f6" opacity="0.8"/>
        <text x="320" y="72" textAnchor="middle" fill="#ffffff" fontSize="10">PNR</text>
        <text x="600" y="70" textAnchor="middle" fill="#3b82f6" fontSize="12" fontWeight="bold">{">1 PHz • <1ps • 5-12W"}</text>
      </g>

      {/* Data Flow Arrows */}
      <defs>
        <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="9" refY="3.5" orient="auto">
          <polygon points="0 0, 10 3.5, 0 7" fill="#10b981" />
        </marker>
      </defs>

      {/* Vertical data flow */}
      <line x1="400" y1="230" x2="400" y2="270" stroke="#10b981" strokeWidth="3" markerEnd="url(#arrowhead)"/>
      <line x1="400" y1="330" x2="400" y2="370" stroke="#10b981" strokeWidth="3" markerEnd="url(#arrowhead)"/>
      <line x1="400" y1="430" x2="400" y2="470" stroke="#10b981" strokeWidth="3" markerEnd="url(#arrowhead)"/>

      {/* Horizontal connections */}
      <line x1="200" y1="210" x2="250" y2="210" stroke="#10b981" strokeWidth="2"/>
      <line x1="200" y1="310" x2="250" y2="310" stroke="#10b981" strokeWidth="2"/>
      <line x1="200" y1="410" x2="250" y2="410" stroke="#10b981" strokeWidth="2"/>

      {/* Cooling system visualization */}
      <g transform="translate(650, 100)">
        <rect x="0" y="0" width="100" height="450" fill="none" stroke="#06b6d4" strokeWidth="2" rx="5"/>
        <text x="50" y="20" textAnchor="middle" fill="#06b6d4" fontSize="12" fontWeight="bold">Cooling</text>
        <text x="50" y="35" textAnchor="middle" fill="#06b6d4" fontSize="10">System</text>

        {/* Microfluidic channels */}
        <line x1="20" y1="50" x2="80" y2="50" stroke="#06b6d4" strokeWidth="4"/>
        <text x="50" y="45" textAnchor="middle" fill="#06b6d4" fontSize="8">Microfluidic</text>

        {/* Thermoelectric */}
        <rect x="25" y="70" width="50" height="20" fill="#06b6d4" opacity="0.3"/>
        <text x="50" y="82" textAnchor="middle" fill="#06b6d4" fontSize="8">Thermoelectric</text>

        {/* PCM */}
        <rect x="25" y="100" width="50" height="20" fill="#7c3aed" opacity="0.3"/>
        <text x="50" y="112" textAnchor="middle" fill="#7c3aed" fontSize="8">PCM</text>

        {/* Radiative */}
        <polygon points="30,130 70,130 50,150" fill="#f59e0b" opacity="0.3"/>
        <text x="50" y="142" textAnchor="middle" fill="#f59e0b" fontSize="8">Radiative</text>
      </g>

      {/* Gradients */}
      <defs>
        <linearGradient id="layer1Gradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" stopColor="#1e40af" stopOpacity="0.8"/>
          <stop offset="100%" stopColor="#3b82f6" stopOpacity="0.8"/>
        </linearGradient>
        <linearGradient id="layer2Gradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" stopColor="#164e63" stopOpacity="0.8"/>
          <stop offset="100%" stopColor="#06b6d4" stopOpacity="0.8"/>
        </linearGradient>
        <linearGradient id="layer3Gradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" stopColor="#92400e" stopOpacity="0.8"/>
          <stop offset="100%" stopColor="#f59e0b" stopOpacity="0.8"/>
        </linearGradient>
        <linearGradient id="layer4Gradient" x1="0%" y1="0%" x2="100%" y2="0%">
          <stop offset="0%" stopColor="#581c87" stopOpacity="0.8"/>
          <stop offset="100%" stopColor="#7c3aed" stopOpacity="0.8"/>
        </linearGradient>
      </defs>

      {/* Legend */}
      <g transform="translate(50, 550)">
        <text x="0" y="0" fill="#ffffff" fontSize="14" fontWeight="bold">Legend:</text>
        <circle cx="80" cy="-5" r="6" fill="#3b82f6"/>
        <text x="95" y="0" fill="#ffffff" fontSize="12">Photonic Compute</text>
        <circle cx="220" cy="-5" r="6" fill="#06b6d4"/>
        <text x="235" y="0" fill="#ffffff" fontSize="12">Interconnect Fabric</text>
        <circle cx="380" cy="-5" r="6" fill="#f59e0b"/>
        <text x="395" y="0" fill="#ffffff" fontSize="12">Electronic Control</text>
        <circle cx="540" cy="-5" r="6" fill="#7c3aed"/>
        <text x="555" y="0" fill="#ffffff" fontSize="12">Quantum Enhancement</text>
        <line x1="680" y1="-10" x2="700" y2="-10" stroke="#10b981" strokeWidth="3" markerEnd="url(#arrowhead)"/>
        <text x="705" y="0" fill="#ffffff" fontSize="12">Data Flow</text>
      </g>
    </svg>
  );
}

export default function LightingNCorePage() {
  const core = new LightingNCore();
  const architecture = core.getArchitecture();
  const performanceTargets = core.getPerformanceTargets();
  const coolingSystem = core.getOptimizedCoolingSystem();

  return (
    <div className="container mx-auto py-8 px-4">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="text-center mb-8">
          <h1 className="text-4xl font-bold text-white mb-2">LightingN Core</h1>
          <p className="text-xl text-slate-300 mb-4">{architecture.version}</p>
          <p className="text-slate-400">{architecture.date}</p>
        </div>

        {/* Visual Architecture Diagram */}
        <Card className="mb-8 bg-slate-900 border-slate-700">
          <CardHeader>
            <CardTitle className="text-white text-center">🎨 LightingN Core Görsel Mimarisi</CardTitle>
            <CardDescription className="text-slate-300 text-center">
              4-Katmanlı 3D Yığın Halindeki Hibrit Mimarinin Görsel Temsili
            </CardDescription>
          </CardHeader>
          <CardContent>
            <LightingNCoreDiagram />
          </CardContent>
        </Card>

        {/* Overview */}
        <Card className="mb-8 bg-slate-900 border-slate-700">
          <CardHeader>
            <CardTitle className="text-white">Overview</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-slate-300">{architecture.overview}</p>
          </CardContent>
        </Card>

        {/* Key Design Goals */}
        <Card className="mb-8 bg-slate-900 border-slate-700">
          <CardHeader>
            <CardTitle className="text-white">Key Design Goals</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid gap-3">
              {architecture.keyDesignGoals.map((goal, index) => (
                <div key={index} className="flex items-start gap-3">
                  <span className="px-2 py-1 bg-slate-700 text-white text-xs font-semibold rounded mt-1">{index + 1}</span>
                  <p className="text-slate-300">{goal}</p>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>

        {/* 4-Layer Architecture */}
        <div className="space-y-6 mb-8">
          <h2 className="text-3xl font-bold text-white text-center">Unified 4-Layer 3D Stacked Architecture</h2>

          {/* Layer 1 */}
          <Card className="bg-gradient-to-r from-blue-900/20 to-purple-900/20 border-blue-500/30">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <span className="px-2 py-1 bg-blue-600 text-white text-xs font-semibold rounded">Layer 1</span>
                Photonic-Qubit & Compute Core (Top Layer)
              </CardTitle>
              <CardDescription className="text-slate-300">
                {architecture.photonicQubitComputeCore.function}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid md:grid-cols-2 gap-4">
                <div>
                  <h4 className="font-semibold text-white mb-2">Components</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• {architecture.photonicQubitComputeCore.photonicQubitNetwork.hybridQubits}+ hybrid qubits</li>
                    <li>• {architecture.photonicQubitComputeCore.photonicProcessingUnits.reconfigurableMZIMeshes}+ tunable MZI units</li>
                    <li>• {architecture.photonicQubitComputeCore.nonlinearPhotonicElements.material}</li>
                    <li>• {architecture.photonicQubitComputeCore.lowLossWaveguides.material}</li>
                  </ul>
                </div>
                <div>
                  <h4 className="font-semibold text-white mb-2">Specifications</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• Optical bandwidth: {architecture.photonicQubitComputeCore.specs.opticalBandwidth}</li>
                    <li>• Matrix ops latency: {architecture.photonicQubitComputeCore.specs.matrixOpsLatency}</li>
                    <li>• Power: {architecture.photonicQubitComputeCore.specs.power}</li>
                  </ul>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Layer 2 */}
          <Card className="bg-gradient-to-r from-green-900/20 to-teal-900/20 border-green-500/30">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <span className="px-2 py-1 bg-green-600 text-white text-xs font-semibold rounded">Layer 2</span>
                Hybrid Interconnect & Routing Fabric
              </CardTitle>
              <CardDescription className="text-slate-300">
                {architecture.hybridInterconnectRoutingFabric.function}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid md:grid-cols-2 gap-4">
                <div>
                  <h4 className="font-semibold text-white mb-2">Components</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• {architecture.hybridInterconnectRoutingFabric.reconfigurablePhotonicSwitchFabric.type}</li>
                    <li>• {architecture.hybridInterconnectRoutingFabric.quantumCoherentOpticalLinks.type}</li>
                    <li>• {architecture.hybridInterconnectRoutingFabric.hybridTransducers.type} ({architecture.hybridInterconnectRoutingFabric.hybridTransducers.efficiency * 100}% efficiency)</li>
                  </ul>
                </div>
                <div>
                  <h4 className="font-semibold text-white mb-2">Specifications</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• Bandwidth: {architecture.hybridInterconnectRoutingFabric.specs.interconnectBandwidth} per link</li>
                    <li>• Latency: {architecture.hybridInterconnectRoutingFabric.specs.latency}</li>
                    <li>• Loss: {architecture.hybridInterconnectRoutingFabric.specs.loss} per hop</li>
                  </ul>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Layer 3 */}
          <Card className="bg-gradient-to-r from-orange-900/20 to-red-900/20 border-orange-500/30">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <span className="px-2 py-1 bg-orange-600 text-white text-xs font-semibold rounded">Layer 3</span>
                Electronic Control & Orchestration Layer
              </CardTitle>
              <CardDescription className="text-slate-300">
                {architecture.electronicControlOrchestrationLayer.function}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid md:grid-cols-2 gap-4">
                <div>
                  <h4 className="font-semibold text-white mb-2">Components</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• {architecture.electronicControlOrchestrationLayer.multiCoreRISCCluster.cores} RISC-V cores @ {architecture.electronicControlOrchestrationLayer.multiCoreRISCCluster.frequency}</li>
                    <li>• {architecture.electronicControlOrchestrationLayer.realTimeHybridScheduler.type}</li>
                    <li>• Quantum Error Correction Hardware</li>
                    <li>• {architecture.electronicControlOrchestrationLayer.ioInterfaces.standards.join(', ')}</li>
                  </ul>
                </div>
                <div>
                  <h4 className="font-semibold text-white mb-2">Specifications</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• Power: {architecture.electronicControlOrchestrationLayer.specs.power}</li>
                    <li>• Clock domain: {architecture.electronicControlOrchestrationLayer.specs.clockDomain}</li>
                  </ul>
                </div>
              </div>
            </CardContent>
          </Card>

          {/* Layer 4 */}
          <Card className="bg-gradient-to-r from-purple-900/20 to-pink-900/20 border-purple-500/30">
            <CardHeader>
              <CardTitle className="text-white flex items-center gap-2">
                <span className="px-2 py-1 bg-purple-600 text-white text-xs font-semibold rounded">Layer 4</span>
                Quantum Enhancement & Auxiliary Support (Bottom Layer)
              </CardTitle>
              <CardDescription className="text-slate-300">
                {architecture.quantumEnhancementAuxiliarySupport.function}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid md:grid-cols-2 gap-4">
                <div>
                  <h4 className="font-semibold text-white mb-2">Components</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• {architecture.quantumEnhancementAuxiliarySupport.deterministicPhotonInteractionModules.type}</li>
                    <li>• Bosonic Quantum Error Correction ({architecture.quantumEnhancementAuxiliarySupport.bosonicQuantumErrorCorrection.codes.join(', ')})</li>
                    <li>• {architecture.quantumEnhancementAuxiliarySupport.onChipQuantumMemory.types.join(', ')}</li>
                    <li>• Entangled State & Squeezed Light Generators</li>
                  </ul>
                </div>
                <div>
                  <h4 className="font-semibold text-white mb-2">Specifications</h4>
                  <ul className="space-y-1 text-sm text-slate-300">
                    <li>• Logical qubit fidelity: {architecture.quantumEnhancementAuxiliarySupport.specs.logicalQubitFidelity}</li>
                    <li>• Coherence time: {architecture.quantumEnhancementAuxiliarySupport.specs.coherenceTime}</li>
                  </ul>
                </div>
              </div>
            </CardContent>
          </Card>
        </div>

        {/* Interconnect & Integration */}
        <Card className="mb-8 bg-slate-900 border-slate-700">
          <CardHeader>
            <CardTitle className="text-white">Interconnect & Integration Summary</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid md:grid-cols-2 gap-4">
              <div>
                <h4 className="font-semibold text-white mb-2">3D Stacking</h4>
                <p className="text-slate-300">{architecture.interconnectIntegrationSummary.stacking3D}</p>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-2">Modularity</h4>
                <p className="text-slate-300">{architecture.interconnectIntegrationSummary.chipletModularity}</p>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-2">Thermal Management</h4>
                <p className="text-slate-300">{architecture.interconnectIntegrationSummary.thermalManagement}</p>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-2">Packaging</h4>
                <p className="text-slate-300">{architecture.interconnectIntegrationSummary.packaging}</p>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Optimized Cooling System */}
        <Card className="mb-8 bg-gradient-to-r from-cyan-900/20 to-blue-900/20 border-cyan-500/30">
          <CardHeader>
            <CardTitle className="text-white">🚀 Optimized Cooling System (Efficiency Enhancement)</CardTitle>
            <CardDescription className="text-slate-300">
              Advanced multi-modal cooling for maximum efficiency in 3D stacked hybrid architecture
            </CardDescription>
          </CardHeader>
          <CardContent>
            <div className="grid md:grid-cols-2 gap-6">
              <div>
                <h4 className="font-semibold text-white mb-3">Microfluidic Channels</h4>
                <ul className="space-y-2 text-sm text-slate-300">
                  <li><strong>Material:</strong> {coolingSystem.microfluidicChannels.material}</li>
                  <li><strong>Coolant:</strong> {coolingSystem.microfluidicChannels.coolant}</li>
                  <li><strong>Flow Rate:</strong> {coolingSystem.microfluidicChannels.flowRate}</li>
                  <li><strong>Thermal Conductivity:</strong> {coolingSystem.microfluidicChannels.thermalConductivity} W/mK</li>
                </ul>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-3">Phase Change Materials</h4>
                <ul className="space-y-2 text-sm text-slate-300">
                  <li><strong>Type:</strong> {coolingSystem.phaseChangeMaterials.type}</li>
                  <li><strong>Melting Point:</strong> {coolingSystem.phaseChangeMaterials.meltingPoint}°C</li>
                  <li><strong>Latent Heat:</strong> {coolingSystem.phaseChangeMaterials.latentHeatCapacity}</li>
                </ul>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-3">Thermoelectric Coolers</h4>
                <ul className="space-y-2 text-sm text-slate-300">
                  <li><strong>Efficiency:</strong> {(coolingSystem.thermoelectricCoolers.efficiency * 100)}% of Carnot limit</li>
                  <li><strong>Integration:</strong> {coolingSystem.thermoelectricCoolers.integration}</li>
                </ul>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-3">Photonic Radiative Cooling</h4>
                <ul className="space-y-2 text-sm text-slate-300">
                  <li><strong>Method:</strong> {coolingSystem.photonicCooling.method}</li>
                  <li><strong>Emissivity:</strong> {(coolingSystem.photonicCooling.emissivity * 100)}% in mid-IR</li>
                  <li><strong>Temperature Range:</strong> {coolingSystem.photonicCooling.temperatureRange}</li>
                </ul>
              </div>
            </div>
          </CardContent>
        </Card>
        <Card className="mb-8 bg-slate-900 border-slate-700">
          <CardHeader>
            <CardTitle className="text-white">Performance Targets (2026–2028 Baseline)</CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid md:grid-cols-2 gap-6">
              <div>
                <h4 className="font-semibold text-white mb-3">AI & Quantum Performance</h4>
                <ul className="space-y-2 text-sm text-slate-300">
                  <li><strong>AI Inference/Training:</strong> {performanceTargets.aiInferenceTraining}</li>
                  <li><strong>Quantum Advantage:</strong> {performanceTargets.quantumAdvantage}</li>
                  <li><strong>Power Efficiency:</strong> {performanceTargets.powerEfficiency}</li>
                </ul>
              </div>
              <div>
                <h4 className="font-semibold text-white mb-3">Scalability Roadmap</h4>
                <div className="space-y-2">
                  {Object.entries(LIGHTINGN_CORE_CONSTANTS.SCALABILITY_ROADMAP).map(([year, target]) => (
                    <div key={year} className="flex items-center gap-2">
                      <span className="px-2 py-1 border border-slate-600 text-slate-300 text-xs font-semibold rounded">{year}</span>
                      <span className="text-sm text-slate-300">{target}</span>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        {/* Estimated Power */}
        <Card className="bg-slate-900 border-slate-700">
          <CardHeader>
            <CardTitle className="text-white">Estimated Total Power Consumption</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-2xl font-bold text-white">{core.getEstimatedTotalPower()}</p>
            <p className="text-sm text-slate-400 mt-2">Note: Layer 2 and 4 power consumption not specified in baseline specs</p>
          </CardContent>
        </Card>
      </div>
    </div>
  );
}
