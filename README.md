![Isaac Lab](docs/source/_static/isaaclab.jpg)

---

# Isaac Lab

[![IsaacSim](https://img.shields.io/badge/IsaacSim-4.5.0-silver.svg)](https://docs.isaacsim.omniverse.nvidia.com/latest/index.html)
[![Python](https://img.shields.io/badge/python-3.10-blue.svg)](https://docs.python.org/3/whatsnew/3.10.html)
[![Linux platform](https://img.shields.io/badge/platform-linux--64-orange.svg)](https://releases.ubuntu.com/20.04/)
[![Windows platform](https://img.shields.io/badge/platform-windows--64-orange.svg)](https://www.microsoft.com/en-us/)
[![pre-commit](https://img.shields.io/github/actions/workflow/status/isaac-sim/IsaacLab/pre-commit.yaml?logo=pre-commit&logoColor=white&label=pre-commit&color=brightgreen)](https://github.com/isaac-sim/IsaacLab/actions/workflows/pre-commit.yaml)
[![docs status](https://img.shields.io/github/actions/workflow/status/isaac-sim/IsaacLab/docs.yaml?label=docs&color=brightgreen)](https://github.com/isaac-sim/IsaacLab/actions/workflows/docs.yaml)
[![License](https://img.shields.io/badge/license-BSD--3-yellow.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![License](https://img.shields.io/badge/license-Apache--2.0-yellow.svg)](https://opensource.org/license/apache-2-0)


**Isaac Lab** is a GPU-accelerated, open-source framework designed to unify and simplify robotics research workflows, such as reinforcement learning, imitation learning, and motion planning. Built on [NVIDIA Isaac Sim](https://docs.isaacsim.omniverse.nvidia.com/latest/index.html), it combines fast and accurate physics and sensor simulation, making it an ideal choice for sim-to-real transfer in robotics.

Isaac Lab provides developers with a range of essential features for accurate sensor simulation, such as RTX-based cameras, LIDAR, or contact sensors. The framework's GPU acceleration enables users to run complex simulations and computations faster, which is key for iterative processes like reinforcement learning and data-intensive tasks. Moreover, Isaac Lab can run locally or be distributed across the cloud, offering flexibility for large-scale deployments.

## Key Features

Isaac Lab offers a comprehensive set of tools and environments designed to facilitate robot learning:
- **Robots**: A diverse collection of robots, from manipulators, quadrupeds, to humanoids, with 16 commonly available models.
- **Environments**: Ready-to-train implementations of more than 30 environments, which can be trained with popular reinforcement learning frameworks such as RSL RL, SKRL, RL Games, or Stable Baselines. We also support multi-agent reinforcement learning.
- **Physics**: Rigid bodies, articulated systems, deformable objects
- **Sensors**: RGB/depth/segmentation cameras, camera annotations, IMU, contact sensors, ray casters.


## Getting Started

**On WatCloud:**
- SSH into WatCloud and git clone this repo
- Use wato_asd_tooling repo to start ssh session in the slurm nodes (See link: https://wiki.watonomous.ca/autonomous_software_general/watcloud_dev#one-time-setup) (See link for minimum spec on slurm nodes: https://docs.isaacsim.omniverse.nvidia.com/latest/installation/requirements.html)
- In `IsaacLab/docker/.container.cfg` set `x_11_forwarding_enabled = 0`
- On a new terminal, run `ssh -L 5900:localhost:5900 asd-dev-session` to enable ssh tunneling from slurm nodes to local computer
- Run
```
cd IsaacLab \
&& export DISPLAY=:1 \
&& srun --cpus-per-task 8 --mem 64G --gres shard:24084,tmpdisk:102400 --time 4:00:00 --pty bash
&& slurm-start-dockerd.sh
&& ./docker/container.py start \
&& ./docker/container.py enter base
```

- Launch Isaac Lab by running `./isaaclab.sh -s` OR Run a script with `./isaaclab.sh -p <path_to_file>`
- Download VNC Viewer and choose localhost:5900 to open Isaac Lab (See link: https://www.realvnc.com/en/connect/download/viewer/?lai_vid=63V0dbyEai1ON&lai_sr=5-9&lai_sl=l&lai_p=1)
# Issues
If there are issues with seeing display, try running these commands in the docker container -
```
pkill -f Xvfb
pkill -f x11vnc
pkill -f startlxde
rm -f /tmp/.X1-lock
rm -rf /tmp/.X11-unix/X1
rm -f /tmp/.Xauthority
touch /tmp/.Xauthority
xauth add :1 . $(mcookie)
Xvfb :1 -screen 0 1280x1024x24 -auth /tmp/.Xauthority -ac &
export DISPLAY=:1
x11vnc -display :1 -auth /tmp/.Xauthority -nopw -forever -shared &
startlxde &
sleep 5
xclock &
```

For any driver issues, try running these commands to temporarily ignore the warnings -

Find the driver checkers with this commander - ```find / -name "user.config.json" 2>/dev/null```
And patch them individually like this -
```python3 - << 'EOF'
import json
#Replace the line with your config files
p = "/root/.local/share/ov/data/Kit/Isaac-Sim Full/4.5/user.config.json"

with open(p, "r") as f:
    d = json.load(f)

d.setdefault("rtx", {})["verifyDriverVersion"] = {"enabled": False}

with open(p, "w") as f:
    json.dump(d, f, indent=4)

print("Patched:", p)
EOF
```

Then run this command as well - ```echo 'rtx.verifyDriverVersion.enabled = false' >> /workspace/isaaclab/apps/isaaclab.python.rendering.kit```

Our [documentation page](https://isaac-sim.github.io/IsaacLab) provides everything you need to get started, including detailed tutorials and step-by-step guides. Follow these links to learn more about:

- [Installation steps](https://isaac-sim.github.io/IsaacLab/main/source/setup/installation/index.html#local-installation)
- [Reinforcement learning](https://isaac-sim.github.io/IsaacLab/main/source/overview/reinforcement-learning/rl_existing_scripts.html)
- [Tutorials](https://isaac-sim.github.io/IsaacLab/main/source/tutorials/index.html)
- [Available environments](https://isaac-sim.github.io/IsaacLab/main/source/overview/environments.html)

# Session Config - Use these recommended configurations for getting into IsaacLab
```
export REMOTE_USER=""    # Your WATcloud Username
export REMOTE_HOST="wato-login1"      # [wato-login1, wato-login2]
export SSH_KEY="~/.ssh/id_ed25519"           # Path to your local private key
export NUMBER_OF_CPUS=8        # Number of CPUs to use
export MEMORY=64G              # Amount of RAM to use
export USAGE_TIME="6:00:00"    # How long you want to run the session for
export TMP_DISK_SIZE=102400     # How much temporary storage you want [in MiB]
export VRAM=24000                  # How much GPU VRAM you want [in MiB]
# SLURM tooling configuration
export UPDATE_WATO_ASD_TOOLING=0 # Set to 0 if you don't want to update ASD tooling on remote hosts
export SAVE_DOCKER_STATE_ON_EXIT=1 # Set to 1 if you want to save docker state on exit
export CLEAN_SAVED_DOCKER_STATE=0 # Set to 1 to clean your docker state, do this is your docker is corrupted or too large

rijul_chaddha@trpro-slurm1:~/IsaacLab$
```
## Contributing to Isaac Lab

We wholeheartedly welcome contributions from the community to make this framework mature and useful for everyone.
These may happen as bug reports, feature requests, or code contributions. For details, please check our
[contribution guidelines](https://isaac-sim.github.io/IsaacLab/main/source/refs/contributing.html).

## Show & Tell: Share Your Inspiration

We encourage you to utilize our [Show & Tell](https://github.com/isaac-sim/IsaacLab/discussions/categories/show-and-tell) area in the
`Discussions` section of this repository. This space is designed for you to:

* Share the tutorials you've created
* Showcase your learning content
* Present exciting projects you've developed

By sharing your work, you'll inspire others and contribute to the collective knowledge
of our community. Your contributions can spark new ideas and collaborations, fostering
innovation in robotics and simulation.

## Troubleshooting

Please see the [troubleshooting](https://isaac-sim.github.io/IsaacLab/main/source/refs/troubleshooting.html) section for
common fixes or [submit an issue](https://github.com/isaac-sim/IsaacLab/issues).

For issues related to Isaac Sim, we recommend checking its [documentation](https://docs.omniverse.nvidia.com/app_isaacsim/app_isaacsim/overview.html)
or opening a question on its [forums](https://forums.developer.nvidia.com/c/agx-autonomous-machines/isaac/67).

## Support

* Please use GitHub [Discussions](https://github.com/isaac-sim/IsaacLab/discussions) for discussing ideas, asking questions, and requests for new features.
* Github [Issues](https://github.com/isaac-sim/IsaacLab/issues) should only be used to track executable pieces of work with a definite scope and a clear deliverable. These can be fixing bugs, documentation issues, new features, or general updates.

## Connect with the NVIDIA Omniverse Community

Have a project or resource you'd like to share more widely? We'd love to hear from you! Reach out to the
NVIDIA Omniverse Community team at OmniverseCommunity@nvidia.com to discuss potential opportunities
for broader dissemination of your work.

Join us in building a vibrant, collaborative ecosystem where creativity and technology intersect. Your
contributions can make a significant impact on the Isaac Lab community and beyond!

## License

The Isaac Lab framework is released under [BSD-3 License](LICENSE). The `isaaclab_mimic` extension and its corresponding standalone scripts are released under [Apache 2.0](LICENSE-mimic). The license files of its dependencies and assets are present in the [`docs/licenses`](docs/licenses) directory.

## Acknowledgement

Isaac Lab development initiated from the [Orbit](https://isaac-orbit.github.io/) framework. We would appreciate if you would cite it in academic publications as well:

```
@article{mittal2023orbit,
   author={Mittal, Mayank and Yu, Calvin and Yu, Qinxi and Liu, Jingzhou and Rudin, Nikita and Hoeller, David and Yuan, Jia Lin and Singh, Ritvik and Guo, Yunrong and Mazhar, Hammad and Mandlekar, Ajay and Babich, Buck and State, Gavriel and Hutter, Marco and Garg, Animesh},
   journal={IEEE Robotics and Automation Letters},
   title={Orbit: A Unified Simulation Framework for Interactive Robot Learning Environments},
   year={2023},
   volume={8},
   number={6},
   pages={3740-3747},
   doi={10.1109/LRA.2023.3270034}
}
```
