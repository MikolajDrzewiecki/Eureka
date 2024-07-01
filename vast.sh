#!/bin/bash


apt update && apt upgrade -y

# install and initialize conda
ln -s /usr/bin/python3 /usr/bin/python
curl -sL \
  "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" > \
  "Miniconda3.sh"
bash Miniconda3.sh -b
rm Miniconda3.sh
cd /root/miniconda3/bin
./conda init
cd /home/NlpMimuwBigAssignment
. /root/.bashrc


# run instalation of eureka
conda create -n eureka python=3.8 -y
conda activate eureka

tar -xvf IsaacGym_Preview_4_Package.tar.gz
cd isaacgym/python; pip install -e .

cd ../../Eureka; pip install -e .
cd isaacgymenvs; pip install -e .
cd ../rl_games; pip install -e .
cd ../

conda activate eureka

# correct packages for eureka use
pip install torch==2.0.0
pip install torchvision==0.15.1
pip install setuptools==69.5.1
pip install openai==0.28
pip install gpustat

# additional packages
apt install -y neovim htop build-essential
pip install jupyter
pip install transformers
pip install huggingface-hub
pip install hydra

# fix error due to np.float being deprecated
cd /home/NlpMimuwBigAssignment
grep -rlw "np.float" | xargs sed -i 's/np.float/np.float64/g'

echo 'export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/root/miniconda3/envs/eureka/lib"' >> /root/.bashrc
echo 'conda activate eureka' >> /root/.bashrc
echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> /root/.bashrc

. /root/.bashrc
