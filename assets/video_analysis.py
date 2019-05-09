import csv
import cv2
from fer.fer import FER
from fer.classes import Video
import json
import sys
import argparser

# parser = argparse.ArgumentParser(description='Analyze video frames for emotion expressions. Returns analyzed video (.mp4) and emotion labels (.csv)')
#
# parser.add_argument('-vf', '--videofile', metavar='vf',
#                     type = argparse.FileType('r'), nargs = 1,
#                     help='Full path to video to analyze.')
#
# parser.add_argument('-vf', '--videofile', metavar='vf',
#                     type = argparse.FileType('r'), nargs = 1,
#                     help='Full path to video to analyze.')
# 
# parser.add_argument('-vf', '--videofile', metavar='vf',
#                     type = argparse.FileType('r'), nargs = 1,
#                     help='Full path to video to analyze.')

if __name__ == "__main__":
    try:
        videofile = sys.argv[1]
    except:
        videofile = "/opt/emorec/test.mp4"

    try:
        outdir = sys.argv[2]
    except:
        outdir="output"

    try:
        savename = sys.argv[3]
    except:
        savename = "results.csv"

    detector = FER()
    video = Video(video_file=videofile, outdir=outdir)

    raw_data = video.analyze(detector, display=False, output="pandas", annotate_frames=False, save_frames=False)

    raw_data.to_csv(outdir+"/"+savename)
