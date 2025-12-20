import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/core/models/page_section_model.dart';

class TopMenuTitle extends StatelessWidget {
  // 1. Acepta el nombre de la sección activa
  final String currentSection;
  // 2. Acepta la lista de secciones para generar los botones
  final List<PageSectionModel> sections;
  final Function(String fragment) onTap;

  const TopMenuTitle({super.key, required this.currentSection, required this.sections, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //final double logoOrTextOpacity = clampDouble(1.0 - collapseFactor, 0.0, 1.0);
    return Row(
      children: [
        // Empuja los botones a la derecha
        // 3. Generar los botones dinámicamente
        ...sections.map((section) {
          // Determina si esta sección es la activa
          final bool isSelected = section.fragment == currentSection;

          // Define los colores
          final Color textColor = isSelected ? Colors.white : Colors.white70;
          final FontWeight fontWeight = isSelected ? FontWeight.bold : FontWeight.normal;

          // Define el color de fondo para el indicador visual
          final Color buttonColor = isSelected ? Colors.white.withValues(alpha: 0.2) : Colors.transparent;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(4.0)),
            child: TextButton(
              onPressed: () => onTap(section.fragment),
              child: Text(
                section.title, // Usa el título legible de la sección
                style: TextStyle(color: textColor, fontWeight: fontWeight),
              ),
            ),
          );
        }),
      ],
    );
  }
}
