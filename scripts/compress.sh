#!/bin/sh

# Compress mp3 files
# ffmpeg -i your_song.mp3 -codec:a libmp3lame -qscale:a 0 -map_metadata -1 -id3v2_version 3 -y your_song_compressed.mp3
