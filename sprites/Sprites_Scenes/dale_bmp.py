from os import system, listdir
import subprocess

for element in listdir("."):
    if element.endswith(".bmp"):
        system("bmp2oac3.exe "+element)