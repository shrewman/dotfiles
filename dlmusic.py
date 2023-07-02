import os
import glob
import shutil
import sys
import subprocess

music_root = os.path.abspath(sys.argv[1])

try:
    os.mkdir("temp")
except FileExistsError:
    shutil.rmtree("temp")
    os.mkdir("temp")

os.chdir("temp")

subprocess.run(["spotdl", "download"] + sys.argv[2:])

files = os.listdir()

i = 0
while i < len(files):
    file = files[i]
    splat = file.split('_')
    album_path = f"{music_root}/{splat[1]}/{splat[2]}"
    os.makedirs(album_path, exist_ok=True)

    files = os.listdir()

    songs = glob.glob(f"*_{splat[2]}_*")
    for song in songs:
        splat = song.split('_')
        song_path = f"{album_path}/{splat[0]}_{splat[1]} - {splat[3]}"
        shutil.move(song, song_path)

    subprocess.run(['ffmpeg','-i',song_path,'-an','-c:v','copy',f'{album_path}/cover.png'])
    
os.chdir('..')
os.rmdir("temp")


