from PIL import Image
from os import system, listdir
import subprocess
out = ""
for element in listdir("."):
    if element.endswith(".png"):
        img = Image.open(element)
        img = img.convert("RGB")
        out = element.strip(".png") + ".bmp"
        img.save(out)