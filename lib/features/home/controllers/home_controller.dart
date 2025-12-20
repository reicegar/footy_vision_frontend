// home_controller.dart

import 'package:flutter/material.dart';
import 'package:footy_vision_frontend/core/models/page_section_model.dart';
import 'package:footy_vision_frontend/router/app_router.dart';

class HomeController with ChangeNotifier {
  final scrollController = ScrollController();

  // section height populating in homePage view
  double sectionHeight = 0.0;
  double expandedHeight = 0.0;
  double collapsedHeight = 60;
  String _currentFragment = '';
  String get currentFragment => _currentFragment;

  late final List<PageSectionModel> sections = [
    //PageSectionModel(title: 'Portada', fragment: '', color: Colors.white),
    PageSectionModel(title: 'Inicio', fragment: 'inicio', color: Colors.blue),
    PageSectionModel(title: 'Acerca de', fragment: 'acerca-de', color: Colors.green),
    PageSectionModel(title: 'Contacto', fragment: 'contacto', color: Colors.red),
  ];

  void scrollToSection(String sectionPath, BuildContext context) {
    if (sectionPath.isEmpty) {
      _currentFragment = sectionPath;
      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      return;
    }

    final index = sections.indexWhere((s) => s.fragment == sectionPath);

    if (index != -1 && sectionHeight > 0) {
      double offset = 0.0;

      // if (index == 0) {
      //   // La sección de inicio (Index 0) siempre comienza en el offset 0.
      //   offset = 0.0;
      // } else {
      // Cálculo para secciones posteriores (Index 1, 2, 3, etc.):

      final double appBarContraction = expandedHeight - collapsedHeight;

      // 2. Altura total de las secciones precedentes (ej. Index 1 necesita la altura de 1 sección)
      // Multiplicamos el índice por la altura de la sección.
      final double precedingContentHeight = index * sectionHeight;

      // El offset total es la contracción del AppBar MÁS la altura del contenido previo.
      offset = appBarContraction + precedingContentHeight;
      //}

      // // Aseguramos que el offset esté dentro de los límites de desplazamiento.
      // // Esto es buena práctica para evitar errores si el cálculo excediera el máximo.
      // if (scrollController.hasClients) {
      //   offset = offset.clamp(0.0, scrollController.position.maxScrollExtent);
      // }

      // Actualizar el fragmento (para que el listener no cause un rebote)
      _currentFragment = sectionPath;
      final newPath = sectionPath.isEmpty ? '/' : '/$sectionPath';

      if (scrollController.hasClients) {
        appRouter.go(newPath);
      }

      // Realizar el desplazamiento animado
      scrollController.animateTo(offset, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void setupScrollListener(BuildContext context) {
    if (scrollController.hasListeners) return;

    scrollController.addListener(() {
      final currentOffset = scrollController.offset;

      // Calcular qué sección está visible basándose en el desplazamiento
      int baseIndex = (currentOffset / sectionHeight).floor();
      final double relativeOffset = currentOffset % sectionHeight;
      const double detectionThreshold = 1.0;
      int targetSectionIndex;

      if (relativeOffset / sectionHeight > detectionThreshold) {
        // Si hemos superado el 80% del camino, consideramos que ya estamos en la siguiente sección.
        targetSectionIndex = baseIndex + 1;
      } else {
        // De lo contrario, nos quedamos en la sección base (la anterior/actual).
        targetSectionIndex = baseIndex;
      }

      // Asegurarse de que el índice no exceda los límites
      if (targetSectionIndex < 0) targetSectionIndex = 0;
      if (targetSectionIndex >= sections.length) targetSectionIndex = sections.length - 1;

      final visibleSectionPath = sections[targetSectionIndex].fragment;

      // Actualizar la URL si la sección visible ha cambiado
      if (visibleSectionPath != _currentFragment) {
        _currentFragment = visibleSectionPath;

        // --- LA LLAMADA CLAVE PARA GO_ROUTER ---
        // Esto cambia la URL sin recargar la página: /?section=servicios
        final path = visibleSectionPath.isEmpty ? '/' : '/$visibleSectionPath';
        appRouter.replace(path);
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
