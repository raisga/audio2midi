# audio2midi

...

## Usage

...

```bash
sh script.sh \
--install \
--file ./sample/djent_rock.mp3 \
--outdir ./separated \
--model htdemucs_ft \
# --tracks bass,drums,other,vocals \
# --selected op1,op2
```

## TODO

Implement following features:
- Audio effects:
    - https://github.com/spotify/pedalboard
- Pipeline/operations
    - https://github.com/spotify/luigi
- Improve `basic-pitch` implementation:
    - https://github.com/spotify/basic-pitch
