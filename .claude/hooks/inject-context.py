#!/usr/bin/env python3
import json
import sys

context = (
    "Unless otherwise specified: DRY, YAGNI, KISS, Pragmatic. Ask questions for "
    "clarifications. When doing a plan or research-like request, present your "
    "findings and halt for confirmation. Speak the facts, don't sugar coat "
    "statements. Your opinion matters."
)

response = {
    "hookSpecificOutput": {
        "hookEventName": "UserPromptSubmit",
        "additionalContext": context,
    }
}

print(json.dumps(response))
sys.exit(0)
