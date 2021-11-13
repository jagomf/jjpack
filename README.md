# JJPack

> *Zip and destroy*

Scans recursively for all files inside a given folder with a specific extension, zips them, and deletes originals.

## Usage

Copy the executable file to the location you want to be processed, e.g., if you want `~/projects` (or `C:\Users\projects`) to be processed copy the file so that it is placed in `~/projects/jjscript.exe` (or `C:\Users\projects\jjscript.exe`).

Run from console in Windows:
```bash
jjscript.exe
```
Run from console in Linux/macOS:
```bash
./jjscript.exe
```
Results will be logged to the console.

### Arguments

By default, files with `dwg` extension are processed, and original files get deleted after processing.

This behavior can be changed by passing extra arguments to the command line:
```bash
jjscript.exe [extension] [nodelete]
```
Both arguments are optional.

#### Examples

##### Files with `jkl` extension, delete after zip
```bash
jjscript.exe jkl
```
##### Files with default `dwg` extension, keep after zip
```bash
jjscript.exe nodelete
```
##### Files with `nrv` extension, keep after zip
```bash
jjscript.exe nrv nodelete
```

## Build project

1. This project is build on [Dart](https://dart.dev); make sure you have the [Dart SDK](https://dart.dev/get-dart) installed. If you don't, go get it.

2. After cloning or copying the project, use a console and access the `jjpack` project folder and run
```bash
dart pub get
```

3. Build executable with
```bash
dart compile exe bin/jjpack.dart -o build/jjpack.exe
```

**NOTE**: You can only build for a platform from that same platform, i.e.:
* if you build on Windows, you can only run generated executable on Windows 
* if you build on Linux, you can only run generated executable on Linux 
* if you build on macOs, you can only run generated executable on macOs 
