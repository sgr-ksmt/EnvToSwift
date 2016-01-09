#!/bin/sh
cwd=`dirname $0`
output_dir='keys'
output_file_name='ServiceConfigs.swift'
output_path=$output_dir/$output_file_name

cd $cwd
if [ ! -e .env ]; then
  echo "\".env\" not found."
fi

if [ ! -e template.swift ]; then
  echo "\"template.swift\" needed."
fi

TEMPLATE=`cat template.swift`

while read line
do
  if ! [[ "$line" =~ ^#.*$ ]]; then
    set -- `echo $line | tr -s '=' ' '`
    TEMPLATE=`echo "$TEMPLATE" | sed -E "s/$1/$2/g"`
  fi
done < .env
mkdir -p $output_dir && \
echo "$TEMPLATE" > $output_path