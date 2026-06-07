# Configuration Profiles for Snapdragon 778G+ + Eden

## Quick Settings - Copy and Paste

### 🚀 Maximum Performance (RECOMMENDED)

```properties
# Eden Environment Variables
TU_DEBUG=autotuner,gmem,noconform
TU_GPU_OVERRIDE=642
FD_MESA_DEBUG=info
GALLIUM_HUD=fps+cpu+memory
MALLOC_TRIM_THRESHOLD_=131072
TU_PERF=2
```

**Expected FPS:**
- BotW: 25-30 FPS
- Mario Kart 8: 30+ FPS
- Smash Bros: 25-30 FPS
- AC: NH: 28-30 FPS

---

### ⚖️ Balanced Mode (Good Performance + Stability)

```properties
TU_DEBUG=autotuner,gmem
TU_GPU_OVERRIDE=642
FD_MESA_DEBUG=warn
GALLIUM_HUD=fps
TU_PERF=1
```

**Expected FPS:**
- BotW: 23-28 FPS
- Mario Kart 8: 28-30 FPS
- Smash Bros: 24-28 FPS

---

### 🔧 Stability Mode (If having crashes)

```properties
TU_DEBUG=autotuner,sysmem,noconform
TU_GPU_OVERRIDE=642
FD_MESA_DEBUG=info
MALLOC_TRIM_THRESHOLD_=131072
```

**Expected FPS:**
- Slightly lower but more stable
- No crashes or graphical glitches

---

## Eden Graphics Settings

### Recommended In-Game Settings:

| Setting | Value |
|---------|-------|
| Resolution Scale | 1.0x (100%) |
| Vsync | **OFF** |
| GPU Cache | **ON** |
| Anisotropic Filtering | x16 |
| Anti-Aliasing | MSAA 4x |
| Async GPU | **ON** |

### Eden Performance Settings:

| Setting | Value |
|---------|-------|
| Multithreading | **ON** |
| CPU Affinity | Cores 4-7 |
| GPU Scaling | Maximum |
| CPU Governor | Performance |

---

## Advanced: Per-Game Optimization

### The Legend of Zelda: Breath of the Wild

```properties
# BotW specific optimizations
TU_DEBUG=autotuner,gmem,noconform
TU_PERF=2
GALLIUM_HUD=fps
FD_MESA_DEBUG=info

# Resolution: 720p (1.0x scale)
# Physics Speed: Normal
# Shader Cache: Enabled
```

**Expected:** 25-30 FPS consistent

---

### Mario Kart 8 Deluxe

```properties
# Mario Kart optimizations
TU_DEBUG=autotuner,gmem
GALLIUM_HUD=fps+cpu
TU_PERF=2
```

**Expected:** 30+ FPS (60fps mode available)

---

### Super Smash Bros Ultimate

```properties
# Smash Bros optimizations
TU_DEBUG=autotuner,gmem,noconform
TU_PERF=1
GALLIUM_HUD=fps
```

**Expected:** 25-30 FPS

---

### Animal Crossing: New Horizons

```properties
# AC:NH optimizations
TU_DEBUG=autotuner,gmem
FD_MESA_DEBUG=warn
TU_PERF=1
```

**Expected:** 28-30 FPS

---

## Troubleshooting Configurations

### If getting Low FPS (< 20 FPS)

```properties
# Try Sysmem instead of Gmem
TU_DEBUG=autotuner,sysmem,noconform
TU_PERF=1
```

### If getting Crashes/Graphical Glitches

```properties
# Use stable driver config
TU_DEBUG=gmem,noconform
TU_PERF=0
FD_DEV_FEATURES=enable_tp_ubwc_flag_hint=1
```

### If Overheating

```properties
# Reduce GPU stress
TU_DEBUG=autotuner,sysmem
TU_THROTTLE_TEMP=80
MALLOC_TRIM_THRESHOLD_=65536
```

---

## How to Apply Configuration

### Method 1: Eden Settings Menu

1. Open Eden → Settings
2. Go to Environment Variables
3. Copy configuration from above
4. Restart Eden

### Method 2: File-Based

Create file: `/sdcard/Android/data/com.github.skyline_emu.skyline/files/env.properties`

Paste configuration and restart Eden.

### Method 3: Termux

```bash
# If you have Termux installed
adb shell "echo 'TU_DEBUG=autotuner,gmem,noconform' > /sdcard/Android/data/com.github.skyline_emu.skyline/files/env_config.txt"
```

---

## Performance Monitoring

### Enable HUD in Games

Add to environment variables:
```
GALLIUM_HUD=fps+cpu+memory
```

**HUD Shows:**
- FPS (Frames Per Second)
- CPU Usage
- Memory Usage

### Monitor in Real-time

```bash
# Terminal command
adb shell "top -p $(pidof com.github.skyline_emu.skyline)"
```

---

## Autotuner: How It Works

| Phase | Duration | What It Does |
|-------|----------|-------------|
| **Learning** | 30-60 min | Benchmarks shaders in both Gmem/Sysmem |
| **Optimization** | Continuous | Gradually switches to faster mode |
| **Tuning** | Always | Fine-tunes for your device |

**Cache File:** `.autotuner_cache.bin`
- DO NOT DELETE during first hour
- Safe to keep after optimization complete
- Deleting resets optimization (takes another hour)

---

## FAQ

**Q: Which mode should I use?**
A: Use Maximum Performance first. If unstable, try Balanced Mode.

**Q: Why is FPS fluctuating?**
A: Autotuner is learning. Wait 1 hour, then FPS stabilizes.

**Q: Can I get 60 FPS?**
A: Some games can (Mario Kart), most Switch games target 30 FPS.

**Q: My device is getting hot**
A: Use Stability Mode and add `TU_THROTTLE_TEMP=85`

**Q: Where do I paste these?**
A: Eden → Settings → Environment Variables (copy entire block)

---

## Support

- Issues? Check: [GitHub Issues](https://github.com/HUEVOMAN77/AdrenoToolsDrivers/issues)
- Questions? Discord: [EmuGear](https://discord.gg/6hrfu9KmcK)

---

**Last Updated:** June 2026
**For:** Snapdragon 778G+ (Adreno 642L) + Eden Emulator
