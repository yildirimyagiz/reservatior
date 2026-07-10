"""
Support Analysis Service
AI-powered ticket classification, priority assessment, and automatic routing
Uses Gemini API for intelligent analysis and ML for file type classification
Includes language detection and multi-language response support
"""

import os
import json
from typing import Dict, List, Any, Optional, Tuple
from datetime import datetime
from enum import Enum
import re
from langdetect import detect, LangDetectException

class TicketCategory(Enum):
    """Ticket category classification"""
    TECHNICAL = "technical"
    BILLING = "billing"
    ACCOUNT = "account"
    PROPERTY = "property"
    BOOKING = "booking"
    LEGAL = "legal"
    OTHER = "other"

class TicketPriority(Enum):
    """Ticket priority levels"""
    CRITICAL = "critical"
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"

class FileType(Enum):
    """Supported file types for analysis"""
    PDF = "pdf"
    IMAGE = "image"
    DOCUMENT = "document"
    SPREADSHEET = "spreadsheet"
    CONTRACT = "contract"
    RECEIPT = "receipt"
    OTHER = "other"

class TicketAnalyzer:
    def __init__(self):
        self.gemini_api_key = os.getenv("GEMINI_API_KEY")
        
        # Language mappings for responses
        self.language_responses = {
            "en": {
                "greeting": "I understand your issue. Based on your description, I recommend creating a support ticket.",
                "ticket_created": "Your ticket has been created. We will get back to you soon.",
                "technical": "Our technical team will investigate the issue. Please provide any error messages or screenshots.",
                "billing": "Our finance team will review your billing concern. Please check your invoice details.",
                "account": "Please verify your account information. Our team will assist with account-related issues.",
                "property": "Our property specialists will help with your real estate inquiry.",
                "booking": "Our booking team will review your reservation and assist accordingly.",
                "legal": "Our legal team will review this matter. Please ensure all relevant documents are attached."
            },
            "tr": {
                "greeting": "Sorununuzu anladım. Açıklamanıza dayanarak, bir destek talebi oluşturmanızı öneriyorum.",
                "ticket_created": "Talebiniz oluşturuldu. En kısa sürede size dönüş yapacağız.",
                "technical": "Teknik ekibimiz sorunu inceleyecek. Lütfen hata mesajlarını veya ekran görüntülerini sağlayın.",
                "billing": "Finans ekibimiz fatura endişenizi inceleyecek. Lütfen fatura detaylarınızı kontrol edin.",
                "account": "Lütfen hesap bilgilerinizi doğrulayın. Ekibimiz hesapla ilgili konularda yardımcı olacaktır.",
                "property": "Gayrimenkul uzmanlarımız gayrimenkul soruşturmanıza yardımcı olacak.",
                "booking": "Rezervasyon ekibimiz rezervasyonunuzu inceleyecek ve buna göre yardımcı olacaktır.",
                "legal": "Hukuk ekibimiz bu konuyu inceleyecek. Lütfen ilgili tüm belgelerin ekli olduğundan emin olun."
            },
            "de": {
                "greeting": "Ich habe Ihr Problem verstanden. Basierend auf Ihrer Beschreibung empfehle ich, ein Support-Ticket zu erstellen.",
                "ticket_created": "Ihr Ticket wurde erstellt. Wir werden uns bald bei Ihnen melden.",
                "technical": "Unser technisches Team wird das Problem untersuchen. Bitte geben Sie Fehlermeldungen oder Screenshots an.",
                "billing": "Unser Finanzteam wird Ihre Abrechnungsbedenken prüfen. Bitte überprüfen Sie Ihre Rechnungsdetails.",
                "account": "Bitte überprüfen Sie Ihre Kontoinformationen. Unser Team hilft bei kontobezogenen Problemen.",
                "property": "Unsere Immobilienspezialisten helfen bei Ihrer Immobiliensuche.",
                "booking": "Unser Buchungsteam prüft Ihre Reservierung und hilft entsprechend.",
                "legal": "Unser Rechtsteam wird diese Angelegenheit prüfen. Bitte stellen Sie sicher, dass alle relevanten Dokumente angehängt sind."
            },
            "fr": {
                "greeting": "J'ai compris votre problème. Sur la base de votre description, je recommande de créer un ticket de support.",
                "ticket_created": "Votre ticket a été créé. Nous vous répondrons bientôt.",
                "technical": "Notre équipe technique enquêtera sur le problème. Veuillez fournir des messages d'erreur ou des captures d'écran.",
                "billing": "Notre équipe financière examinera vos préoccupations de facturation. Veuillez vérifier les détails de votre facture.",
                "account": "Veuillez vérifier vos informations de compte. Notre équipe aidera avec les problèmes liés au compte.",
                "property": "Nos spécialistes immobiliers vous aideront dans votre recherche immobilière.",
                "booking": "Notre équipe de réservation examinera votre réservation et vous aidera en conséquence.",
                "legal": "Notre équipe juridique examinera cette question. Veuillez vous assurer que tous les documents pertinents sont joints."
            },
            "es": {
                "greeting": "Entiendo su problema. Basado en su descripción, recomiendo crear un ticket de soporte.",
                "ticket_created": "Su ticket ha sido creado. Le responderemos pronto.",
                "technical": "Nuestro equipo técnico investigará el problema. Proporcione mensajes de error o capturas de pantalla.",
                "billing": "Nuestro equipo financiero revisará sus preocupaciones de facturación. Verifique los detalles de su factura.",
                "account": "Verifique su información de cuenta. Nuestro equipo ayudará con problemas relacionados con la cuenta.",
                "property": "Nuestros especialistas en bienes raíces ayudarán con su consulta inmobiliaria.",
                "booking": "Nuestro equipo de reservas revisará su reserva y ayudará en consecuencia.",
                "legal": "Nuestro equipo legal revisará este asunto. Asegúrese de que todos los documentos relevantes estén adjuntos."
            }
        }
        
        self.category_keywords = {
            TicketCategory.TECHNICAL: [
                "error", "bug", "crash", "not working", "broken", "login", "password",
                "server", "database", "api", "connection", "timeout", "slow", "loading",
                "technical", "system", "platform", "website", "app", "mobile"
            ],
            TicketCategory.BILLING: [
                "payment", "invoice", "charge", "refund", "billing", "credit card",
                "subscription", "price", "cost", "fee", "money", "transaction", "receipt",
                "overcharge", "duplicate", "cancel subscription"
            ],
            TicketCategory.ACCOUNT: [
                "account", "profile", "settings", "verification", "email", "phone",
                "password reset", "login issue", "signup", "register", "delete account",
                "personal information", "user", "authentication"
            ],
            TicketCategory.PROPERTY: [
                "property", "listing", "real estate", "house", "apartment", "villa",
                "rent", "sale", "buy", "investment", "location", "amenities", "photos",
                "description", "price", "valuation", "market"
            ],
            TicketCategory.BOOKING: [
                "booking", "reservation", "check-in", "check-out", "availability",
                "calendar", "dates", "guest", "cancel booking", "modify booking",
                "confirmation", "stay", "accommodation"
            ],
            TicketCategory.LEGAL: [
                "contract", "agreement", "legal", "terms", "conditions", "compliance",
                "dispute", "liability", "insurance", "regulation", "law", "court",
                "solicitor", "notary", "document", "signature"
            ]
        }
        
        self.priority_indicators = {
            TicketPriority.CRITICAL: [
                "urgent", "emergency", "critical", "immediate", "security breach",
                "data loss", "system down", "payment failed", "legal issue",
                "fraud", "scam", "harassment", "danger", "safety"
            ],
            TicketPriority.HIGH: [
                "important", "priority", "asap", "soon", "cannot access",
                "blocked", "stuck", "broken", "not working", "error",
                "complaint", "dissatisfied", "unhappy"
            ],
            TicketPriority.MEDIUM: [
                "question", "how to", "help", "support", "inquiry",
                "information", "clarification", "feature request", "suggestion"
            ],
            TicketPriority.LOW: [
                "feedback", "comment", "minor", "cosmetic", "typo",
                "suggestion", "improvement", "nice to have"
            ]
        }
        
        self.file_type_patterns = {
            FileType.PDF: [r'\.pdf$'],
            FileType.IMAGE: [r'\.(jpg|jpeg|png|gif|webp|bmp)$'],
            FileType.DOCUMENT: [r'\.(doc|docx|txt|rtf)$'],
            FileType.SPREADSHEET: [r'\.(xls|xlsx|csv)$'],
            FileType.CONTRACT: [r'\.(pdf|docx)$'],  # Contract files typically PDF or DOCX
            FileType.RECEIPT: [r'\.(pdf|jpg|jpeg|png)$']  # Receipts typically PDF or image
        }

    def detect_language(self, text: str) -> str:
        """Detect the language of the input text"""
        try:
            lang = detect(text)
            # Map detected language to supported languages
            supported_langs = {"en", "tr", "de", "fr", "es"}
            if lang in supported_langs:
                return lang
            # Map common variants
            lang_map = {
                "en-us": "en", "en-gb": "en",
                "tr-tr": "tr",
                "de-de": "de",
                "fr-fr": "fr",
                "es-es": "es", "es-mx": "es"
            }
            return lang_map.get(lang.lower(), "en")  # Default to English
        except LangDetectException:
            return "en"  # Default to English if detection fails

    def get_localized_response(self, key: str, language: str) -> str:
        """Get localized response based on language"""
        return self.language_responses.get(language, self.language_responses["en"]).get(key, self.language_responses["en"][key])

    def classify_file_type(self, filename: str) -> FileType:
        """Classify file type based on filename"""
        filename_lower = filename.lower()
        
        for file_type, patterns in self.file_type_patterns.items():
            for pattern in patterns:
                if re.search(pattern, filename_lower):
                    return file_type
        
        return FileType.OTHER

    def analyze_text_category(self, text: str) -> Tuple[TicketCategory, float]:
        """Analyze text to determine ticket category with confidence score"""
        text_lower = text.lower()
        category_scores = {}
        
        for category, keywords in self.category_keywords.items():
            score = 0
            for keyword in keywords:
                if keyword in text_lower:
                    score += 1
            category_scores[category] = score
        
        if not category_scores:
            return TicketCategory.OTHER, 0.0
        
        best_category = max(category_scores, key=category_scores.get)
        max_score = category_scores[best_category]
        total_score = sum(category_scores.values())
        confidence = max_score / total_score if total_score > 0 else 0.0
        
        return best_category, confidence

    def assess_priority(self, text: str, category: TicketCategory) -> TicketPriority:
        """Assess ticket priority based on text content and category"""
        text_lower = text.lower()
        priority_scores = {}
        
        for priority, indicators in self.priority_indicators.items():
            score = 0
            for indicator in indicators:
                if indicator in text_lower:
                    score += 1
            priority_scores[priority] = score
        
        if not priority_scores:
            # Default priority based on category
            if category == TicketCategory.LEGAL:
                return TicketPriority.HIGH
            elif category == TicketCategory.BILLING:
                return TicketPriority.HIGH
            elif category == TicketCategory.TECHNICAL:
                return TicketPriority.MEDIUM
            else:
                return TicketPriority.MEDIUM
        
        best_priority = max(priority_scores, key=priority_scores.get)
        return best_priority

    def extract_entities(self, text: str) -> Dict[str, List[str]]:
        """Extract key entities from ticket text"""
        entities = {
            "emails": re.findall(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', text),
            "phone_numbers": re.findall(r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b', text),
            "dates": re.findall(r'\b\d{1,2}[-/]\d{1,2}[-/]\d{2,4}\b', text),
            "property_ids": re.findall(r'\bprop[_-]?[a-zA-Z0-9]+\b', text, re.IGNORECASE),
            "booking_ids": re.findall(r'\bbook[_-]?[a-zA-Z0-9]+\b', text, re.IGNORECASE),
            "ticket_ids": re.findall(r'\bticket[_-]?[a-zA-Z0-9]+\b', text, re.IGNORECASE)
        }
        return entities

    def determine_escalation(self, category: TicketCategory, priority: TicketPriority, 
                           has_attachments: bool) -> Dict[str, Any]:
        """Determine if ticket needs escalation and to whom"""
        escalation_rules = {
            "needs_escalation": False,
            "escalate_to": None,
            "reason": None,
            "response_time": "24 hours"
        }
        
        if priority == TicketPriority.CRITICAL:
            escalation_rules.update({
                "needs_escalation": True,
                "escalate_to": "management",
                "reason": "Critical priority issue requiring immediate attention",
                "response_time": "1 hour"
            })
        elif category == TicketCategory.LEGAL and priority in [TicketPriority.HIGH, TicketPriority.CRITICAL]:
            escalation_rules.update({
                "needs_escalation": True,
                "escalate_to": "legal_team",
                "reason": "Legal matter requiring expert review",
                "response_time": "4 hours"
            })
        elif category == TicketCategory.BILLING and priority == TicketPriority.HIGH:
            escalation_rules.update({
                "needs_escalation": True,
                "escalate_to": "finance_team",
                "reason": "High priority billing issue",
                "response_time": "8 hours"
            })
        elif has_attachments and category == TicketCategory.TECHNICAL:
            escalation_rules.update({
                "needs_escalation": True,
                "escalate_to": "technical_support",
                "reason": "Technical issue with file attachments requiring review",
                "response_time": "4 hours"
            })
        
        return escalation_rules

    async def analyze_with_gemini(self, message: str, attachments: List[str] = None) -> Dict[str, Any]:
        """Use Gemini API for advanced ticket analysis with language detection"""
        # Detect language first
        detected_language = self.detect_language(message)
        
        if not self.gemini_api_key:
            return self.fallback_analysis(message, attachments, detected_language)
        
        try:
            import google.generativeai as genai
            
            genai.configure(api_key=self.gemini_api_key)
            model = genai.GenerativeModel('gemini-pro')
            
            # Language-specific prompt
            language_prompts = {
                "en": "Analyze this support ticket and provide a structured response:",
                "tr": "Bu destek talebini analiz edin ve yapılandırılmış bir yanıt sağlayın:",
                "de": "Analysieren Sie dieses Support-Ticket und geben Sie eine strukturierte Antwort:",
                "fr": "Analysez ce ticket de support et fournissez une réponse structurée:",
                "es": "Analice este ticket de soporte y proporcione una respuesta estructurada:"
            }
            
            prompt = f"""
            {language_prompts.get(detected_language, language_prompts['en'])}
            
            User Message: {message}
            Attachments: {attachments if attachments else 'None'}
            Language: {detected_language}
            
            Please provide:
            1. Category (technical, billing, account, property, booking, legal, other)
            2. Priority (critical, high, medium, low)
            3. Summary of the issue
            4. Suggested solution or next steps (in {detected_language})
            5. Which team should handle this
            6. Estimated response time
            7. Any follow-up questions needed
            
            Format as JSON.
            """
            
            response = model.generate_content(prompt)
            result = response.text
            
            # Try to parse as JSON
            try:
                analysis = json.loads(result)
                return {
                    "ai_analyzed": True,
                    "category": analysis.get("category", "other"),
                    "priority": analysis.get("priority", "medium"),
                    "summary": analysis.get("summary", ""),
                    "suggested_solution": analysis.get("suggested_solution", ""),
                    "assigned_team": analysis.get("which_team", "support"),
                    "response_time": analysis.get("estimated_response_time", "24 hours"),
                    "follow_up_questions": analysis.get("follow_up_questions", []),
                    "confidence": 0.85,
                    "detected_language": detected_language,
                    "localized_greeting": self.get_localized_response("greeting", detected_language)
                }
            except json.JSONDecodeError:
                return self.fallback_analysis(message, attachments, detected_language)
                
        except Exception as e:
            print(f"Gemini API error: {e}")
            return self.fallback_analysis(message, attachments, detected_language)

    def fallback_analysis(self, message: str, attachments: List[str] = None, language: str = "en") -> Dict[str, Any]:
        """Fallback analysis using rule-based approach with language support"""
        # Detect language if not provided
        if language == "en":
            language = self.detect_language(message)
        
        category, confidence = self.analyze_text_category(message)
        priority = self.assess_priority(message, category)
        entities = self.extract_entities(message)
        escalation = self.determine_escalation(category, priority, bool(attachments))
        
        # Analyze file types if attachments present
        file_analysis = []
        if attachments:
            for attachment in attachments:
                file_type = self.classify_file_type(attachment)
                file_analysis.append({
                    "filename": attachment,
                    "type": file_type.value,
                    "requires_review": file_type in [FileType.CONTRACT, FileType.LEGAL]
                })
        
        # Get localized response based on category
        category_key = category.value if isinstance(category, TicketCategory) else category
        suggested_solution = self.get_localized_response(category_key, language)
        
        return {
            "ai_analyzed": False,
            "category": category.value if isinstance(category, TicketCategory) else category,
            "priority": priority.value if isinstance(priority, TicketPriority) else priority,
            "confidence": confidence,
            "entities": entities,
            "file_analysis": file_analysis,
            "escalation": escalation,
            "summary": message[:200] + "..." if len(message) > 200 else message,
            "suggested_solution": suggested_solution,
            "assigned_team": self.get_assigned_team(category, priority),
            "response_time": escalation["response_time"],
            "detected_language": language,
            "localized_greeting": self.get_localized_response("greeting", language)
        }

    def get_suggested_solution(self, category: TicketCategory, priority: TicketPriority) -> str:
        """Get suggested solution based on category and priority"""
        solutions = {
            TicketCategory.TECHNICAL: "Our technical team will investigate the issue. Please provide any error messages or screenshots.",
            TicketCategory.BILLING: "Our finance team will review your billing concern. Please check your invoice details.",
            TicketCategory.ACCOUNT: "Please verify your account information. Our team will assist with account-related issues.",
            TicketCategory.PROPERTY: "Our property specialists will help with your real estate inquiry.",
            TicketCategory.BOOKING: "Our booking team will review your reservation and assist accordingly.",
            TicketCategory.LEGAL: "Our legal team will review this matter. Please ensure all relevant documents are attached."
        }
        return solutions.get(category, "Our support team will review your inquiry and respond shortly.")

    def get_assigned_team(self, category: TicketCategory, priority: TicketPriority) -> str:
        """Determine which team should handle the ticket"""
        team_mapping = {
            TicketCategory.TECHNICAL: "technical_support",
            TicketCategory.BILLING: "finance_team",
            TicketCategory.ACCOUNT: "customer_service",
            TicketCategory.PROPERTY: "property_specialists",
            TicketCategory.BOOKING: "booking_team",
            TicketCategory.LEGAL: "legal_team"
        }
        return team_mapping.get(category, "general_support")

# Singleton instance
support_analyzer = TicketAnalyzer()
