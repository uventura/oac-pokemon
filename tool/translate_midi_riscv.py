'''
===========================================================================
    Adapted code from: https://github.com/Zen-o/Tradutor_MIDI-RISC-V
===========================================================================
'''

import mido
import os
import sys
import platform as p
FOLDER_PATH = os.path.dirname(os.path.realpath(__file__))

input_path = FOLDER_PATH + sys.argv[1]

if not os.path.isfile(input_path):
    raise Exception("ERROR: The input path is doesn't exist.")
if not input_path.endswith(".mid"):
    raise Exception("ERROR: The given file isn't .mid")

mid = mido.MidiFile(input_path)
in_filename = sys.argv[1].split("/")[-1]
out_filename = in_filename.replace(".mid", ".data")

output_path = input_path.replace(in_filename, out_filename)

with open(output_path, "w") as f:
    name = out_filename.strip(".data").replace("-", "_")

    for i, track in enumerate(mid.tracks):
        nlista = []
        plista = []
        for msg in track:
            if (not msg.is_meta and (msg.type == 'note_on' or msg.type == 'note_off')):
                nlista.append(msg.note)
                plista.append(int((mido.tick2second(msg.time, mid.ticks_per_beat,tempo)*1100)))
            if msg.type == 'set_tempo':
                tempo = msg.tempo
        
        count = 0
        currenttrack = ''
        for j in range(len(nlista)):
            if (plista[j] == 0):
                continue
            currenttrack += ", " + str(nlista[j]) + ", " + str(plista[j])
            count += 1
        currenttrack = f"{name}_track{i}: .word {count}{currenttrack} \n\n"
        f.write(currenttrack)

print("Done!")
