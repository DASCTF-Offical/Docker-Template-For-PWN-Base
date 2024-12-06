#!/bin/bash
cd /home/ctf/challenge

if [ ! -f "entrypoint.sh" ]; then
  echo "entrypoint.sh not exist"
  exit 1
fi

ld_file=$(ls ld*)
if [ -z "$ld_file" ]; then
  echo "ld not exist"
  exit 1
fi


lib_files=$(ls lib*)
if [ -z "$lib_files" ]; then
  echo "lib not exist"
  exit 1
fi


line=$(cat entrypoint.sh)
# 使用正则表达式提取第一个以 './' 开头的路径
exec_path=$(echo "$line" | grep -o '\./[^ ]*' | head -n 1)

file_output=$(file $exec_path)
if echo "$file_output" | grep -q "dynamically linked"; then

  patchelf --set-interpreter ./"$ld_file" $exec_path

  for lib in $lib_files; do
    patchelf --add-needed ./"$lib" $exec_path
  done

  echo "patchelf done"
else
  echo "pwn is not dynamically linked"
fi

