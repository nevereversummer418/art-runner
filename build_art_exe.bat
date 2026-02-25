name: Build ART Runner (Windows EXE)

on:
  workflow_dispatch:
  push:
    paths:
      - 'art_runner.py'
      - 'requirements.txt'
      - 'pyproject.toml'
      - 'build_art_exe.bat'
      - '.github/workflows/**'

jobs:
  build:
    runs-on: windows-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Upgrade pip
        run: python -m pip install --upgrade pip

      - name: Install dependencies
        run: |
          python -m pip install -r requirements.txt
          python -m pip install pyinstaller

      - name: Build single-file EXE
        run: |
          pyinstaller --noconsole --onefile --name "ART Runner" art_runner.py

      - name: Upload artifact (EXE)
        uses: actions/upload-artifact@v4
        with:
          name: ART-Runner-win-x64
          path: |
            dist/**
          if-no-files-found: error
