import '../domain/models/chat_message.dart';

class ChatbotRepository {
  List<ChatMessage> getInitialMessages() {
    return [
      const ChatMessage(
        id: '1',
        text: '¿Cómo puedo obtener promociones y descuentos por volumen en semillas de tomate?',
        time: '09:41 AM',
        isUser: true,
      ),
      const ChatMessage(
        id: '2',
        text: 'Actualmente ofrecemos un 15% de descuento en todos los lotes certificados de Solanaceae Primavera 2025. También desbloqueas automáticamente tarifas mayoristas en pedidos superiores a 5 kg.',
        time: '09:41 AM',
        isUser: false,
        type: ChatMessageType.product,
        metadata: {
          'title': 'San Marzano Lampadina',
          'scientific': 'Solanum lycopersicum • Certified Non-GMO',
          'price': '\$14.50',
          'originalPrice': '\$17.00/paq',
          'lot': 'Lot #SM-2025',
          'discount': '15% DE DESCUENTO',
          'germination': '98.2% (ISTA Verificado)',
          'maturity': '78 - 82 Días',
        },
      ),
      const ChatMessage(
        id: '3',
        text: 'Agrégalo al calendario: Ciclo de siembra para San Marzano en Parcela 4 mañana a las 7:30 AM',
        time: '09:43 AM',
        isUser: true,
      ),
      const ChatMessage(
        id: '4',
        text: '¡Labor programada con éxito! La he sincronizado con tu calendario agronómico de Valle Verde y notifiqué a la cuadrilla de campo #2.',
        time: '09:43 AM',
        isUser: false,
        type: ChatMessageType.taskConfirmation,
        metadata: {
          'title': 'Siembra Directa: San Marzano Lampadina',
          'time': 'Mañana, 07:30 AM',
          'plot': 'Parcela 4 (Terraza Norte)',
          'priority': 'Alta Prioridad',
        },
      ),
    ];
  }
}
