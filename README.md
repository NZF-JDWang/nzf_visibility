# NZF Visibility

A dynamic camouflage and audio detection system for Arma 3 that provides realistic visibility mechanics based on environmental factors, movement, and equipment.

## Features

- **Dynamic Camouflage**: Real-time camouflage effectiveness based on:
  - Environmental conditions (lighting, weather, terrain)
  - Player stance and movement speed
  - Nearby vegetation and cover
  - Ghillie suit equipment

- **Audio Detection**: Enhanced audio mechanics that consider:
  - Movement speed and stance
  - Weapon firing events
  - Environmental audio masking

- **Debug Overlay**: Optional visual debug information showing:
  - Current camouflage coefficient
  - Audio coefficient
  - AI detection levels
  - Environmental factors

## Requirements

- Arma 3 (2.10+)
- [CBA A3](https://steamcommunity.com/sharedfiles/filedetails/?id=450814997) (Community Based Addons)

## Installation

### Manual Installation
1. Download the latest release
2. Extract to your Arma 3 `@nzf_visibility` folder
3. Enable the mod in your launcher

### Steam Workshop
*Coming soon*

## Configuration

The mod includes several CBA settings accessible through the in-game settings menu:

- **Enable debug overlay**: Shows real-time camouflage and audio information
- **Ghillie Light classname**: Configure light ghillie suit classname
- **Ghillie Heavy classname**: Configure heavy ghillie suit classname

## How It Works

### Camouflage System
The mod continuously monitors:
- **Environmental factors**: Time of day, weather conditions, fog, overcast
- **Terrain**: Surface type, nearby vegetation density, cover occlusion
- **Player state**: Stance, movement speed, equipment worn
- **Ghillie suits**: Special camouflage bonuses for ghillie equipment

### Audio System
Audio detection is influenced by:
- **Movement**: Faster movement increases audio signature
- **Stance**: Prone/crouched positions reduce audio
- **Weapon firing**: Temporary audio boost after shooting
- **Environmental masking**: Rain and wind can mask audio

## Development

### Building from Source
1. Clone this repository
2. Use your preferred Arma 3 mod development tools (PBO Manager, etc.)
3. Build the mod files

### File Structure
```
nzf_visibility/
├── config.cpp              # Mod configuration and function definitions
├── XEH_preInit.sqf         # Pre-initialization script
├── XEH_postInit.sqf        # Post-initialization script
└── functions/              # Core functionality
    ├── fn_applyTraits.sqf      # Apply camouflage/audio traits
    ├── fn_collectEnvironment.sqf # Gather environmental data
    ├── fn_computeAudio.sqf      # Calculate audio coefficient
    ├── fn_computeCamo.sqf       # Calculate camouflage coefficient
    ├── fn_debugRender.sqf       # Debug overlay rendering
    ├── fn_initLocal.sqf         # Local player initialization
    ├── fn_onDraw3D.sqf         # 3D drawing event handler
    ├── fn_onFired.sqf          # Weapon firing event handler
    ├── fn_onRespawn.sqf        # Player respawn handler
    ├── fn_registerDebugClient.sqf # Debug client registration
    ├── fn_startLocalLoop.sqf   # Main processing loop
    ├── fn_unregisterDebugClient.sqf # Debug client cleanup
    └── fn_updateDebugEh.sqf    # Debug event handler updates
```

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
- Debug overlay
- CBA settings integration
