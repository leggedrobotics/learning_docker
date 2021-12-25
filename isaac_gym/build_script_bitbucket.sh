mkdir /home/isaac
cd /home/isaac
git clone --depth 1 git@bitbucket.org:leggedrobotics/isaacgym_lib.git && pip3 install -e isaacgym_lib/python
git clone --depth 1 git@bitbucket.org:leggedrobotics/rsl_rl.git && pip3 install -e rsl_rl
git clone --depth 1 --branch $1 git@bitbucket.org:leggedrobotics/legged_gym.git && pip3 install -e legged_gym