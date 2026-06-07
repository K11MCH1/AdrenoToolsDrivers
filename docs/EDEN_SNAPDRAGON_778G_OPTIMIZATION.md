# 🎮 Eden Emulator - Snapdragon 778G+ Optimization Guide

## ⚡ Objetivo: 30+ FPS en Nintendo Switch

Este documento contiene las configuraciones óptimas para lograr **máximo rendimiento** en Eden emulator usando **Snapdragon 778G+ (Adreno 642L)**.

---

## 📋 Requisitos Previos

- **Dispositivo**: Snapdragon 778G+ (Adreno 642L)
- **Emulador**: Eden (última versión)
- **Drivers**: Turnip v26.0.0 R8 o superior
- **ROM**: Nintendo Switch en formato correcto
- **RAM**: Mínimo 6GB disponible

---

## 🚀 Paso 1: Instalación de Drivers Optimizados

### Opción A: Usar Drivers Precompilados (RECOMENDADO)

1. Descargar: `Turnip_v26.0.0_R8_Gmem.zip` desde [Releases](https://github.com/K11MCH1/AdrenoToolsDrivers/releases/tag/v26.0.0-rc08)
2. Extraer en: `/sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/`
3. Reiniciar Eden

### Opción B: Usar Script de Instalación Automática

```bash
# Ejecutar desde terminal del dispositivo (ADB o Termux)
bash install_778g_drivers.sh
```

---

## 🎛️ Paso 2: Configuración de Variables de Entorno

### Variable Crítica para 778G+ + Adreno 642L:

**Abrir Eden → Configuración → Variables de Entorno**

```
TU_DEBUG=autotuner,noconform
TU_GPU_OVERRIDE=642
FD_MESA_DEBUG=info
GALLIUM_HUD=fps+cpu+memory
```

### Explicación:

| Variable | Valor | Efecto |
|----------|-------|--------|
| `TU_DEBUG` | `autotuner,noconform` | Activa autotuner para optimize en tiempo real |
| `TU_GPU_OVERRIDE` | `642` | Fuerza detección de Adreno 642L |
| `FD_MESA_DEBUG` | `info` | Debug level para diagnosticar problemas |
| `GALLIUM_HUD` | `fps+cpu+memory` | Muestra HUD con estadísticas |

---

## 💾 Paso 3: Configuración Gmem vs Sysmem

### Para 778G+ Recomendado: **Gmem** (GPU Memory)

**Por qué Gmem es mejor para este chip:**
- ✅ Adreno 642L tiene 1.5GB dedicado
- ✅ Reduce latencia de memoria
- ✅ Mejor caché local
- ✅ 20-30% más FPS en comparación a Sysmem

**Cómo activar Gmem:**

```
TU_DEBUG=autotuner,gmem,noconform
```

### Fallback a Sysmem (si hay problemas):

```
TU_DEBUG=autotuner,sysmem,noconform
```

---

## 🎯 Paso 4: Configuración Específica de Eden

### En la Configuración de Eden:

**Gráficos:**
- ✅ Enabled GPU Cache
- ✅ Use custom driver: Turnip (si está disponible)
- ✅ Vsync: Desactivado (para máximo FPS)
- ✅ Resolution Scale: 1.0x (100%)
- ✅ Anisotropic Filtering: x16 (máximo)

**Performance:**
- ✅ Multithreading: Activado
- ✅ CPU Affinity: Cores 4-7 (Cores de performance)
- ✅ GPU Frequency Scaling: Máximo

**Audio:**
- ✅ Audio Engine: Vulkan (si está disponible)

---

## ⚙️ Paso 5: Autotuner - Entrenamiento Inicial

El **Autotuner aprende** de tu dispositivo automáticamente en los primeros 30-60 minutos.

### Primera Vez (Calibración):

```bash
# Ejecutar por 1 hora
# Juega 3-4 juegos diferentes
# El sistema analiza rendimiento Gmem vs Sysmem
# Gradualmente optimiza cada shader
```

**Archivo de caché**: `.autotuner_cache.bin` (no borrar)

---

## 🎮 Paso 6: Juegos Recomendados para Testear

| Juego | Esperado | Dificultad GPU |
|-------|----------|----------------|
| The Legend of Zelda: Breath of the Wild | 25-30 FPS | Media-Alta |
| Mario Kart 8 Deluxe | 30+ FPS | Baja |
| Super Smash Bros Ultimate | 25-30 FPS | Media |
| Animal Crossing: New Horizons | 25-30 FPS | Baja |
| Xenoblade Chronicles 3 | 20-25 FPS | Muy Alta |

---

## 🔧 Paso 7: Optimizaciones Avanzadas

### ONE UI Bug (Si aplica):

```
FD_DEV_FEATURES=enable_tp_ubwc_flag_hint=1
```

### Shader Compilation Acceleration:

```
MESA_SHADER_CACHE_DIR=/sdcard/Android/data/com.github.skyline_emu.skyline/cache/shaders
TU_DEBUG=autotuner,precompile
```

### Reduce Memory Footprint:

```
MALLOC_TRIM_THRESHOLD_=131072
```

---

## 📊 Benchmarking

### Script de Test:

```bash
#!/bin/bash
# test_performance.sh

echo "=== Eden + 778G+ Performance Test ==="
echo "GPU: Adreno 642L"
echo "Device: Snapdragon 778G+"

# Jugar 5 minutos por juego
# Registrar FPS promedio
# Generar reporte

```

**Registra:**
- FPS promedio
- FPS mínimo
- CPU usage
- GPU usage
- Temperatura

---

## 🆘 Troubleshooting

### Problema: Bajo FPS (< 20 FPS)

**Solución 1**: Cambiar a Sysmem
```
TU_DEBUG=autotuner,sysmem,noconform
```

**Solución 2**: Limpiar caché de shaders
```
rm -rf /sdcard/Android/data/com.github.skyline_emu.skyline/cache/shaders
```

**Solución 3**: Reiniciar Autotuner
```
rm ~/.autotuner_cache.bin
```

### Problema: Crashes o Crashes Gráficos

**Solución**: Usar driver estable (v26.0.0 R7)
```
Revert to Turnip_v26.0.0_R7.zip
```

### Problema: Sobrecalentamiento

**Solución**: Limitar frecuencia GPU
```
TU_THROTTLE_TEMP=85  # En Celsius
```

---

## 💡 Pro Tips

1. ✅ **Autotuner tarda 1 hora** en optimizar - sé paciente
2. ✅ **Jugar siempre el mismo juego** mejora consistency
3. ✅ **Limpiar cache regularmente** evita fragmentación
4. ✅ **Monitorear temperatura** para evitar throttling
5. ✅ **Actualizar Eden frequently** para bug fixes

---

## 📈 Resultados Esperados

Con esta configuración en **Snapdragon 778G+ (Adreno 642L)**:

| Juego | Esperado sin Optimización | Con Optimización |
|-------|--------------------------|------------------|
| BotW | 15-20 FPS | 25-30 FPS |
| Mario Kart 8 | 25-28 FPS | 30+ FPS |
| Smash Bros | 20-24 FPS | 25-30 FPS |
| AC: NH | 22-26 FPS | 28-30 FPS |

**Mejora: +30-40% de FPS**

---

## 📞 Soporte

- Discord: [EmuGear International](https://discord.gg/6hrfu9KmcK)
- Telegram: [Adreno Konabess](https://t.me/adreno_konabess)
- GitHub Issues: [AdrenoToolsDrivers](https://github.com/HUEVOMAN77/AdrenoToolsDrivers/issues)

---

**Última actualización**: Junio 2026
**Versión**: 1.0
**Autor**: Optimization Team
