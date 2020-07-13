
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-e", "--echo", help='echo the string you use here')
args = parser.parse_args()
print(args)