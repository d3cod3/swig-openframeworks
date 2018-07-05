#!/bin/bash

### IOS

# LUA
/usr/local/bin/swig -c++ -lua -fcompact -fvirtual -I../../../libs/openFrameworks -DOF_SWIG_RENAME -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofx -DTARGET_OPENGLES -DTARGET_IOS -outdir . ofxAddonsCore.i

mv ofxAddonsCore_wrap.cxx ofxAddonsCoreLuaBindings.cpp

mv ofxAddonsCoreLuaBindings.cpp ../src/bindings/ios

# PYTHON
/usr/local/bin/swig -c++ -python -fcompact -fvirtual -modern -I../../../libs/openFrameworks -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofxaddons -DTARGET_OPENGLES -DTARGET_IOS -outdir . ofxAddonsCore.i

mv ofxAddonsCore_wrap.cxx ofxAddonsCorePythonBindings.cpp

mv ofxAddonsCorePythonBindings.cpp ../../ofxPython/src/bindings/ios

rm -f *.py

### LINUXARM

# LUA
/usr/local/bin/swig -c++ -lua -fcompact -fvirtual -I../../../libs/openFrameworks -DOF_SWIG_RENAME -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofx -DTARGET_OPENGLES -outdir . ofxAddonsCore.i

mv ofxAddonsCore_wrap.cxx ofxAddonsCoreLuaBindings.cpp

mv ofxAddonsCoreLuaBindings.cpp ../src/bindings/linuxarm

# PYTHON
/usr/local/bin/swig -c++ -python -fcompact -fvirtual -modern -I../../../libs/openFrameworks -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofxaddons -DTARGET_OPENGLES -outdir . ofxAddonsCore.i

mv ofxAddonsCore_wrap.cxx ofxAddonsCorePythonBindings.cpp

mv ofxAddonsCorePythonBindings.cpp ../../ofxPython/src/bindings/linuxarm

rm -f *.py

### DESKTOP

# LUA
/usr/local/bin/swig -c++ -lua -fcompact -fvirtual -I../../../libs/openFrameworks -DOF_SWIG_RENAME -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofx -outdir . ofxAddonsCore.i

mv ofxAddonsCore_wrap.cxx ofxAddonsCoreLuaBindings.cpp

mv ofxAddonsCoreLuaBindings.cpp ../src/bindings/desktop

# SYMBOLS (for future Mosaic autocomplete plugin for Atom )
/usr/local/bin/swig -c++ -lua -fcompact -fvirtual -debug-lsymbols -I../../../libs/openFrameworks -DOF_SWIG_RENAME -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofx ofxAddonsCore.i > ofx_lua_symbols.txt

rm -f *.cxx

# PYTHON
/usr/local/bin/swig -c++ -python -fcompact -fvirtual -modern -I../../../libs/openFrameworks -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofxaddons -outdir . ofxAddonsCore.i

mv ofxAddonsCore_wrap.cxx ofxAddonsCorePythonBindings.cpp

mv ofxAddonsCorePythonBindings.cpp ../../ofxPython/src/bindings/desktop

mv ofxaddons.py ../../ofxPython/lib

# SYMBOLS (for future Mosaic autocomplete plugin for Atom )
/usr/local/bin/swig -c++ -python -fcompact -fvirtual -modern -debug-lsymbols -I../../../libs/openFrameworks -DOF_SWIG_ATTRIBUTES -DMODULE_NAME=ofxaddons ofxAddonsCore.i > ofxaddons_python_symbols.txt

rm -f *.cxx

rm -f *.py
