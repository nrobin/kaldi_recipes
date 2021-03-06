#!/bin/bash

# 														EMCS Labs
# 														Hyungwon Yang
# 														hyung8758@gmail.com

# This scritp generates 'path.sh' after collecting kaldi root information of the user.
# It also links steps, and utils paths.
# Do not remove and re-generate path.sh repeatedly.
kaldi=$1

if [ $# -ne 1 ]; then
   echo "One arguments should be assigned." 
   echo "1. Kaldi path."&& exit 1
fi

# KALDI_ROOT
export KALDI_ROOT=$kaldi
# if [ -f $KALDI_ROOT/tools/env.sh ]; then
# 	. $KALDI_ROOT/tools/env.sh
# else 
# 	echo "$KALDI_ROOT/tools/env.sh is not present." && exit 1
# fi

# Connect steps and utils folders to the directory.
# export PATH=$PATH:$PWD:$PWD/utils/:$PWD/steps/:$KALDI_ROOT/tools/openfst/bin:$KALDI_ROOT/tools/irstlm/bin:$PWD/local
# if [ -f $KALDI_ROOT/tools/config/common_path.sh ]; then
# 	. $KALDI_ROOT/tools/config/common_path.sh
# else
# 	echo "$KALDI_ROOT/tools/config/common_path.sh is not present" && exit 1
# fi
# export LC_ALL=C

# Make a path.sh.
if [ -f $PWD/main/path.sh ]; then 
	echo "path.sh exists in the current directory."

else
	cat > $PWD/path.sh << EOL
	# EMCS Labs.
	# This script is generated by ./local/make_path.sh. Therefore it might be different from other path.sh script.

	export KALDI_ROOT=$kaldi
	[ -f $KALDI_ROOT/tools/env.sh ] && . $KALDI_ROOT/tools/env.sh
	export PATH=$PWD/utils:$PWD/steps:$KALDI_ROOT/tools/openfst/bin:$PATH
	[ ! -f $KALDI_ROOT/tools/config/common_path.sh ] && echo >&2 "The standard file $KALDI_ROOT/tools/config/common_path.sh is not present -> Exit!" && exit 1
	. $KALDI_ROOT/tools/config/common_path.sh
	export LC_ALL=C
EOL
	echo "path.sh is newly wirtten."
fi