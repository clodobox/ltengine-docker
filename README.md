# LTEngine Docker Setup

A simple Docker setup for running [LTEngine](https://github.com/LibreTranslate/LTEngine) on CPU.

## Usage

1. Clone this repository:
```
git clone https://github.com/clodobox/ltengine-docker.git
cd ltengine-docker
```

2. Edit the `docker-compose.yml` file to select your preferred model by uncommenting the appropriate line:
```yaml
environment:
# Uncomment one model:
# - MODEL=gemma3-1b
- MODEL=gemma3-4b
# - MODEL=gemma3-12b
# - MODEL=gemma4-27b
```

3. Run the container:
```
docker-compose up -d
```

4. Access the API at `http://localhost:5050`

## Models

- **gemma3-1b**: Light model (1GB RAM) - Good for testing, poor translations
- **gemma3-4b**: Default model (4GB RAM)
- **gemma3-12b**: Medium model (8GB RAM)
- **gemma4-27b**: Large model (16GB RAM) - Best translation quality, slowest

## License

This project is licensed under GNU GPL v3 - see the LICENSE file for details.

## Acknowledgements

This is a Docker setup for [LTEngine](https://github.com/LibreTranslate/LTEngine), which is developed by the LibreTranslate project.
I am in no way affiliated with them.
