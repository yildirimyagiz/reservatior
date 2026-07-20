import { DataLayer, GraphNode } from './graph-layer-1-data';
import { RelationshipLayer } from './graph-layer-2-relationship';
import { InsightLayer } from './graph-layer-3-insight';
import { ActionLayer } from './graph-layer-4-action';
import { GraphLearning } from './graph-learning';

// 1. Core Katmanların Initialize Edilmesi
const dataLayer = new DataLayer();
const relationshipLayer = new RelationshipLayer(dataLayer);
const insightLayer = new InsightLayer(dataLayer);
const actionLayer = new ActionLayer(insightLayer);
const graphLearning = new GraphLearning(dataLayer, insightLayer);

console.log('--- Reservatior OS Intelligence Graph Başlatıldı ---');

// 2. Data Ingestion (Katman 1: Data Layer)
// Mock Agent Dataları (AgentOS)
const agentNode: GraphNode = {
  id: 'node-agent-001',
  type: 'entity',
  sourceOS: 'AgentOS',
  timestamp: new Date().toISOString(),
  metadata: {},
  data: {
    id: 'agent_yagiz_01',
    name: 'Yağız',
    role: 'Senior Asset Optimizer'
  }
};

// Mock Booking Dataları (BookingOS)
const bookingNode: GraphNode = {
  id: 'node-booking-101',
  type: 'entity',
  sourceOS: 'BookingOS',
  timestamp: new Date().toISOString(),
  metadata: {},
  data: {
    id: 'book_res_992',
    agentId: 'agent_yagiz_01', // Relationship Layer'ın yakalayacağı ortak alan
    propertyId: 'prop-istanbul-vadi',
    amount: 125000
  }
};

dataLayer.ingestNode(agentNode);
dataLayer.ingestNode(bookingNode);

console.log('\n[Data Layer] Veri girişi tamamlandı.');
console.log('Güncel Graf İstatistikleri:', dataLayer.getStats());

// 3. İlişki Keşfi (Katman 2: Relationship Layer)
const discoveredEdges = relationshipLayer.discoverRelationships();
discoveredEdges.forEach(edge => dataLayer.createEdge(edge));

console.log(`\n[Relationship Layer] ${discoveredEdges.length} adet yeni ilişki haritalandırıldı.`);
console.log('İlişki Detayları:', dataLayer.getEdges('node-booking-101'));

// 4. Analitik Öngörü Üretimi (Katman 3: Insight Layer)
const activeInsights = insightLayer.generateInsights();
console.log(`\n[Insight Layer] ${activeInsights.length} adet sistem anomalisi/patterne dair öngörü üretildi.`);
console.log('Üretilen Öngörüler:', activeInsights);

// 5. Otonom Aksiyon Tetikleyicileri (Katman 4: Action Layer)
const recommendedActions = actionLayer.generateActions();
console.log(`\n[Action Layer] Entegre öngörülere göre ${recommendedActions.length} otonom aksiyon planlandı.`);
console.log('Aksiyon Kuyruğu:', recommendedActions);

// 6. Makine Öğrenmesi ve Tahminleme Modeli (Graph Learning)
console.log('\n[Graph Learning] ML Modelleri üzerinden anlık analizler çalıştırılıyor...');

// İptal Tahmini (Booking Cancellation)
const cancellationFeatures = {
  booking_lead_time: 14,     // gün
  price: 2500,               // $
  season: 2,                 // Yaz Sezonu Kodu
  guest_history: 95,         // Güven Skoru
  property_rating: 4.8       // Puan
};

const cancellationPrediction = graphLearning.predict('booking_cancellation', cancellationFeatures);
console.log('Rezervasyon İptal Riski Analizi (Classification):', cancellationPrediction);

// Anomali Tespiti (Finansal İşlemler İçin)
const fraudFeatures = {
  transaction_amount: 500000, 
  transaction_frequency: 45, 
  user_behavior_score: 12    // Şüpheli düşük skor
};

const anomalyDetection = graphLearning.predict('anomaly_detection', fraudFeatures);
console.log('Finansal İşlem Güvenlik Sorgusu (Anomaly Detection):', anomalyDetection);

// Model Metriklerinin Çıktılanması
console.log('\nFinansal Anomali Model Durumu:', graphLearning.getModelMetrics('anomaly_detection'));

export { dataLayer, relationshipLayer, insightLayer, actionLayer, graphLearning };
