A simple Vala application, that receives an image via bluetooth and then
displays it.

## Building

``` shell
meson setup build
cd build
ninja
```

## Running

Make sure that no other OBEX agents (e.g. blueman) are running, then execute:

``` shell
./src/btftp_example
```
