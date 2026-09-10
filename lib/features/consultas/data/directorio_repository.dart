import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/especialista.dart';

final directorioRepositoryProvider = Provider<DirectorioRepository>((ref) {
  return DirectorioRepository();
});

class DirectorioRepository {
  // Mock data as specified in the Ficha Técnica
  final Map<String, dynamic> _mockData = {
    "especialistas": [
      {
        "id": "esp_000",
        "nombre": "Robert Fernando Hoyos Gonzales",
        "titulo": "Ingeniero en Recursos Naturales Renovables",
        "especialidad_principal": "Germinación y propagación in vitro (Biotecnología)",
        "especialidades_secundarias": ["Cultivo in vitro", "Biología celular"],
        "cultivos": ["Café", "Cacao", "Orquídeas"],
        "zona_cobertura": "Huánuco, Tingo María",
        "anios_experiencia": 5,
        "calificacion": 5.0,
        "numero_calificaciones": 60,
        "consultas_atendidas": 150,
        "tiempo_respuesta_promedio": "Responde en menos de 5 h",
        "modalidad": ["Videollamada", "Llamada telefónica"],
        "tarifa_consulta": "S/ 30 la primera consulta",
        "telefono": "952289902",
        "disponible": true
      },
      {
        "id": "esp_001",
        "nombre": "Rosa Quispe Mamani",
        "titulo": "Ingeniera Agrónoma",
        "especialidad_principal": "Manejo de plagas y enfermedades en papa",
        "especialidades_secundarias": ["Entomología agrícola", "Cultivos andinos"],
        "cultivos": ["Papa", "Maíz amiláceo", "Habas"],
        "zona_cobertura": "Puno, Cusco",
        "anios_experiencia": 9,
        "calificacion": 4.9,
        "numero_calificaciones": 41,
        "consultas_atendidas": 118,
        "tiempo_respuesta_promedio": "Responde en menos de 12 h",
        "modalidad": ["Videollamada", "Llamada telefónica"],
        "tarifa_consulta": "S/ 20 la primera consulta"
      },
      {
        "id": "esp_002",
        "nombre": "Jhon Torres Vilca",
        "titulo": "Ingeniero Agrónomo",
        "especialidad_principal": "Fertilización y manejo de suelos ácidos de sierra",
        "especialidades_secundarias": ["Edafología", "Riego tecnificado"],
        "cultivos": ["Papa", "Quinua", "Cebada"],
        "zona_cobertura": "Cusco, Apurímac",
        "anios_experiencia": 6,
        "calificacion": 4.7,
        "numero_calificaciones": 19,
        "consultas_atendidas": 63,
        "tiempo_respuesta_promedio": "Responde en menos de 24 h",
        "modalidad": ["Videollamada", "Visita a campo (zona Cusco)"],
        "tarifa_consulta": "S/ 15 la primera consulta",
        "disponible": false
      },
      {
        "id": "esp_003",
        "nombre": "Milagros Effio Chávez",
        "titulo": "Ingeniera Forestal",
        "especialidad_principal": "Agroforestería y sistemas de sombra en café y cacao",
        "especialidades_secundarias": ["Reforestación de laderas", "Manejo de cuencas"],
        "cultivos": ["Café", "Cacao"],
        "zona_cobertura": "San Martín, Amazonas",
        "anios_experiencia": 7,
        "calificacion": 4.8,
        "numero_calificaciones": 27,
        "consultas_atendidas": 74,
        "tiempo_respuesta_promedio": "Responde en menos de 24 h",
        "modalidad": ["Videollamada"],
        "tarifa_consulta": "Primera consulta gratuita"
      },
      {
        "id": "esp_004",
        "nombre": "Carlos Huamán Rojas",
        "titulo": "Técnico Agropecuario",
        "especialidad_principal": "Aplicación de fertilizantes y control de plagas en campo",
        "especialidades_secundarias": ["Manejo poscosecha"],
        "cultivos": ["Maíz", "Papa", "Frijol"],
        "zona_cobertura": "Ayacucho, Huancavelica",
        "anios_experiencia": 4,
        "calificacion": 4.5,
        "numero_calificaciones": 8,
        "consultas_atendidas": 22,
        "tiempo_respuesta_promedio": "Responde en menos de 48 h",
        "modalidad": ["Llamada telefónica"],
        "tarifa_consulta": "S/ 10 la primera consulta"
      },
      {
        "id": "esp_005",
        "nombre": "Diana Salazar Ponce",
        "titulo": "Ingeniera Agrónoma",
        "especialidad_principal": "Semilla certificada y densidad de siembra",
        "especialidades_secundarias": ["Fitomejoramiento", "Cultivos andinos"],
        "cultivos": ["Papa", "Quinua", "Maíz amiláceo"],
        "zona_cobertura": "Junín, Huánuco",
        "anios_experiencia": 3,
        "calificacion": 4.6,
        "numero_calificaciones": 3,
        "consultas_atendidas": 4,
        "tiempo_respuesta_promedio": "Responde en menos de 24 h",
        "modalidad": ["Videollamada"],
        "tarifa_consulta": "S/ 15 la primera consulta"
      },
      {
        "id": "esp_006",
        "nombre": "Elmer Vásquez Tuesta",
        "titulo": "Ingeniero Agrícola",
        "especialidad_principal": "Riego tecnificado y manejo de agua en época de sequía",
        "especialidades_secundarias": ["Riego y drenaje", "Infraestructura hídrica"],
        "cultivos": ["Café", "Cacao", "Frutales"],
        "zona_cobertura": "San Martín, Cajamarca",
        "anios_experiencia": 11,
        "calificacion": 4.9,
        "numero_calificaciones": 54,
        "consultas_atendidas": 201,
        "tiempo_respuesta_promedio": "Responde en menos de 12 h",
        "modalidad": ["Videollamada", "Visita a campo (zona San Martín)"],
        "tarifa_consulta": "S/ 25 la primera consulta"
      }
    ]
  };

  Future<List<Especialista>> getEspecialistas() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    final List<dynamic> list = _mockData['especialistas'];
    var especialistas = list.map((json) => Especialista.fromJson(json)).toList();

    // Default sorting logic:
    // 1. Especialista Top first (calificacion >= 4.8 && consultasAtendidas >= 50)
    // 2. Sort by calificacion (descending)
    // 3. Sort by consultas_atendidas (descending)
    especialistas.sort((a, b) {
      final aIsTop = a.insignia == "Especialista Top";
      final bIsTop = b.insignia == "Especialista Top";
      
      if (aIsTop && !bIsTop) return -1;
      if (!aIsTop && bIsTop) return 1;
      
      // If both are top or both are not, sort by calificacion
      final calcDiff = b.calificacion.compareTo(a.calificacion);
      if (calcDiff != 0) return calcDiff;
      
      // If calificacion is equal, sort by consultas atendidas
      return b.consultasAtendidas.compareTo(a.consultasAtendidas);
    });

    return especialistas;
  }
}
