from khaiii import KhaiiiApi
import sys
import os
import locale

from plain_format import PlainFormatter
from json_format import JsonFormatter

def parse_args():
    """
    Parses command-line arguments.

    Returns:
        tuple: (format, sentence)
               format: one of "plain" or "json".
               sentence: the remaining arguments joined as a string.
    """
    args = sys.argv[1:]
    output_format = "plain"

    for i, arg in enumerate(args):
        if arg == "-f":
            if i + 1 < len(args):
                output_format = args[i + 1]
                args = args[:i] + args[i + 2:]
                break
    if(len(args) == 0):
        args = ['한글 형태소 분석기 Khaiii']
    sentence = ' '.join(args)
    return output_format, sentence
    
def main():
    api = KhaiiiApi()

    args = sys.argv[1:]
    output_format, sentence = parse_args()
    formatter = JsonFormatter() if output_format == "json" else PlainFormatter()
    print(formatter.format(api.analyze(sentence)))


if __name__ == "__main__":
    main()