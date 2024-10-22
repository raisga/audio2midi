# audio2midi

Bash script that splits a song into their instruments tracks, and generates MIDI files from those tracks.
Accelerate productivity from simple audio recording (demos, quick ideas) to be ready for use with a Digital Audio Workstation.

## Usage

### Basic

```bash
sh run.sh -f ./sample/djent_rock.mp3
```

### Advanced

```bash
sh run.sh \
--verbose \
--install \
--file ./sample/djent_rock.mp3 \
--select op_full
--outdir ./output
--model htdemucs_ft
```

## TODO

Implement following features:
- Audio effects (fx):
    - https://github.com/spotify/pedalboard
- Pipeline/operations:
    - https://github.com/spotify/luigi
- Improve `basic-pitch` implementation tweaking parameters:
    - https://github.com/spotify/basic-pitch
