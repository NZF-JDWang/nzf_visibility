# NZF Visibility

A dynamic camouflage and audio detection system for Arma 3 that provides realistic visibility mechanics based on environmental factors, movement, equipment, and AI behavior.

## Features

### **Dynamic Camouflage System**
Real-time camouflage effectiveness based on:
- **Environmental conditions**: Lighting, weather, fog, overcast
- **Terrain**: Surface type, nearby vegetation density, cover occlusion
- **Player state**: Stance, movement speed, equipment worn
- **Ghillie suits**: Special camouflage bonuses for ghillie equipment

### **Audio Detection System**
Enhanced audio mechanics that consider:
- **Movement**: Faster movement increases audio signature
- **Stance**: Prone/crouched positions reduce audio
- **Weapon firing**: Temporary audio boost after shooting
- **Environmental masking**: Rain and wind can mask audio

### **AI Behavior Integration**
Intelligent AI behavior adjustments based on combat state:
- **CARELESS**: 30% spot time, 70% spot distance (very slow to react)
- **SAFE**: 50% spot time, 85% spot distance (slower to react)
- **AWARE**: 100% normal behavior
- **COMBAT**: 100% normal behavior (no artificial enhancement)

### **Zeus Integration**
Mission maker tools for monitoring player performance:
- **Real-time FPS monitoring** for all players
- **Visibility coefficients display** (camouflage and audio)
- **Toggle display** with User12 key
- **Color-coded indicators** for performance issues

## Requirements

- **Arma 3** (2.10+)
- **[CBA A3](https://steamcommunity.com/sharedfiles/filedetails/?id=450814997)** (Community Based Addons)

## Installation

### Manual Installation
1. Download the latest release
2. Extract to your Arma 3 `@nzf_visibility` folder
3. Enable the mod in your launcher

### Steam Workshop
*Coming soon*

## Configuration

The mod includes several CBA settings accessible through the in-game settings menu:

### **Main Settings**
- **Enable Visibility System**: Toggle the entire visibility system
- **Enable AI Behavior Adjustments**: Toggle AI behavior modifications

### **Ghillie Suit Configuration**
- **Ghillie Light classname**: Configure light ghillie suit classname
- **Ghillie Heavy classname**: Configure heavy ghillie suit classname

## How It Works

### **Camouflage System**
The mod continuously monitors and calculates camouflage effectiveness:

**Environmental Factors:**
- **Lighting**: Night time provides up to 25% camouflage bonus
- **Weather**: Fog reduces visibility by up to 30%, overcast by 6%
- **Cover**: Nearby vegetation provides up to 35% reduction
- **Dense vegetation**: Extra bonus up to 30% reduction

**Player State:**
- **Stance**: Prone (-25%), Crouched (-15%), Standing (no bonus)
- **Movement**: Still (best), Walking (+12%), Running (+30%), Sprinting (+45%)
- **Equipment**: Light ghillie (25% reduction), Heavy ghillie (45% reduction)

### **Audio System**
Audio detection is influenced by multiple factors:

**Movement Impact:**
- **Still**: -20% (very quiet)
- **Walking**: +12% (slightly louder)
- **Running**: +40% (much louder)
- **Sprinting**: +65% (very loud)

**Environmental Factors:**
- **Surface**: Concrete (+10%), Metal (+15%), Grass (-5%)
- **Weather**: Rain and overcast provide audio masking
- **Vegetation**: Moving through dense vegetation creates rustling noise
- **Stance**: Prone position reduces audio by 35%

### **Weapon Firing System**
When players fire weapons, temporary spikes are added:

**Visual Spike:**
- **Unsuppressed**: +1.0 base, stronger at night (+0.6 bonus)
- **Suppressed**: Only +0.1 (heavily reduced)

**Audio Spike:**
- **Unsuppressed**: +1.2
- **Suppressed**: Only +0.1 (heavily reduced)

**Rate Limiting**: Firing spikes are limited to once every 5 seconds.

### **AI Behavior System**
Server-side monitoring of AI group behavior:

**Combat Behavior Adjustments:**
- **CARELESS**: AI is very slow to spot (30% speed) with reduced range (70%)
- **SAFE**: AI is slower to react (50% speed) with slightly reduced range (85%)
- **AWARE/COMBAT**: Normal AI behavior (100% speed and range)

**Features:**
- **3-second update cycle** for performance
- **Group-level processing** for efficiency
- **Randomization** to prevent predictable patterns
- **Server-side only** to avoid conflicts

## Zeus Integration

### **Player Stats Monitor**
Mission makers can monitor all players with:
- **FPS display** with color coding (red for low FPS)
- **Real-time visibility coefficients** (camouflage and audio)
- **Distance culling** (only shows within 1200m)
- **Toggle display** with User12 key

### **Usage**
1. **Open Zeus interface** or use admin privileges
2. **Press User12 key** to toggle player stats display
3. **Monitor performance** and visibility coefficients
4. **Adjust mission parameters** based on player capabilities

## Technical Details

### **Performance Optimized**
- **CBA per-frame handlers** for efficient processing
- **1-second update interval** for player visibility
- **3-second update interval** for AI behavior
- **Smoothing algorithms** prevent jarring changes
- **Rate limiting** prevents excessive updates

### **State Management**
- **Player state tracking**: `[camouflage, audio, camoShotBoost, audioShotBoost]`
- **Shot boost decay**: 80% per update for realistic spikes
- **Smoothing factor**: 25% to prevent sudden changes
- **Coefficient clamping**: 0.2-2.5 for camouflage, 0.05-2.5 for audio

### **Multiplayer Support**
- **Client-side processing** for each player
- **Server-side AI monitoring** for group leaders
- **Zeus integration** for mission makers
- **Networked variables** for multiplayer synchronization

## File Structure

```
nzf_visibility/
├── config.cpp                      # Mod configuration and function definitions
├── XEH_preInit.sqf                 # Pre-initialization script
├── XEH_postInit.sqf                # Post-initialization script
├── functions/                      # Core functionality
│   ├── fn_applyTraits.sqf          # Apply camouflage/audio traits
│   ├── fn_collectEnvironment.sqf   # Gather environmental data
│   ├── fn_computeAudio.sqf         # Calculate audio coefficient
│   ├── fn_computeCamo.sqf          # Calculate camouflage coefficient
│   ├── fn_initLocal.sqf            # Local player initialization
│   ├── fn_initZeusMonitor.sqf     # Zeus integration and monitoring
│   ├── fn_manageAIGroupLeaders.sqf # AI behavior monitoring
│   ├── fn_onFired.sqf              # Weapon firing event handler
│   ├── fn_onRespawn.sqf            # Player respawn handler
│   ├── fn_startAIGroupManagement.sqf # AI system initialization
│   ├── fn_startLocalLoop.sqf       # Main processing loop
│   └── fn_adjustGroupSpotting.sqf  # AI behavior adjustments
├── LICENSE                         # MIT License
└── README.md                       # This file
```

## Use Cases

This mod is designed for:
- **Realistic military simulations**
- **Tactical gameplay** where stealth matters
- **Mission making** with enhanced visibility mechanics
- **Training scenarios** with realistic detection systems
- **Zeus operations** with player monitoring capabilities

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Credits

- **Author**: NZF
- **Dependencies**: CBA A3 Community

## Support

For issues, feature requests, or questions:
- Create an issue on GitHub
- Contact the author through Steam

## Changelog

### Version 1.0.0
- Initial release
- Dynamic camouflage system
- Audio detection mechanics
- AI behavior integration
- Zeus monitoring tools
- CBA settings integration