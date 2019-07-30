import os

print("hello world!")

folder_dir = os.path.dirname(os.path.realpath(__file__))
print(folder_dir)
filelist = os.listdir(folder_dir)
print(filelist)
print(filelist[0])
lines = list(open(filelist[0]))
print(lines)

input("press enter to exit")