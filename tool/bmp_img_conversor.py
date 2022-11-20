from PIL import Image

file_in = input("PNG File: ")
while not file_in.endswith(".png"):
    print("[ERROR] Is Missing .png extension")
    file_in = input("PNG File: ")

img = Image.open(file_in)
img = img.convert("RGB")
file_out = file_in.strip(".png")+".bmp"
img.save(file_out)

file_out = open(file_out, 'rb')
print(str(file_out.read()).split('\\'))