#!/usr/bin/bash
test -d /home/vagrant/build/llvm/build || mkdit -p /home/vagrant/build/llvm/build
cd /home/vagrant/build/llvm/build
cmake -G "Unix Makefiles" -DLLVM_TARGETS_TO_BUILD="BPF;X86" -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PWD/install ..
make -j8
make install
export PATH=/home/vagrant/build/llvm/build/install/bin:$PATH
mkdir /home/vagrant/build/bcc/build
cd /home/vagrant/build/bcc/build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make -j8
make install
