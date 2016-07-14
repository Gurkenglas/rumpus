# Building Rumpus on Windows

Apologies in advance that this is a bit complicated; all of my effort was put into getting Rumpus out the door and I'll be improving the actual build experience soon : ).

I build Rumpus in an MSYS 2 environment. Here's a description of my setup:
https://gist.github.com/lukexi/e634067f1d7e3a629988
In particular you'll need FreeType and GLEW which `pacman` can install: 
```
pacman -S mingw64/mingw-w64-x86_64-freetype mingw64/mingw-w64-x86_64-glew
```

Rumpus also depends on a small collection of sibling packages. You can get these by running
```
scripts/clone-dependencies.sh
```

Once you've got these, run
```
(cd ../openvr-hs && ./copyLibWin.sh)
(cd ../pd-hs && ./copyLibWin.sh)
```
to place the necessary OpenVR and libpd DLLs in `/usr/local/bin`.

Now you should be able to run
```
stack build && stack exec rumpus
```

If not, please get in touch at luke@rumpus.land : )