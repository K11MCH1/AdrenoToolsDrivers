# 🔧 Troubleshooting Guide - Snapdragon 778G+ Eden Optimization

## 🆘 Problemas Comunes y Soluciones

---

## ❌ Problema: Bajo FPS (< 20 FPS)

### Síntomas:
- Games corren a menos de 20 FPS
- BotW corriendo a 10-15 FPS
- Gameplay lag notorio

### Soluciones (en orden):

**1️⃣ Cambiar a Sysmem (GPU Memory)**

```properties
TU_DEBUG=autotuner,sysmem,noconform
TU_PERF=1
```

Sysmem usa RAM en lugar de GPU memory - puede ser más lento pero a veces más estable.

**2️⃣ Limpiar Shader Cache**

```bash
rm -rf /sdcard/Android/data/com.github.skyline_emu.skyline/cache/shaders/
```

Los shaders corrupto pueden causar bajo FPS.

**3️⃣ Reiniciar Autotuner**

```bash
rm ~/.autotuner_cache.bin
```

Esto fuerza recalibración (toma 1 hora).

**4️⃣ Verificar si es problema de Eden**

- Actualiza Eden a última versión
- Prueba con otro juego diferente
- Reinicia dispositivo completo

---

## 💥 Problema: Crashes o Game Freezes

### Síntomas:
- Game crashea después de 5-10 minutos
- Pantalla se congela
- Regresa al menú de Eden

### Soluciones:

**1️⃣ Usar Stability Mode**

```properties
TU_DEBUG=gmem,noconform
TU_PERF=0
FD_MESA_DEBUG=warn
```

**2️⃣ Revertir a Driver R7 (si R8 inestable)**

```bash
# Descargar R7 desde:
# https://github.com/K11MCH1/AdrenoToolsDrivers/releases/tag/v26.0.0-rc07

# Extraer sobre los drivers actuales
unzip -o Turnip_v26.0.0_R7.zip -d /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/
```

**3️⃣ Deshabilitar Autotuner**

```properties
TU_DEBUG=gmem
TU_PERF=0
```

Esto desactiva optimización automática pero puede ser más estable.

**4️⃣ Fix ONE UI Bug (Samsung)**

Si tienes Samsung:
```properties
FD_DEV_FEATURES=enable_tp_ubwc_flag_hint=1
TU_DEBUG=gmem,noconform
```

---

## 🌡️ Problema: Device Overheating

### Síntomas:
- Device muy caliente después de 15 min de juego
- Throttling (FPS baja dramáticamente después de calentar)
- Notificación de temperatura en statusbar

### Soluciones:

**1️⃣ Activar Thermal Throttling**

```properties
TU_DEBUG=autotuner,gmem
TU_THROTTLE_TEMP=80
```

El device limitará GPU a 80°C (ajusta según necesidad).

**2️⃣ Reducir GPU Stress - Usar Sysmem**

```properties
TU_DEBUG=autotuner,sysmem
```

Sysmem es menos demandante que Gmem.

**3️⃣ Mejorar Ventilación**

- No juegues en case sellada
- Quita case si es posible
- Juega en ambiente fresco
- No tabes atrás del device

**4️⃣ Cerrar Background Apps**

```bash
adb shell "am kill-all"
```

Background processes calientan el device.

---

## 🖥️ Problema: Graphics Glitches / Artifacts

### Síntomas:
- Texturas se ven mal
- Colores incorrectos
- Flickering visual
- Distorsión de geometría

### Soluciones:

**1️⃣ Limpiar Shader Cache**

```bash
rm -rf /sdcard/Android/data/com.github.skyline_emu.skyline/cache/shaders/
```

**2️⃣ Usar Driver Estable**

Revertir a R7 o R6:
```bash
unzip -o Turnip_v26.0.0_R7.zip -d /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/
```

**3️⃣ Deshabilitar Conformance Checks**

```properties
TU_DEBUG=gmem
```

Remove `noconform` para validación más estricta.

**4️⃣ Specific GPU Fix**

```properties
TU_GPU_OVERRIDE=642
```

Asegúrate que está correctamente detectado.

---

## 🔌 Problema: Driver No Se Instala / No Se Carga

### Síntomas:
- Eden no reconoce los drivers
- Option "Custom Driver" no disponible
- Error al abrir emulator

### Soluciones:

**1️⃣ Verificar Paths Correctos**

```bash
# Path debe ser:
/sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/

# Verificar que exista:
ls -la /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/
```

**2️⃣ Restaurar Desde Backup**

```bash
cp -r /sdcard/Android/data/com.github.skyline_emu.skyline/drivers_backup_*/* \
    /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/
```

**3️⃣ Limpiar y Reinstalar**

```bash
rm -rf /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/*
bash scripts/install_778g_drivers.sh
```

**4️⃣ Verificar Permisos**

```bash
chmod 755 /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/
chmod 644 /sdcard/Android/data/com.github.skyline_emu.skyline/files/drivers/*
```

---

## ⚡ Problema: Variable de Entorno No Se Aplica

### Síntomas:
- Changes no tienen efecto
- HUD no aparece aunque esté configurado
- Configuración se revierte

### Soluciones:

**1️⃣ Reiniciar Eden Completamente**

```bash
adb shell am force-stop com.github.skyline_emu.skyline
adb shell am start -n com.github.skyline_emu.skyline/.MainActivity
```

**2️⃣ Verificar Archivo de Config**

```bash
cat /sdcard/Android/data/com.github.skyline_emu.skyline/files/env_config.txt
```

**3️⃣ Editar Directamente en Eden**

Settings → Environment Variables → Paste configuration manually

**4️⃣ Usar ADB Para Setear**

```bash
adb shell "echo 'TU_DEBUG=autotuner,gmem,noconform' > \
    /sdcard/Android/data/com.github.skyline_emu.skyline/files/env_config.txt"
```

---

## 🎮 Problema: Autotuner No Optimiza

### Síntomas:
- FPS no mejoran después de 1 hora
- Autotuner parece no estar funcionando
- Cache file no se crea

### Soluciones:

**1️⃣ Verificar Autotuner Habilitado**

```properties
TU_DEBUG=autotuner,gmem,noconform
```

`autotuner` DEBE estar en TU_DEBUG.

**2️⃣ Jugar Variedad de Juegos**

Autotuner necesita diferentes shaders. Juega:
- 1 juego 3D (BotW)
- 1 juego 2D (Mario Kart)
- 1 juego arcade (Smash Bros)

**3️⃣ Verificar Cache File**

```bash
ls -la ~/.autotuner_cache.bin
```

Debe existir y tener tamaño > 0.

**4️⃣ Resetear y Recalibrar**

```bash
rm ~/.autotuner_cache.bin
# Juega durante 1-2 horas
```

---

## 📊 Problema: No Puedo Ver FPS/HUD

### Síntomas:
- GALLIUM_HUD no muestra nada en pantalla
- No veo FPS counter

### Soluciones:

**1️⃣ Activar HUD Correctamente**

```properties
GALLIUM_HUD=fps+cpu+memory
```

**2️⃣ Reiniciar Eden**

```bash
adb shell am force-stop com.github.skyline_emu.skyline
adb shell am start -n com.github.skyline_emu.skyline/.MainActivity
```

**3️⃣ Verificar Ubicación HUD**

HUD aparece en esquina superior-izquierda normalmente.

**4️⃣ Alternativa: Usar Logcat**

```bash
adb logcat | grep "fps\|FPS\|HUD"
```

---

## 🔄 Problema: Performance Inconsistente

### Síntomas:
- FPS fluctúan mucho (30 FPS → 15 FPS)
- No es consistente juego a juego
- A veces bueno, a veces malo

### Soluciones:

**1️⃣ Esperar Autotuner (1 hora)**

FPS inconsistente es normal durante calibración inicial.

**2️⃣ Cerrar Background Apps**

```bash
adb shell "pm disable-user com.android.systemui/com.android.systemui.recents.RecentsActivity"
```

Apps corriendo en background afectan performance.

**3️⃣ Limpiar Memory**

```bash
adb shell "am send-trim-memory 80"
```

**4️⃣ Usar Perfil Estable**

```properties
TU_DEBUG=gmem,noconform
TU_PERF=0
```

---

## 📋 Checklist de Debug

Antes de reportar issue, verifica:

- [ ] Ejecuté `install_778g_drivers.sh`
- [ ] Reinicié Eden después de instalación
- [ ] Esperé 1 hora para Autotuner calibration
- [ ] Limpié shader cache
- [ ] Probé con múltiples juegos
- [ ] Verifiqué environment variables
- [ ] Device no está sobrecalentado
- [ ] Tengo suficiente RAM libre (mínimo 2GB)

---

## 📞 Si Nada Funciona

1. **Restaura drivers backup:**
   ```bash
   cp -r drivers_backup_*/* drivers/
   ```

2. **Reboot device:**
   ```bash
   adb reboot
   ```

3. **Reporta en GitHub:**
   - URL: https://github.com/HUEVOMAN77/AdrenoToolsDrivers/issues
   - Incluye: Device, Eden version, game name, error log

4. **Join Discord para soporte:**
   - https://discord.gg/6hrfu9KmcK (EmuGear)
   - https://discord.gg/YhpdhVBmXX (Strato)

---

## 🎯 Performance Targets

Si logras estos FPS, ¡está optimizado correctamente!

| Game | Target | ✅ Success |
|------|--------|-----------|
| BotW | 25-30 FPS | ✓ |
| Mario Kart 8 | 30+ FPS | ✓ |
| Smash Bros | 25-30 FPS | ✓ |
| AC: NH | 28-30 FPS | ✓ |

---

**Última actualización:** Junio 2026  
**Para:** Snapdragon 778G+ (Adreno 642L)  
**Emulator:** Eden
