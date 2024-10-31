# audio2midi

A bash script to split an audio file into its individual instrument tracks and generate MIDI files from each track. This tool is designed to accelerate productivity by transforming simple audio recordings (demos, quick ideas) into files ready for use in a Digital Audio Workstation (DAW).

## Table of Contents
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Limitations](#limitations)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Track Separation**: Splits audio into instrument tracks (e.g., drums, bass, vocals, guitar, etc.).
- **MIDI Generation**: Creates MIDI files from each separated track, compatible with most DAWs.
- **Quick Workflow**: Ideal for taking a quick recording and preparing it for further editing or arranging.
- **Automated Workflow**: Script-based, enabling easy integration into larger workflows or automation pipelines.

## Prerequisites

Ensure the following tools are installed:

- **FFmpeg**: Used for audio processing and format conversions.
- **`demucs`**: Splits audio files into separate instrument tracks.
- **`basic-pitch`**: Converts audio tracks to MIDI.

## Installation

Clone this repository and make the script executable:
```bash
chmod +x sh.sh
```

Installation commands for dependencies:

```bash
sh run.sh -i
```

or

```bash
sh run.sh --install
```

## Usage

Run the script by specifying the audio file you want to process:

### Basic

```bash
sh run.sh -f ./sample/djent_rock.mp3
```

### Advanced

```bash
sh run.sh \
--verbose \
--file ./sample/djent_rock.mp3 \
--select op_full \
--outdir ./output \
--model htdemucs_ft
```

The script will:
1. Split the audio file into separate instrument tracks.
2. Convert each track to a MIDI file.
3. Output the MIDI files to a designated `./output/` directory.

## Configuration

Default settings can be modified in the script:
- **Audio Input Format**: Adjust to process different file formats.
- **Track Output Directory**: Customize the directory for separated tracks and MIDI files.
- **Track Separation Models**: Choose specific models for better accuracy.
- TODO: Include more configurations (flags)

## Limitations

- **Audio Quality**: The accuracy of instrument separation and MIDI conversion may vary based on the audio quality and complexity.
- **Processing Time**: Depends on the length of the audio file and system performance.
- **File Formats**: Ensure compatibility with `wav`, `mp3`, or other FFmpeg-supported formats.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork this repository.
2. Create a new branch: `git checkout -b feature/your-feature`.
3. Commit your changes: `git commit -am 'Add your feature'`.
4. Push to the branch: `git push origin feature/your-feature`.
5. Submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **Demucs**: Open-source AI for music separation.
- **Basic Pitch**: MIDI generation tool by Spotify.

## TODO

Implement following features:
- Audio effects (fx):
    - https://github.com/spotify/pedalboard
- Pipeline/operations:
    - https://github.com/spotify/luigi
- Improve `basic-pitch` implementation tweaking parameters:
    - https://github.com/spotify/basic-pitch
