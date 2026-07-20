#!/usr/bin/env node
/**
 * generate-os-i18n-all-languages.js
 * Copies OS i18n keys to all 20 language files
 * English keys are used as fallback for missing translations
 * Usage: node scripts/generate-os-i18n-all-languages.js
 */

const fs = require('fs');
const path = require('path');

const CLIENT_LOCALES_DIR = path.join(__dirname, '../client/src/locales');
const CLIENT_SEO_LOCALES_DIR = path.join(__dirname, '../client-seo/public/locales');

// Language-specific translations for common terms
const LANGUAGE_MAP = {
  en: { active: 'Active', inactive: 'Inactive', pending: 'Pending', completed: 'Completed', draft: 'Draft', published: 'Published', archived: 'Archived', confirmed: 'Confirmed', cancelled: 'Cancelled', approved: 'Approved', rejected: 'Rejected', resolved: 'Resolved', connected: 'Connected', disconnected: 'Disconnected', failed: 'Failed', healthy: 'Healthy', degraded: 'Degraded', signed: 'Signed', expired: 'Expired', sent: 'Sent', delivered: 'Delivered', read: 'Read', qualified: 'Qualified', unqualified: 'Unqualified', converted: 'Converted', won: 'Won', lost: 'Lost', listed: 'Listed', sold: 'Sold', writeoff: 'Written Off', suspended: 'Suspended', verified: 'Verified', checkedIn: 'Checked In', checkedOut: 'Checked Out', disputed: 'Disputed', released: 'Released', refunded: 'Refunded', scheduled: 'Scheduled', inProgress: 'In Progress', overdue: 'Overdue', compliant: 'Compliant', nonCompliant: 'Non-Compliant', underReview: 'Under Review', new: 'New', paused: 'Paused' },
  tr: { active: 'Aktif', inactive: 'Pasif', pending: 'Beklemede', completed: 'Tamamlandı', draft: 'Taslak', published: 'Yayında', archived: 'Arşivlendi', confirmed: 'Onaylandı', cancelled: 'İptal', approved: 'Onaylandı', rejected: 'Reddedildi', resolved: 'Çözüldü', connected: 'Bağlı', disconnected: 'Bağlantı Kesildi', failed: 'Başarısız', healthy: 'Sağlıklı', degraded: 'Bozulmuş', signed: 'İmzalandı', expired: 'Süresi Doldu', sent: 'Gönderildi', delivered: 'Teslim Edildi', read: 'Okundu', qualified: 'Nitelikli', unqualified: 'Niteliksiz', converted: 'Dönüştürüldü', won: 'Kazanıldı', lost: 'Kaybedildi', listed: 'Listelendi', sold: 'Satıldı', writeoff: 'Silindi', suspended: 'Askıya Alındı', verified: 'Doğrulandı', checkedIn: 'Giriş Yapıldı', checkedOut: 'Çıkış Yapıldı', disputed: 'İhtilaflı', released: 'Serbest Bırakıldı', refunded: 'İade Edildi', scheduled: 'Zamanlanmış', inProgress: 'Devam Ediyor', overdue: 'Gecikmiş', compliant: 'Uyumlu', nonCompliant: 'Uyumsuz', underReview: 'İnceleniyor', new: 'Yeni', paused: 'Duraklatıldı' },
  ar: { active: 'نشط', inactive: 'غير نشط', pending: 'قيد الانتظار', completed: 'مكتمل', draft: 'مسودة', published: 'منشور', archived: 'مؤرشف', confirmed: 'مؤكد', cancelled: 'ملغي', approved: 'موافق عليه', rejected: 'مرفوض', resolved: 'تم الحل', connected: 'متصل', disconnected: 'غير متصل', failed: 'فشل', healthy: 'سليم', degraded: 'متدهور', signed: 'موقّع', expired: 'منتهي الصلاحية', sent: 'مرسل', delivered: 'تم التوصيل', read: 'مقروء', qualified: 'مؤهل', unqualified: 'غير مؤهل', converted: 'تم التحويل', won: 'فاز', lost: 'خسر', listed: 'مدرج', sold: 'مباع', writeoff: 'مخفض', suspended: 'معلّق', verified: 'موثّق', checkedIn: 'تم تسجيل الدخول', checkedOut: 'تم تسجيل الخروج', disputed: 'متنازع', released: 'تم الإفراج', refunded: 'تم رد المبلغ', scheduled: 'مجدول', inProgress: 'قيد التنفيذ', overdue: 'متأخر', compliant: 'ممتثل', nonCompliant: 'غير ممتثل', underReview: 'قيد المراجعة', new: 'جديد', paused: 'متوقف مؤقتاً' },
  de: { active: 'Aktiv', inactive: 'Inaktiv', pending: 'Ausstehend', completed: 'Abgeschlossen', draft: 'Entwurf', published: 'Veröffentlicht', archived: 'Archiviert', confirmed: 'Bestätigt', cancelled: 'Storniert', approved: 'Genehmigt', rejected: 'Abgelehnt', resolved: 'Gelöst', connected: 'Verbunden', disconnected: 'Getrennt', failed: 'Fehlgeschlagen', healthy: 'Gesund', degraded: 'Verschlechtert', signed: 'Unterzeichnet', expired: 'Abgelaufen', sent: 'Gesendet', delivered: 'Zugestellt', read: 'Gelesen', qualified: 'Qualifiziert', unqualified: 'Nicht qualifiziert', converted: 'Konvertiert', won: 'Gewonnen', lost: 'Verloren', listed: 'Gelistet', sold: 'Verkauft', writeoff: 'Abgeschrieben', suspended: 'Suspendiert', verified: 'Verifiziert', checkedIn: 'Eingecheckt', checkedOut: 'Ausgecheckt', disputed: 'Streitig', released: 'Freigegeben', refunded: 'Erstattet', scheduled: 'Geplant', inProgress: 'In Bearbeitung', overdue: 'Überfällig', compliant: 'Konform', nonCompliant: 'Nicht konform', underReview: 'Überprüfung', new: 'Neu', paused: 'Pausiert' },
  es: { active: 'Activo', inactive: 'Inactivo', pending: 'Pendiente', completed: 'Completado', draft: 'Borrador', published: 'Publicado', archived: 'Archivado', confirmed: 'Confirmado', cancelled: 'Cancelado', approved: 'Aprobado', rejected: 'Rechazado', resolved: 'Resuelto', connected: 'Conectado', disconnected: 'Desconectado', failed: 'Fallido', healthy: 'Saludable', degraded: 'Degradeado', signed: 'Firmado', expired: 'Expirado', sent: 'Enviado', delivered: 'Entregado', read: 'Leído', qualified: 'Calificado', unqualified: 'No calificado', converted: 'Convertido', won: 'Ganado', lost: 'Perdido', listed: 'Listado', sold: 'Vendido', writeoff: 'Dado de baja', suspended: 'Suspendido', verified: 'Verificado', checkedIn: 'Registrado', checkedOut: 'Salida registrada', disputed: 'Disputado', released: 'Liberado', refunded: 'Reembolsado', scheduled: 'Programado', inProgress: 'En progreso', overdue: 'Atrasado', compliant: 'Cumplimiento', nonCompliant: 'No cumple', underReview: 'En revisión', new: 'Nuevo', paused: 'Pausado' },
  fr: { active: 'Actif', inactive: 'Inactif', pending: 'En attente', completed: 'Terminé', draft: 'Brouillon', published: 'Publié', archived: 'Archivé', confirmed: 'Confirmé', cancelled: 'Annulé', approved: 'Approuvé', rejected: 'Rejeté', resolved: 'Résolu', connected: 'Connecté', disconnected: 'Déconnecté', failed: 'Échoué', healthy: 'Sain', degraded: 'Dégradé', signed: 'Signé', expired: 'Expiré', sent: 'Envoyé', delivered: 'Livré', read: 'Lu', qualified: 'Qualifié', unqualified: 'Non qualifié', converted: 'Converti', won: 'Gagné', lost: 'Perdu', listed: 'Listé', sold: 'Vendu', writeoff: 'Comptabilisé', suspended: 'Suspendu', verified: 'Vérifié', checkedIn: 'Enregistré', checkedOut: 'Sorti', disputed: 'Litigieux', released: 'Libéré', refunded: 'Remboursé', scheduled: 'Planifié', inProgress: 'En cours', overdue: 'En retard', compliant: 'Conforme', nonCompliant: 'Non conforme', underReview: 'En cours d\'examen', new: 'Nouveau', paused: 'En pause' },
  ja: { active: 'アクティブ', inactive: '非アクティブ', pending: '保留中', completed: '完了', draft: '下書き', published: '公開済み', archived: 'アーカイブ済み', confirmed: '確認済み', cancelled: 'キャンセル済み', approved: '承認済み', rejected: '却下済み', resolved: '解決済み', connected: '接続済み', disconnected: '切断済み', failed: '失敗', healthy: '正常', degraded: '劣化', signed: '署名済み', expired: '期限切れ', sent: '送信済み', delivered: '配信済み', read: '既読', qualified: '適合', unqualified: '不適合', converted: '変換済み', won: '勝利', lost: '敗北', listed: '掲載済み', sold: '販売済み', writeoff: '消却', suspended: '一時停止', verified: '検証済み', checkedIn: 'チェックイン済み', checkedOut: 'チェックアウト済み', disputed: '争议あり', released: 'リリース済み', refunded: '返金済み', scheduled: 'スケジュール済み', inProgress: '進行中', overdue: '期限超過', compliant: '準拠', nonCompliant: '非準拠', underReview: '審査中', new: '新規', paused: '一時停止' },
  zh: { active: '活跃', inactive: '未激活', pending: '待处理', completed: '已完成', draft: '草稿', published: '已发布', archived: '已归档', confirmed: '已确认', cancelled: '已取消', approved: '已批准', rejected: '已拒绝', resolved: '已解决', connected: '已连接', disconnected: '已断开', failed: '失败', healthy: '健康', degraded: '降级', signed: '已签署', expired: '已过期', sent: '已发送', delivered: '已送达', read: '已读', qualified: '合格', unqualified: '不合格', converted: '已转化', won: '赢', lost: '输', listed: '已上架', sold: '已售出', writeoff: '已核销', suspended: '已暂停', verified: '已验证', checkedIn: '已签到', checkedOut: '已签退', disputed: '有争议', released: '已释放', refunded: '已退款', scheduled: '已安排', inProgress: '进行中', overdue: '逾期', compliant: '合规', nonCompliant: '不合规', underReview: '审查中', new: '新建', paused: '已暂停' },
  ko: { active: '활성', inactive: '비활성', pending: '대기 중', completed: '완료', draft: '초안', published: '게시됨', archived: '보관됨', confirmed: '확인됨', cancelled: '취소됨', approved: '승인됨', rejected: '거부됨', resolved: '해결됨', connected: '연결됨', disconnected: '연결 해제됨', failed: '실패', healthy: '정상', degraded: '저하됨', signed: '서명됨', expired: '만료됨', sent: '전송됨', delivered: '배달됨', read: '읽음', qualified: '적격', unqualified: '부적격', converted: '변환됨', won: '승리', lost: '패배', listed: '등록됨', sold: '판매됨', writeoff: '대손 처리', suspended: '정지됨', verified: '인증됨', checkedIn: '체크인됨', checkedOut: '체크아웃됨', disputed: '이의 있음', released: '해제됨', refunded: '환불됨', scheduled: '예약됨', inProgress: '진행 중', overdue: '연체', compliant: '준수', nonCompliant: '미준수', underReview: '검토 중', new: '새로 만들기', paused: '일시 정지' },
  pt: { active: 'Ativo', inactive: 'Inativo', pending: 'Pendente', completed: 'Concluído', draft: 'Rascunho', published: 'Publicado', archived: 'Arquivado', confirmed: 'Confirmado', cancelled: 'Cancelado', approved: 'Aprovado', rejected: 'Rejeitado', resolved: 'Resolvido', connected: 'Conectado', disconnected: 'Desconectado', failed: 'Falhou', healthy: 'Saudável', degraded: 'Degradado', signed: 'Assinado', expired: 'Expirado', sent: 'Enviado', delivered: 'Entregue', read: 'Lido', qualified: 'Qualificado', unqualified: 'Não qualificado', converted: 'Convertido', won: 'Ganhou', lost: 'Perdeu', listed: 'Listado', sold: 'Vendido', writeoff: 'Baixado', suspended: 'Suspenso', verified: 'Verificado', checkedIn: 'Check-in', checkedOut: 'Check-out', disputed: 'Disputado', released: 'Liberado', refunded: 'Reembolsado', scheduled: 'Agendado', inProgress: 'Em andamento', overdue: 'Atrasado', compliant: 'Conforme', nonCompliant: 'Não conforme', underReview: 'Em revisão', new: 'Novo', paused: 'Pausado' },
  ru: { active: 'Активный', inactive: 'Неактивный', pending: 'Ожидание', completed: 'Завершено', draft: 'Черновик', published: 'Опубликовано', archived: 'В архиве', confirmed: 'Подтверждено', cancelled: 'Отменено', approved: 'Одобрено', rejected: 'Отклонено', resolved: 'Решено', connected: 'Подключено', disconnected: 'Отключено', failed: 'Ошибка', healthy: 'Норма', degraded: 'Деградация', signed: 'Подписано', expired: 'Истекло', sent: 'Отправлено', delivered: 'Доставлено', read: 'Прочитано', qualified: 'Квалифицировано', unqualified: 'Не квалифицировано', converted: 'Конвертировано', won: 'Выиграно', lost: 'Проиграно', listed: 'В списке', sold: 'Продано', writeoff: 'Списано', suspended: 'Приостановлено', verified: 'Проверено', checkedIn: 'Регистрация', checkedOut: 'Выезд', disputed: 'Оспаривается', released: 'Выпущено', refunded: 'Возврат', scheduled: 'Запланировано', inProgress: 'В процессе', overdue: 'Просрочено', compliant: 'Соответствует', nonCompliant: 'Не соответствует', underReview: 'На рассмотрении', new: 'Новый', paused: 'Пауза' },
  it: { active: 'Attivo', inactive: 'Inattivo', pending: 'In sospeso', completed: 'Completato', draft: 'Bozza', published: 'Pubblicato', archived: 'Archiviato', confirmed: 'Confermato', cancelled: 'Annullato', approved: 'Approvato', rejected: 'Rifiutato', resolved: 'Risolto', connected: 'Connesso', disconnected: 'Disconnesso', failed: 'Fallito', healthy: 'Salute', degraded: 'Degrado', signed: 'Firmato', expired: 'Scaduto', sent: 'Inviato', delivered: 'Consegnato', read: 'Letto', qualified: 'Qualificato', unqualified: 'Non qualificato', converted: 'Convertito', won: 'Vinto', lost: 'Perso', listed: 'Elencato', sold: 'Venduto', writeoff: 'Ammortizzato', suspended: 'Sospeso', verified: 'Verificato', checkedIn: 'Check-in', checkedOut: 'Check-out', disputed: 'Contestato', released: 'Rilasciato', refunded: 'Rimborsato', scheduled: 'Programmato', inProgress: 'In corso', overdue: 'In ritardo', compliant: 'Conforme', nonCompliant: 'Non conforme', underReview: 'In revisione', new: 'Nuovo', paused: 'In pausa' },
  nl: { active: 'Actief', inactive: 'Inactief', pending: 'In afwachting', completed: 'Voltooid', draft: 'Concept', published: 'Gepubliceerd', archived: 'Gearchiveerd', confirmed: 'Bevestigd', cancelled: 'Geannuleerd', approved: 'Goedgekeurd', rejected: 'Afgewezen', resolved: 'Opgelost', connected: 'Verbonden', disconnected: 'Verbroken', failed: 'Mislukt', healthy: 'Gezond', degraded: 'Verslechterd', signed: 'Ondertekend', expired: 'Verlopen', sent: 'Verzonden', delivered: 'Afgeleverd', read: 'Gelezen', qualified: 'Gekwalificeerd', unqualified: 'Niet gekwalificeerd', converted: 'Geconverteerd', won: 'Gewonnen', lost: 'Verloren', listed: 'Vermeld', sold: 'Verkocht', writeoff: 'Afgeschreven', suspended: 'Geschorst', verified: 'Geverifieerd', checkedIn: 'Ingecheckt', checkedOut: 'Uitgecheckt', disputed: 'Betwist', released: 'Vrijgegeven', refunded: 'Terugbetaald', scheduled: 'Gepland', inProgress: 'Bezig', overdue: 'Achterstallig', compliant: 'Conform', nonCompliant: 'Niet conform', underReview: 'In beoordeling', new: 'Nieuw', paused: 'Gepauzeerd' },
  da: { active: 'Aktiv', inactive: 'Inaktiv', pending: 'Afventende', completed: 'Fuldført', draft: 'Kladde', published: 'Offentliggjort', archived: 'Arkiveret', confirmed: 'Bekræftet', cancelled: 'Annulleret', approved: 'Godkendt', rejected: 'Afvist', resolved: 'Løst', connected: 'Tilsluttet', disconnected: 'Afbrudt', failed: 'Mislykket', healthy: 'Sund', degraded: 'Forringet', signed: 'Underskrevet', expired: 'Udløbet', sent: 'Sendt', delivered: 'Leveret', read: 'Læst', qualified: 'Kvalificeret', unqualified: 'Ikke kvalificeret', converted: 'Konverteret', won: 'Vundet', lost: 'Tabt', listed: 'Oplistet', sold: 'Solgt', writeoff: 'Afskrevet', suspended: 'Suspenderet', verified: 'Verificeret', checkedIn: 'Indtjekket', checkedOut: 'Udtjekket', disputed: 'Tvistet', released: 'Frigivet', refunded: 'Tilbagebetalt', scheduled: 'Planlagt', inProgress: 'I gang', overdue: 'Forsinket', compliant: 'Overholder', nonCompliant: 'Overholder ikke', underReview: 'Under gennemgang', new: 'Ny', paused: 'Pauset' },
  fi: { active: 'Aktiivinen', inactive: 'Epäaktiivinen', pending: 'Odottaa', completed: 'Valmis', draft: 'Luonnos', published: 'Julkaistu', archived: 'Arkistoitu', confirmed: 'Vahvistettu', cancelled: 'Peruutettu', approved: 'Hyväksytty', rejected: 'Hylätty', resolved: 'Ratkaistu', connected: 'Yhdistetty', disconnected: 'Katkaistu', failed: 'Epäonnistunut', healthy: 'Terve', degraded: 'Heikentynyt', signed: 'Allekirjoitettu', expired: 'Vanhentunut', sent: 'Lähetetty', delivered: 'Toimitettu', read: 'Luettu', qualified: 'Pätevä', unqualified: 'Ei pätevä', converted: 'Muunnettu', won: 'Voitettu', lost: 'Hävitty', listed: 'Listattu', sold: 'Myyty', writeoff: 'Kirjattu pois', suspended: 'Jäädytetty', verified: 'Vahvistettu', checkedIn: 'Sisäänkirjautunut', checkedOut: 'Uloskirjautunut', disputed: 'Riitautettu', released: 'Vapautettu', refunded: 'Hyvitetty', scheduled: 'Aikataulutettu', inProgress: 'Käynnissä', overdue: 'Myöhässä', compliant: 'Noudattaa', nonCompliant: 'Ei noudata', underReview: 'Tarkistettavana', new: 'Uusi', paused: 'Keskeytetty' },
  no: { active: 'Aktiv', inactive: 'Inaktiv', pending: 'Ventende', completed: 'Fullført', draft: 'Utkast', published: 'Publisert', archived: 'Arkivert', confirmed: 'Bekreftet', cancelled: 'Kansellert', approved: 'Godkjent', rejected: 'Avvist', resolved: 'Løst', connected: 'Tilkoblet', disconnected: 'Frakoblet', failed: 'Mislyktes', healthy: 'Frisk', degraded: 'Forringet', signed: 'Signert', expired: 'Utløpt', sent: 'Sendt', delivered: 'Levert', read: 'Lest', qualified: 'Kvalifisert', unqualified: 'Ikke kvalifisert', converted: 'Konvertert', won: 'Vunnet', lost: 'Tapt', listed: 'Oppført', sold: 'Solgt', writeoff: 'Avskrevet', suspended: 'Suspendert', verified: 'Verifisert', checkedIn: 'Innsjekket', checkedOut: 'Utsjekket', disputed: 'Omtvistet', released: 'Frigitt', refunded: 'Tilbakebetalt', scheduled: 'Planlagt', inProgress: 'Pågående', overdue: 'Forsinket', compliant: 'I samsvar', nonCompliant: 'Ikke i samsvar', underReview: 'Under vurdering', new: 'Ny', paused: 'Pauset' },
  pl: { active: 'Aktywny', inactive: 'Nieaktywny', pending: 'Oczekujące', completed: 'Zakończone', draft: 'Szkic', published: 'Opublikowany', archived: 'Zarchiwizowany', confirmed: 'Potwierdzone', cancelled: 'Anulowane', approved: 'Zatwierdzone', rejected: 'Odrzucone', resolved: 'Rozwiązane', connected: 'Połączone', disconnected: 'Rozłączone', failed: 'Nieudane', healthy: 'Zdrowy', degraded: 'Pogorszony', signed: 'Podpisane', expired: 'Wygasłe', sent: 'Wysłane', delivered: 'Dostarczone', read: 'Przeczytane', qualified: 'Kwalifikowane', unqualified: 'Nie kwalifikowane', converted: 'Przekształcone', won: 'Wygrane', lost: 'Przegrane', listed: 'Wymienione', sold: 'Sprzedane', writeoff: 'Spisane', suspended: 'Zawieszone', verified: 'Zweryfikowane', checkedIn: 'Zameldowany', checkedOut: 'Wymeldowany', disputed: 'Sporne', released: 'Zwolnione', refunded: 'Zwrócone', scheduled: 'Zaplanowane', inProgress: 'W toku', overdue: 'Zaległe', compliant: 'Zgodne', nonCompliant: 'Niezgodne', underReview: 'W trakcie przeglądu', new: 'Nowy', paused: 'Wstrzymane' },
  se: { active: 'Aktiv', inactive: 'Inaktiv', pending: 'Väntande', completed: 'Slutförd', draft: 'Utkast', published: 'Publicerad', archived: 'Arkiverad', confirmed: 'Bekräftad', cancelled: 'Avbruten', approved: 'Godkänd', rejected: 'Avvisad', resolved: 'Löst', connected: 'Ansluten', disconnected: 'Frånkopplad', failed: 'Misslyckad', healthy: 'Frisk', degraded: 'Försämrad', signed: 'Signerad', expired: 'Utgången', sent: 'Skickad', delivered: 'Levererad', read: 'Läst', qualified: 'Kvalificerad', unqualified: 'Ej kvalificerad', converted: 'Konverterad', won: 'Vunnen', lost: 'Förlorad', listed: 'Listad', sold: 'Såld', writeoff: 'Avskriven', suspended: 'Suspenderad', verified: 'Verifierad', checkedIn: 'Incheckad', checkedOut: 'Utcheckad', disputed: 'Omtvistad', released: 'Frigiven', refunded: 'Återbetalad', scheduled: 'Schemalagd', inProgress: 'Pågående', overdue: 'Försenad', compliant: 'I överensstämmelse', nonCompliant: 'Ej i överensstämmelse', underReview: 'Under granskning', new: 'Ny', paused: 'Pausad' },
  hi: { active: 'सक्रिय', inactive: 'निष्क्रिय', pending: 'लंबित', completed: 'पूर्ण', draft: 'ड्राफ्ट', published: 'प्रकाशित', archived: 'संग्रहीत', confirmed: 'पुष्टि', cancelled: 'रद्द', approved: 'अनुमोदित', rejected: 'अस्वीकृत', resolved: 'हल', connected: 'जुड़ा हुआ', disconnected: 'वियोजित', failed: 'विफल', healthy: 'स्वस्थ', degraded: 'क्षीण', signed: 'हस्ताक्षरित', expired: 'समाप्त', sent: 'भेजा गया', delivered: 'वितरित', read: 'पढ़ा गया', qualified: 'योग्य', unqualified: 'अयोग्य', converted: 'रूपांतरित', won: 'जीता', lost: 'हारा', listed: 'सूचीबद्ध', sold: 'बेचा गया', writeoff: 'लिखाफ', suspended: 'निलंबित', verified: 'सत्यापित', checkedIn: 'चेक इन', checkedOut: 'चेक आउट', disputed: 'विवादित', released: 'मुक्त', refunded: 'वापस', scheduled: 'निर्धारित', inProgress: 'प्रगति में', overdue: 'अतिदेय', compliant: 'अनुपालन', nonCompliant: 'गैर-अनुपालन', underReview: 'समीक्षा में', new: 'नया', paused: 'रुका हुआ' },
};

// OS module names
const OS_MODULES = ['listingOs', 'agentOs', 'financeOs', 'bookingOs', 'investmentOs', 'operationsOs', 'securityOs', 'governanceOs', 'partnerOs', 'developerOs', 'analyticsOs', 'documentOs', 'notificationOs', 'userOs', 'adsOs', 'identityOs', 'localizationOs', 'commerceOs', 'crmOs', 'portfolioOs', 'platformOs'];

function processDirectory(localesDir, osKeys, label) {
  console.log(`\n--- Processing ${label}: ${localesDir} ---`);

  if (!fs.existsSync(localesDir)) {
    console.log(`⚠️  Directory not found: ${localesDir}`);
    return;
  }

  const langFiles = fs.readdirSync(localesDir).filter(f => f.endsWith('.json'));

  for (const langFile of langFiles) {
    const langCode = langFile.replace('.json', '');
    const langPath = path.join(localesDir, langFile);
    const langData = JSON.parse(fs.readFileSync(langPath, 'utf8'));

    let keysAdded = 0;

    for (const [key, value] of Object.entries(osKeys)) {
      if (!langData[key]) {
        // Use language-specific translations if available
        const translations = LANGUAGE_MAP[langCode];
        if (translations && typeof value === 'object' && !Array.isArray(value)) {
          const translated = {};
          for (const [k, v] of Object.entries(value)) {
            translated[k] = translations[k] || v;
          }
          langData[key] = translated;
        } else if (translations && typeof value === 'string') {
          langData[key] = translations[value] || value;
        } else {
          langData[key] = value;
        }
        keysAdded++;
      }
    }

    // Write back
    fs.writeFileSync(langPath, JSON.stringify(langData, null, 2) + '\n', 'utf8');
    console.log(`✅ ${langFile}: ${keysAdded} keys added (total: ${Object.keys(langData).length})`);
  }
}

function main() {
  const enPath = path.join(CLIENT_LOCALES_DIR, 'en.json');
  const enData = JSON.parse(fs.readFileSync(enPath, 'utf8'));

  // Get all OS keys from en.json
  const osKeys = {};
  for (const osName of OS_MODULES) {
    for (const [key, value] of Object.entries(enData)) {
      if (key.startsWith(`${osName}.`)) {
        osKeys[key] = value;
      }
    }
  }

  console.log(`Found ${Object.keys(osKeys).length} OS keys in en.json`);

  // Process client locales
  processDirectory(CLIENT_LOCALES_DIR, osKeys, 'client');

  // Process client-seo locales
  processDirectory(CLIENT_SEO_LOCALES_DIR, osKeys, 'client-seo');

  console.log('\n✅ All language files updated!');
}

main();
