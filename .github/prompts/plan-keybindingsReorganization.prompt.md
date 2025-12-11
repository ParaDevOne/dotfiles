# Plan: Reorganización Integral de Keybindings en Dotfiles

**TL;DR:** Resolver 5 conflictos detectados, centralizar documentación de 120+ keybindings dispersos en 3 herramientas (ZSH, Kitty, Zellij), estandarizar convenciones de navegación, modularizar configuración, y eliminar redundancias críticas para mejorar mantenibilidad y experiencia del usuario.

## Steps

### 1. Resolver conflicto crítico `Esc Esc` en `.config/zsh/keybinds.zsh`
- Cambiar hotkey de `sudo-command-line` de `Esc Esc` a `Alt+S` (o `Ctrl+Shift+;` como alternativa)
- Justificación: `Esc` interfiere con renaming en Zellij (`esc` para cancelar edición)
- Verificar: Realizar test en terminal con Zellij activo

### 2. Crear documentación centralizada `.config/KEYBINDINGS.md`
- Incluir tabla de referencia rápida (3 secciones: ZSH, Kitty, Zellij)
- Documentar todos los 120+ keybindings con contexto y conflictos conocidos
- Matriz de convenciones por prefijo (Ctrl, Alt, Ctrl+Shift, Ctrl+B)
- Sección de conflictos con mitigaciones
- Mantener actualizado con futuras cambios

### 3. Limpiar redundancias en `.config/Code/User/zellij/config.kdl`
- Identificar duplicaciones en `shared_among` modes (ej: `Alt+Left/Right/Up/Down` aparecen en scroll + shared)
- Consolidar a una sola definición en `shared_among` para evitar conflictos de bindeo
- Comentar cada sección claramente (locked, pane, tab, resize, move, scroll, session, shared)
- Verificar que no haya conflictos de modo después de limpieza

### 4. Estandarizar navegación entre herramientas
- Decisión: Mantener ZSH con arrows (ya funcional), agregar Alt+hjkl como alternativa vim-like
- En `.config/zsh/keybinds.zsh`: Agregar `Alt+H`, `Alt+J`, `Alt+K`, `Alt+L` como aliases para navegación (opcional, solo si se considera necesario)
- En Kitty: Considerar agregar hjkl keybinds (análisis de costo/beneficio)
- Documentar la decisión final en KEYBINDINGS.md

### 5. Modularizar keybindings en ZSH (opcional, pero recomendado)
- Crear `.config/zsh/keybinds/` con subcarpetas: `history.zsh`, `navigation.zsh`, `editing.zsh`, `system.zsh`
- Separar keybindings actuales por categoría funcional
- Sourcear módulos desde `.config/zsh/keybinds.zsh` manteniendo compatibilidad
- Beneficio: Facilita futuro mantenimiento y búsqueda de conflictos

### 6. Optimizar Kitty keybindings (verificación y documentación)
- Revisar `.config/kitty/keybindings.conf` para confirmar que no hay conflictos con ZSH
- Agregar comentarios sobre prefijo `Ctrl+Shift` universal
- Evaluar si se necesitan keybinds vim-like (hjkl) - probablemente no (Kitty no es un editor)
- Documentar en KEYBINDINGS.md

### 7. Crear pruebas de validación
- Script de verificación: Buscar keybindings duplicadas/conflictivas en los 3 archivos
- Test manual: Abrir Zellij dentro de Kitty, probar todos los modos de navegación
- Test específico: Renombrar panel en Zellij (verifica que `esc` funciona después del cambio de `Esc Esc`)
- Documento de checklist para futuros cambios

### 8. Actualizar documentación general
- Agregar referencia a `.config/KEYBINDINGS.md` en `README.md`
- Crear sección "Keyboard Shortcuts" con links
- Considerar agregar diagrama visual ASCII mostrando flujo (ZSH → Kitty → Zellij)

## Further Considerations

### 1. ¿Cambiar keybinding de `sudo-command-line` o deshabilitarlo completamente?
- **Opción A:** Cambiar a `Alt+S` (menos usado, fácil de recordar)
- **Opción B:** Cambiar a `Ctrl+Shift+;` (tecla especial, requiere layout específico)
- **Opción C:** Deshabilitar si no se usa frecuentemente
- **Recomendación:** Opción A (`Alt+S`) es más compatible y memorizable

### 2. ¿Modularizar ZSH keybindings ahora o esperar a que crezca?
- **Opción A:** Modularizar ya (mejor mantenibilidad, claridad)
- **Opción B:** Mantener monolítico (menos archivos, simpler para principiantes)
- **Recomendación:** Opción A - el archivo ya tiene 17+ bindings, estructura modular facilitará futuros cambios

### 3. ¿Agregar vim-like keybinds a Kitty (hjkl para navegación)?
- **Opción A:** No agregar (Kitty no es editor, `Ctrl+Shift` es suficiente)
- **Opción B:** Agregar Alt+hjkl solo para tab navigation (paridad con Zellij)
- **Recomendación:** Opción A por ahora - Kitty usa arrows, que son universales. Si usuarios requieren, agregar después

### 4. ¿Crear archivo separado para Zellij keybindings (keybindings.kdl)?
- **Opción A:** Mantener en config.kdl (archivo único, menos complejidad)
- **Opción B:** Separar en `keybindings.kdl` (modularidad, como ZSH)
- **Recomendación:** Opción A por ahora - Zellij maneja config diferente, esperar a que estructura crezca

### 5. ¿Nivel de detalle en KEYBINDINGS.md - principiantes o avanzados?
- **Opción A:** Solo lo esencial (rápida referencia, 1-2 páginas)
- **Opción B:** Exhaustivo (todos los modos, conflictos, alternativas, ~5-10 páginas)
- **Opción C:** Híbrido (tabla rápida + sección detallada expandible)
- **Recomendación:** Opción C (Híbrido) - QR codes/links a secciones detalladas mantiene legibilidad

## Orden Recomendado de Ejecución (por dependencias)

```
FASE 1 (Crítica - Sin dependencias):
  └─ Paso 1: Resolver conflicto Esc Esc

FASE 2 (Documentación - Depende de Fase 1):
  ├─ Paso 7: Crear checklist/script de validación
  └─ Paso 2: Crear KEYBINDINGS.md (documenta estado post-Fase 1)

FASE 3 (Limpieza - Parallelizable):
  ├─ Paso 3: Limpiar Zellij redundancias
  ├─ Paso 4: Estandarizar navegación (decisión + aplicación)
  └─ Paso 6: Revisar Kitty keybindings

FASE 4 (Modularización - Opcional, después de Fase 3):
  └─ Paso 5: Modularizar ZSH keybindings

FASE 5 (Documentación General - Final):
  └─ Paso 8: Actualizar README.md con referencias
```

## Estimación de Esfuerzo
- Fase 1: ~15 min (cambio simple)
- Fase 2: ~45 min (doc writing + testing)
- Fase 3: ~30 min (review + limpieza)
- Fase 4: ~45 min (refactoring, testing)
- Fase 5: ~10 min (links y refs)
- **Total: ~2.5 horas de trabajo concentrado**

## Background Context

### Investigación Previa - Resumen Ejecutivo

**Estado Actual:**
- ✅ **Funcional:** Todos los keybindings funcionan sin grandes conflictos
- ✅ **Coherente:** Cada herramienta tiene su propia convención clara
- ⚠️ **Documentación:** Dispersa en 3 archivos diferentes
- ⚠️ **Inconsistencias:** Existen patrones contradictorios entre herramientas

**Conflictos Detectados:**
1. 🔴 CRÍTICO: `Esc Esc` en ZSH conflictúa con modos de edición en Zellij
2. 🟠 ALTO: Sin documentación centralizada de 120+ keybindings
3. 🟠 ALTO: Inconsistencia en navegación (arrows en ZSH vs hjkl en Zellij)
4. 🟡 MEDIO: Duplicación de keybindings en Zellij (shared_among modes)
5. 🟡 MEDIO: Falta Alt+hjkl en ZSH para paridad con Zellij

**Convenciones Identificadas:**
- **ZSH:** Usa Ctrl/Alt (readline estándar + innovaciones como Esc Esc)
- **Kitty:** Usa Ctrl+Shift universal
- **Zellij:** Usa Ctrl+B como prefijo (similar a tmux), luego modos específicos

### Keybindings por Herramienta (Conteo)
- **ZSH:** 17 combinaciones definidas
- **Kitty:** 25 combinaciones definidas
- **Zellij:** 80+ combinaciones (incluyendo todos los modos)
- **Total:** 120+ keybindings documentados

### Archivos Impactados
- `.config/zsh/keybinds.zsh` (ZSH keybindings)
- `.config/kitty/keybindings.conf` (Kitty keybindings)
- `.config/Code/User/zellij/config.kdl` (Zellij config completo)
- `README.md` (documentación general)
- `KEYBINDINGS.md` (a crear)
- `.config/zsh/keybinds/` (estructura opcional, a crear si se modulariza)
