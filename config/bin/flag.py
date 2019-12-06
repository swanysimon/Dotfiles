#!/usr/bin/env python3

from collections import namedtuple
from enum import Enum
from pyluxafor import LuxaforFlag
from textwrap import wrap
import argparse
import sys

RGB = namedtuple("RGB", "red green blue")
PARSE_MODE = Enum("ParseMode", "PRESET RGB HEX")

class PresetColor(Enum):
    GREEN = RGB(0, 128, 10)
    OFF = RGB(0, 0, 0)
    RED = RGB(128, 0, 10)

    def __str__(self):
        return self.name.lower()

    def __repr__(self):
        return str(self)

    @staticmethod
    def argparse(maybePreset):
        try:
            return PresetColor[maybePreset.upper()]
        except KeyError:
            return maybePreset

def main():
    args = argParser().parse_args()
    if args.mode == PARSE_MODE.PRESET:
        colors = args.preset[0].value
    elif args.mode == PARSE_MODE.RGB:
        colors = RGB(args.r, args.g, args.b)
    elif args.mode == PARSE_MODE.HEX:
        colors = hex_to_rgb(args.hex)
    else:
        raise Exception("Unknown mode: {}".format(args.mode))

    flag = LuxaforFlag()

    if {colors.red, colors.green, colors.blue} in [{0}, {255}]:
        flag.off()
        return

    flag.do_static_colour(
            leds=[LuxaforFlag.LED_ALL]
            , r=colors.red
            , g=colors.green
            , b=colors.blue
            )

def argParser():
    parser = argparse.ArgumentParser(
            prog=sys.argv[0]
            , description="Manages a Luxafor flag's colors."
            )
    subparser = parser.add_subparsers(help="Set the color of the flag.")

    preset_parser = subparser.add_parser(
            "preset"
            , help="Sets the color to a commonly used color value."
            )
    preset_parser.set_defaults(mode=PARSE_MODE.PRESET)
    preset_parser.add_argument(
            "preset"
            , metavar="<preset value>"
            , help="Sets the flag color to a commonly used color."
            , choices=list(PresetColor)
            , type=PresetColor.argparse
            , nargs=1
            )

    rgb_parser = subparser.add_parser(
            "rgb"
            , help="Sets the color with RGB values."
            )
    rgb_parser.set_defaults(mode=PARSE_MODE.RGB)
    rgb_parser.add_argument(
            "-r"
            , metavar="<value>"
            , help="Red value, from 0 to 255. Default is 0."
            , choices=range(0, 256)
            , type=int
            , default=0)
    rgb_parser.add_argument(
            "-g"
            , metavar="<value>"
            , help="Green value, from 0 to 255. Default is 0."
            , choices=range(0, 256)
            , type=int
            , default=0)
    rgb_parser.add_argument(
            "-b"
            , metavar="<value>"
            , help="Blue value, from 0 to 255. Default is 0."
            , choices=range(0, 256)
            , type=int
            , default=0)

    hex_parser = subparser.add_parser(
            "hex"
            , help="Sets the color with a hex string."
            )
    hex_parser.set_defaults(mode=PARSE_MODE.HEX)
    hex_parser.add_argument(
            "hex"
            , metavar="<hex color string>"
            , help="Hex color string, from #000000 to #ffffff."
                    + " Default is #000000"
            , type=str
            , default="#000000")

    return parser

def hex_to_rgb(hex): # https://stackoverflow.com/a/7548779
    def hex_to_color_value(string):
        return int(string, 16) if len(string) > 1 else int(string, 16) * 17

    hex_string = hex.strip().lstrip("#")
    len_hex_string = len(hex_string)
    if len_hex_string == 1:
        value = hex_to_color_value(hex_string)
        return RGB(value, value, value)

    inc = len_hex_string // 3
    if inc > 2 or len_hex_string % 3 != 0:
        raise Exception("Invalid hex color string from '{}'".format(hex))

    return RGB._make(hex_to_color_value(s) for s in wrap(hex_string, inc))

if __name__ == "__main__":
    main()
