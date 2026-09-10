class Especialista {
  final String id;
  final String nombre;
  final String titulo;
  final String especialidadPrincipal;
  final List<String> especialidadesSecundarias;
  final List<String> cultivos;
  final String zonaCobertura;
  final int aniosExperiencia;
  final double calificacion;
  final int numeroCalificaciones;
  final int consultasAtendidas;
  final String tiempoRespuestaPromedio;
  final List<String> modalidad;
  final String tarifaConsulta;
  final String? telefono;
  final bool disponible;

  const Especialista({
    required this.id,
    required this.nombre,
    required this.titulo,
    required this.especialidadPrincipal,
    required this.especialidadesSecundarias,
    required this.cultivos,
    required this.zonaCobertura,
    required this.aniosExperiencia,
    required this.calificacion,
    required this.numeroCalificaciones,
    required this.consultasAtendidas,
    required this.tiempoRespuestaPromedio,
    required this.modalidad,
    required this.tarifaConsulta,
    this.telefono,
    this.disponible = true,
  });

  /// Insignia automática calculada según las reglas de negocio
  String get insignia {
    if (calificacion >= 4.8 && consultasAtendidas >= 50) {
      return "Especialista Top";
    }
    if (consultasAtendidas < 5) {
      return "Nuevo en la plataforma";
    }
    // "Recomendado para tu caso" será inyectado por el controlador si hace match con el diagnóstico
    return ""; 
  }

  factory Especialista.fromJson(Map<String, dynamic> json) {
    return Especialista(
      id: json['id'] as String,
      nombre: json['nombre'] as String,
      titulo: json['titulo'] as String,
      especialidadPrincipal: json['especialidad_principal'] as String,
      especialidadesSecundarias: List<String>.from(json['especialidades_secundarias']),
      cultivos: List<String>.from(json['cultivos']),
      zonaCobertura: json['zona_cobertura'] as String,
      aniosExperiencia: json['anios_experiencia'] as int,
      calificacion: (json['calificacion'] as num).toDouble(),
      numeroCalificaciones: json['numero_calificaciones'] as int,
      consultasAtendidas: json['consultas_atendidas'] as int,
      tiempoRespuestaPromedio: json['tiempo_respuesta_promedio'] as String,
      modalidad: List<String>.from(json['modalidad']),
      tarifaConsulta: json['tarifa_consulta'] as String,
      telefono: json['telefono'] as String?,
      disponible: json['disponible'] as bool? ?? true,
    );
  }
}
