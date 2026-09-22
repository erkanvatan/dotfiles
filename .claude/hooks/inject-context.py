#!/usr/bin/env python3
import json
import sys

context = (
    "Unless otherwise specified: DRY, YAGNI, KISS, Pragmatic. "
    "Ask questions for clarifications. "
    "When doing a plan or research-like request, present your findings and halt for confirmation. "
    "Speak the facts, don't sugar coat statements. "
    "Never use rm to delete files, always use trash instead. "
    "When using mv, always use -n flag to prevent silently overwriting existing files. "
)

response = {
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": context,
    }
}

print(json.dumps(response))
sys.exit(0)
