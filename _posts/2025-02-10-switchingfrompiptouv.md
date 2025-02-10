---
layout: post
title: Switching from PIP to UV
date: 2025-02-10 16:44 +0100
categories: ["tooling", "uv"]
tags: ["misc"]
mermaid: true
published: true
---

For the past 10 years I have constantly depended on python tools such as conda, pip, virtualenv, pyenv, poetry. All these tools always made it difficult to master python tooling as I had to remember the CLI commands for each one of them separately. 

In mid 2023 I came across a new tool called UV via youtube suggestion. The developers built it on Rust, and back then I was very mesmerized by rust. But I did not feel comfortable switching my python workflows to UV right away. 

Fast forward two years, the newest version of UV made it a complete no-brainer to switch over. 

To start a new project I let `uv` create the required boilerplate for me by using the `init` command. 
```bash
uv init myproject --python 3.12.5 && cat pyproject.toml 
```
The above command declares also the required python version by using the `--python` argument. To inspect everything is correct, I check the content of pyproject.toml
```bash
[project]
name = "myproject"
version = "0.1.0"
description = "Add your description here"
readme = "README.md"
requires-python = ">=3.12.5"
dependencies = []
```

I never liked how poetry or pyenv separated my repo and the virtual environments to different location. This is also possible in UV, but I like all my project dependencies in the project folder. I no longer need to bother setting up a virtual environment. By adding the below command, I can create a `.venv` environment automatically.

```bash
uv add requests 
╰─❯
   Using CPython 3.12.5
   Creating virtual environment at: .venv
   Resolved 6 packages in 347ms
   Installed 5 packages in 5ms
   + certifi==2025.1.31
   + charset-normalizer==3.4.1
   + idna==3.10
   + requests==2.32.3
   + urllib3==2.3.0

```

Finally, to run a python script, I no longer need any alias or call python myself. uv run does all that for me. It chooses the virtual environment and python version in the folder and runs the script.

```bash
uv run hello.py
╰─❯ Hello from myproject!
```


Another great feature is the ability to use `ruff` tool to lint check and format my scripts in seconds!

```bash
uvx ruff check .
╰─❯ All checks passed!
```

```bash
uvx ruff format .
╰─❯ 1 file left unchanged
```

Did I fail to mention all the above commands runs extremely fast when compared to the older python tools. This gives developers more focus on their code base than fiddle around with multiple tools just to execute their python scripts.

Kudos to the entire team at [Astral](https://docs.astral.sh/). I hope that this open-source project continues being open and does not follow the `Redis` way!

There are many more commands to explore in `uv` and `uvx` from [UV Cli Commands](https://docs.astral.sh/uv/reference/cli/). 

## Resources 
Here are some of the resources which helped me learn the basic commands in UV and uvx, in no specific order.

 
   * Feature review from Tim 
   {% include embed/youtube.html id='ap2sWj5yDIY' %}

   * Soft introduction to UV by Arjan
   {% include embed/youtube.html id='qh98qOND6MI' %}

   * Soft introduction to UV by Ian
   {% include embed/youtube.html id='k4qh83m1jg0' %}

   
