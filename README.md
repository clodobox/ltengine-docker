# LTEngine Docker Setup

A simple Docker setup for running [LTEngine](https://github.com/LibreTranslate/LTEngine) on CPU or GPU with Vulkan (AMD / Intel graphics).

⚠️ **DISCLAIMER: EXPERIMENTAL PROJECT** ⚠️

**This is an amateur, unsupported project that does not follow standard practices for code quality, security, or stability. Use at your own risk in testing environments only. Not recommended for production use.**

## Usage

1. Clone this repository:
```
git clone https://github.com/clodobox/ltengine-docker.git
cd ltengine-docker
```

2. Edit the `docker-compose.yml` file to select your preferred model by uncommenting the appropriate line:
```yaml
# For CPU (default)
dockerfile: Dockerfile
# For Vulkan (Intel GPU & iGPU / AMD Graphics)
# dockerfile: Dockerfile-vulkan

# Uncomment for Vulkan
# devices:
#   - /dev/dri/renderD128:/dev/dri/renderD128
#   - /dev/dri/card0:/dev/dri/card0

environment:
  # MODEL SELECTION (uncomment one)
  #
  # Light model (1GB RAM) - Good for testing, poor translations
  # - MODEL=gemma3-1b
  #
  # Default model (4GB RAM)
  - MODEL=gemma3-4b
  #
  # Medium model (8GB RAM)
  # - MODEL=gemma3-12b
  #
  # Large model (16GB RAM) - Best translation quality, slowest
  # - MODEL=gemma4-27b
```

3. Run the container:
```
docker-compose up -d
```

4. Access at `http://localhost:5050`

## Models

- **gemma3-1b**: Light model (1GB RAM) - Good for testing, poor translations
- **gemma3-4b**: Default model (4GB RAM)
- **gemma3-12b**: Medium model (8GB RAM)
- **gemma4-27b**: Large model (16GB RAM) - Best translation quality, slowest

## License

This project is licensed under GNU Affero General Public License v3 - see the LICENSE file for details.

## Acknowledgements
### Cuda
I don't think adapting it for CUDA is very complicated.

It should look something like this: in Dockerfile, change the line “RUN cargo build --features vuklan--release” to “--features cuda”.
There will certainly be some dependencies to remove/add to the “apt install” lines.

Without nvidia hardware to test, I can't tell you more.

### LTEngine
This is a Docker setup for [LTEngine](https://github.com/LibreTranslate/LTEngine), which is developed by [Piero Toffanin](https://github.com/pierotofy) & [ButterflyOfFire](https://github.com/BoFFire).

I am in no way affiliated with them.
