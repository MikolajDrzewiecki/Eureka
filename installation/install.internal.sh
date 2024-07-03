set -ex

pushd "${WORKDIR}"
    # freeze all dependencies
    pip install -e ./Eureka ./Eureka/isaacgymenvs ./Eureka/rl_games ./isaacgym/python setuptools==69.5.1 pillow==9.5.0 openai==0.28 gpustat ipython matplotlib matplotlib-inline

    pushd "./Eureka"
        pip install -e . --no-dependencies
    popd
    
    pushd "./Eureka/isaacgymenvs"
        pip install -e . --no-dependencies
    popd
    
    pushd "./Eureka/rl_games"
        pip install -e . --no-dependencies
    popd
    
    pushd "./isaacgym/python"
        pip install -e . --no-dependencies
    popd
    
popd