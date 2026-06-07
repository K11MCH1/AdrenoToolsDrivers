# Guía de Optimización para Eden - Snapdragon 778G
## Maximizar FPS (40+) con resolución Full HD en Nintendo Switch

---

## 📊 Especificaciones del dispositivo
- **Procesador**: Snapdragon 778G
- **GPU**: Adreno 642L
- **RAM**: 6-8GB recomendado
- **Almacenamiento**: UFS 3.1 mínimo
- **Emulador**: Eden (Nintendo Switch)

---

## 🎮 Configuraciones Recomendadas en Eden

### 1. **Resolución y Escala**
- **Resolución interna**: 1920x1080 (Full HD)
- **Escala de resolución**: 75% - 85% (dependiendo del juego)
- **Resolución de salida**: Native (1920x1080)
- **Anti-aliasing**: FXAA (activo)

**¿Por qué?** El Snapdragon 778G maneja bien Full HD con escala moderada, evitando sobrecarga de GPU mientras mantiene calidad visual.

---

### 2. **Configuración de Gráficos**

#### Calidad Visual
```
Opción                    Configuración
─────────────────────────────────────────
Calidad de texturas      Medium/High
Sombras                  Medium
Reflexiones              Desactivadas
Efectos de partículas    Medium
Iluminación dinámica     Desactivada
```

#### Rendimiento
```
Opción                    Configuración
─────────────────────────────────────────
Sincronización V-Sync    Desactivada
Limitador de FPS         60 FPS (target)
Modo de potencia         Alto rendimiento
Control termmal          Activo
```

---

### 3. **Configuración del Driver Adreno**

#### Variables de entorno (requiere acceso root o Magisk)
```bash
# Agregar a /system/build.prop o vía Magisk module

# Optimizaciones de memoria
ro.hwui.drop_shadow_cache_size=6
ro.hwui.r_buffer_cache_size=8
ro.hwui.text_large_cache_width=2048
ro.hwui.text_large_cache_height=1024

# GPU Scaling
ro.vendor.gpu.sku=Adreno 642L
ro.vendor.qti.gpu.adreno_sp=true

# Caché de shaders
ro.debug.force_rtl=false
persist.graphics.vulkan.level=1
```

---

### 4. **Optimizaciones a Nivel de Sistema**

#### 4.1 Gestor de Energía
```
Ajuste                     Configuración
─────────────────────────────────────────
Modo de juego             Activado
Limitador de térmico      80°C máximo
Frecuencia GPU máxima     Máxima
Frecuencia CPU            Performance
```

#### 4.2 Memoria RAM
```
Liberar RAM antes de jugar
- Cierra aplicaciones de fondo
- Desactiva sincronización en la nube
- Desactiva animaciones del sistema
```

---

## 🎯 Optimizaciones Específicas por Juego

### Super Smash Bros Ultimate
```
Resolución interna: 1600x900 (escalada a 1920x1080)
Escala: 80%
Sombras: Medium
Efectos de partículas: Medium
FPS esperado: 45-55 fps
```

### The Legend of Zelda: Breath of the Wild
```
Resolución interna: 1280x720 (escalada a 1920x1080)
Escala: 75%
Sombras: Low
Reflexiones: Desactivadas
FPS esperado: 40-48 fps
```

### Mario Kart 8 Deluxe
```
Resolución interna: 1920x1080
Escala: 85%
Sombras: High
Efectos de partículas: High
FPS esperado: 50-60 fps
```

### Animal Crossing: New Horizons
```
Resolución interna: 1920x1080
Escala: 90%
Sombras: Medium
Reflexiones: Habilitadas (bajo impacto)
FPS esperado: 55-60 fps
```

---

## 🔧 Optimizaciones del Driver Adreno (v840)

### 1. **Compilación de Shaders**
```
persist.graphics.vulkan.shader_cache=true
persist.graphics.vulkan.shader_cache_size=512MB
```

### 2. **Modo de Renderizado**
```
# Para máximo rendimiento
ro.vendor.graphics.preferFastRender=true
ro.vendor.qti.gpu.adreno_msaa=true
```

### 3. **Caché de Texturas**
```
# Precarga de texturas en Full HD
persist.graphics.texture_compression=true
persist.graphics.high_quality_textures=true
persist.graphics.texture_resolution=1920x1080
```

---

## ⚡ Optimizaciones Avanzadas

### 1. **Activar Turbo GPU**
Si el dispositivo lo permite:
```
adb shell "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
adb shell "echo 710400000 > /sys/devices/platform/18000000.devfreq/max_freq"
```

### 2. **Deshabilitar Aplicaciones de Sistema Innecesarias**
```
- Facebook App
- LinkedIn
- Google Play Games
- Chrome (si no es necesario)
- Aplicaciones de salud
```

### 3. **Desactivar Servicios de Fondo**
```
Settings > Apps > Permisos
- Ubicación
- Cámara
- Micrófono
- Sensores de movimiento
```

---

## 📈 Monitoreo de Rendimiento

### Herramientas recomendadas:
1. **OCAT (Overlay Counter on Android)** - Monitor FPS en tiempo real
2. **GPU Profiler** - Análisis de uso de GPU
3. **Thermal Monitor** - Control de temperatura

### Valores objetivo:
```
Métrica              Objetivo        Máximo
──────────────────────────────────────────
FPS                  40-55 fps       60 fps
GPU Utilization      70-85%          95%
CPU Utilization      60-75%          90%
Temperatura GPU      65-75°C         85°C
Temperatura CPU      50-65°C         80°C
Consumo RAM          5-6 GB          7 GB
```

---

## 🎓 Pasos Implementación Rápida

### Paso 1: Descarga el Driver
- Descarga el driver Adreno v840 desde este repositorio

### Paso 2: Instalación
- Instala via Magisk module o TWRP recovery
- Reinicia el dispositivo

### Paso 3: Configuración Eden
```
1. Abre Eden
2. Ve a Settings > Graphics
3. Aplica valores de "Configuración de Gráficos" (Sección 2)
4. Reinicia el emulador
```

### Paso 4: Optimizaciones del Sistema
```
1. Descarga un App de tweaks (LTE Tool, Device Maintenance)
2. Libera memoria RAM
3. Activa el modo de juego
4. Desactiva sincronización en la nube
```

### Paso 5: Prueba
- Carga un juego conocido
- Monitorea FPS con OCAT
- Ajusta escala según necesidad

---

## ⚠️ Solución de Problemas

| Problema | Causa | Solución |
|----------|-------|----------|
| **FPS bajo (<30)** | GPU sobrecargada | Reduce escala a 70%, desactiva sombras |
| **Crashes frecuentes** | Driver incompatible | Intenta versión anterior (v839) |
| **Sobrecalentamiento** | Límite térmico alcanzado | Reduce FPS a 45, activa refrigeración |
| **Texturas borrosas** | Compresión excesiva | Aumenta calidad de texturas a High |
| **Input lag** | Desincronización | Desactiva V-Sync, reduce escala |

---

## 📝 Notas Importantes

⚠️ **ADVERTENCIA**: 
- Estos ajustes pueden variar según la ROM del dispositivo
- Algunos ajustes requieren root/Magisk
- Prueba cambios uno a uno para identificar cuál funciona mejor
- Las temperaturas superiores a 85°C pueden dañar el dispositivo

✅ **RECOMENDACIONES**:
- Mantén el dispositivo en ambiente fresco
- Usa un cooler externo para sesiones largas
- Actualiza Eden regularmente
- Reporta problemas específicos en Discord del proyecto

---

## 🔗 Enlaces Útiles

- **Repositorio Drivers**: https://github.com/K11MCH1/AdrenoToolsDrivers
- **Discord Eden**: [Ver README principal]
- **Mesa 3D Docs**: https://docs.mesa3d.org/

---

**Última actualización**: Junio 2026  
**Versión Driver**: v840  
**Dispositivo Target**: Snapdragon 778G  
**Emulador**: Eden
