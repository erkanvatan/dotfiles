#!/usr/bin/env python
import sys
import subprocess

"""
This script replaces successive blank spaces (spaces, tabs etc.) in the text in clipboard with a single space.
It has an option to keep or remove the newlines in the text.
"""


def formatWhitespace(text: str, keepNewlines: bool = True):
    formattedText = ''
    i = 0
    while i < len(text):
        startIndex = i
        # skip multiple whitespaces
        while i < len(text) and str.isspace(text[i]) and (not keepNewlines or text[i] != '\n'):
            i += 1
        if i < len(text):
            if startIndex != i:
                formattedText += ' '
            else:
                formattedText += text[i]
                i += 1
    return formattedText


if __name__ == "__main__":
    if len(sys.argv) != 1 and len(sys.argv) != 2:
        print('usage: python3 format_whitespace.py [keep newlines?: 1/0]')
        sys.exit(1)
    # Get the text from the system clipboard using xclip linux tool
    text = subprocess.run(["xclip", "-o"], universal_newlines=True, stdout=subprocess.PIPE).stdout
    # Log the clipboard input when running from keyboard shortcut
    #  with open("/home/arensonz/Desktop/log.txt", "w") as file:
    #      file.write(f"TEXT: {text}")
    if len(sys.argv) == 2:
        # error check keepNewlines flag value, and send the flag to the function
        if str.isdecimal(sys.argv[1]):
            formattedText = formatWhitespace(text, bool(int(sys.argv[1])))
        else:
            print(f'error: [keep newlines] value is wrong\n\t{sys.argv[1]}')
            sys.exit(1)
    else:
        formattedText = formatWhitespace(text)
    # copy the result to clipboard using xclip linux tool
    subprocess.run(["xclip", "-i", "-selection", "clipboard"], universal_newlines=True, input=formattedText)
