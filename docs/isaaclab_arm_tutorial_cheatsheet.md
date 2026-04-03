# Isaac Lab Arm Tutorial Cheatsheet

This file is a running cheatsheet we will fill tutorial-by-tutorial.

## Baseline Setup (Your Arm Scene)

Use your arm bootstrap script as the default starting point for all tutorials:

- Launch app with `AppLauncher`
- Create `SimulationContext` with desired `dt` and `device`
- Build scene via `InteractiveSceneCfg`
- Add:
  - Ground plane
  - Dome light
  - `ARM_CFG` robot at `{ENV_REGEX_NS}/Robot`
- Reset sim, call `sim.play()`
- In loop:
  - Set desired joint positions
  - `scene.write_data_to_sim()`
  - `sim.step()`
  - `scene.update(sim_dt)`

## Standard Run Command Pattern

Adjust script path and device as needed:

```bash
./isaaclab.sh -p <path_to_script.py> --device cuda:0
```

CPU fallback:

```bash
./isaaclab.sh -p <path_to_script.py> --device cpu
```

Full GUI Isaac Sim launch (for tutorials with `Tools -> Robotics`):

```bash
./isaaclab.sh -s \
  --enable isaacsim.gui.menu \
  --enable omni.graph.bundle.action \
  --enable isaacsim.core.nodes \
  --enable isaacsim.robot.manipulators.ui \
  --enable isaacsim.robot_setup.assembler \
  --enable isaacsim.robot_setup.gain_tuner
```

Important:
- Use `-s` for full simulator GUI tutorials.
- Use `-p` only for running standalone Python scripts (your arm-control workflow).

Run your arm script with full Isaac Sim UI (best of both worlds):

```bash
./isaaclab.sh -p arm_test.py \
  --experience isaacsim.exp.full.kit \
  --kit_args "--enable isaacsim.gui.menu --enable omni.graph.bundle.action --enable isaacsim.core.nodes --enable isaacsim.robot.manipulators.ui --enable isaacsim.robot_setup.assembler --enable isaacsim.robot_setup.gain_tuner"
```

Why this works:
- `-p arm_test.py` keeps your custom arm loading logic.
- `--experience isaacsim.exp.full.kit` switches from Isaac Lab minimal experience to full Isaac Sim UI.
- `--kit_args` ensures robotics/graph extensions are active.

## Tutorial 1 Notes

### Tutorial: Quickstart with Isaac Sim

Link:
- https://docs.isaacsim.omniverse.nvidia.com/4.5.0/introduction/quickstart_isaacsim.html

Goal:
- Learn Isaac Sim fundamentals in three modes: GUI interaction, Script Editor, and standalone Python.

Key concepts:
- Stage = your scene graph (add prims/lights/assets here).
- Physics simulation requires a physics scene and timeline/play control.
- Extensions provide tools (like Script Editor) inside the app.
- Standalone mode is the production path for reproducible scripts.

How to do it (tutorial flow):
- GUI path:
  - Open Isaac Sim.
  - Create a simple scene (ground/object/light) and inspect viewport + stage.
  - Use Play/Stop timeline controls to confirm simulation runs.
- Script Editor path:
  - Enable the Script Editor extension from the Extensions window.
  - Run short Python snippets directly in-app to spawn/edit scene items.
- Standalone path:
  - Create a Python script that launches app, sets up world/scene, steps simulation in a loop, then closes app.
  - Run it from terminal.

How to adapt to your arm:
- Skip generic cube/object examples and use your `ARM_CFG` in `ArmSceneCfg`.
- Keep your current loop (`set_joint_position_target` + `scene.write_data_to_sim` + `sim.step` + `scene.update`).
- For every new tutorial concept, add only that concept around your existing arm script.
  - Example: if tutorial teaches lighting, edit only light config in your scene.
  - Example: if tutorial teaches stepping/control, apply it to arm joints instead of tutorial objects.

Minimal code changes for this tutorial:
- Keep your script structure exactly as-is.
- Add temporary prints for sanity checks:
  - `print(robot.data.default_joint_pos.shape)`
  - `print(sim.get_physics_dt())`
- Optionally test Script Editor snippets in GUI, then move stable logic back into your standalone arm script.

Common errors and fixes:
- App closes immediately:
  - Make sure simulation loop runs while `simulation_app.is_running()`.
- Nothing moves:
  - Confirm you call `robot.set_joint_position_target(...)` before stepping.
- Scene looks dark/flat:
  - Verify dome light exists and has non-trivial intensity.

Quick checks:
- Camera shows arm at startup.
- Simulation time advances when playing.
- Arm holds default pose stably with no exploding physics.

## Tutorial 2 Notes

### Tutorial: Quickstart with a Robot

Link:
- https://docs.isaacsim.omniverse.nvidia.com/4.5.0/introduction/quickstart_isaacsim_robot.html

Goal:
- Inspect robot joints and command robot motion from GUI and script.

If you cannot see `Tools -> Robotics`:
- You are likely running an app/layout where robotics menu extensions are not loaded by default.
- Open `Window -> Extensions` and enable:
  - `isaacsim.gui.menu`
  - `omni.graph.bundle.action`
  - `isaacsim.core.nodes`
- Also enable robot UI/menu extensions:
  - `isaacsim.robot.manipulators.ui`
  - `isaacsim.robot_setup.assembler`
  - `isaacsim.robot_setup.gain_tuner`
- Then restart Isaac Sim and check again.

If it is still missing after enabling extensions:
- Confirm you launched **Isaac Sim Full** (not minimal/Python app template, and not your Isaac Lab standalone script).
- Reset layout from `Window -> Layout -> Reset to Default`.
- In Extensions, disable "Enabled Only" filter and search again.
- Make enabled extensions persistent by toggling their startup/autoload option before restart.

Where to open the graph editor:
- `Window -> Graph Editors -> Action Graph`

How to move joints without the graph generator (reliable fallback):
- `Tools -> Physics -> Physics Inspector`
- Select your robot articulation.
- Press Play.
- Edit joint target/default values in inspector.

How to move joints in your Isaac Lab arm script (recommended for your workflow):
- Keep using:
  - `robot.set_joint_position_target(...)`
  - `scene.write_data_to_sim()`
  - `sim.step()`
  - `scene.update(sim_dt)`
- This bypasses GUI menu/extension issues entirely.

Common mismatch:
- Tutorial screenshots can show menu items that are hidden in your current app experience or disabled extension set.
- If `Window -> Graph Editors -> Action Graph` exists but `Tools -> Robotics` does not, your OmniGraph UI is present but robotics shortcut menu is not.

## Scene Graph & Multiple Robot Spawning

The scene graph is Isaac Sim's way of organizing 3D objects like a folder structure:

```
/World/
├── defaultGroundPlane
├── Light  
├── Origin1/              # "Container" at position (0,0,0)
│   └── Robot            # Cart-pole spawns here
└── Origin2/              # "Container" at position (-1,0,0)
    └── Robot            # Cart-pole spawns here
```

Key concepts:
- **Prims** = scene graph nodes (like folders that can hold 3D objects)
- **Xform** = transform container (invisible box that holds objects at specific positions)
- **Wildcard paths** = use `.*` to spawn robots at multiple locations

How to spawn multiple robots:
```python
# 1. Define spawn locations
origins = [[0.0, 0.0, 0.0], [-1.0, 0.0, 0.0]]

# 2. Create transform containers at each location
prim_utils.create_prim("/World/Origin1", "Xform", translation=origins[0])
prim_utils.create_prim("/World/Origin2", "Xform", translation=origins[1])

# 3. Use wildcard path to spawn robots in ALL containers
robot_cfg.prim_path = "/World/Origin.*/Robot"  # Matches Origin1, Origin2, etc.
robot = Articulation(cfg=robot_cfg)  # Creates robots at all matching locations
```

## Robot State Understanding

### Root State Structure
Every robot has a `root_state` tensor with shape `[num_robots, 13]`:

```python
# Each robot's state contains 13 values:
root_state = [
    [x, y, z, qx, qy, qz, qw, vx, vy, vz, wx, wy, wz],  # Robot 1
    [x, y, z, qx, qy, qz, qw, vx, vy, vz, wx, wy, wz]   # Robot 2
]
```

**Position (0:3):** `[x, y, z]` - where robot is in 3D space
**Orientation (3:7):** `[qx, qy, qz, qw]` - how robot is rotated (quaternion)
**Linear Velocity (7:10):** `[vx, vy, vz]` - movement speed in each direction
**Angular Velocity (10:13):** `[wx, wy, wz]` - rotation speed around each axis

### Why Split at Index 7
```python
robot.write_root_pose_to_sim(root_state[:, :7])     # Position + Orientation
robot.write_root_velocity_to_sim(root_state[:, 7:]) # Linear + Angular velocity
```

Isaac Sim has separate functions for setting **pose** (where/how oriented) vs **velocity** (how fast moving).

### Joint Data Structure
For cart-pole with 2 joints:
```python
# Shape: [num_robots, num_joints]
joint_pos = [
    [cart_position, pole_angle],    # Robot 1
    [cart_position, pole_angle]     # Robot 2
]
```

## Control Loop Patterns

### Reset Every N Steps Pattern
```python
if count % 500 == 0:
    # Reset robot positions to origins
    root_state = robot.data.default_root_state.clone()
    root_state[:, :3] += origins  # Offset by spawn positions
    robot.write_root_pose_to_sim(root_state[:, :7])
    robot.write_root_velocity_to_sim(root_state[:, 7:])
    
    # Reset joints with small random noise
    joint_pos = robot.data.default_joint_pos.clone()
    joint_pos += torch.rand_like(joint_pos) * 0.1
    robot.write_joint_state_to_sim(joint_pos, joint_vel)
    
    robot.reset()
```

### Random Force Application
```python
# Generate random forces matching joint structure
efforts = torch.randn_like(robot.data.joint_pos) * 5.0

# Apply forces to joints
robot.set_joint_effort_target(efforts)
robot.write_data_to_sim()

# Step simulation
sim.step()
robot.update(sim_dt)
```

Key insight: `torch.randn_like()` creates random tensor with same shape as input, then `* 5.0` scales to useful force range.

## Pretrained Model Loading & Interactive Control

From H1 locomotion demo - how to load and use pretrained models:

```python
# Load pretrained checkpoint
checkpoint = get_published_pretrained_checkpoint(RL_LIBRARY, TASK)

# Create environment and runner
env = RslRlVecEnvWrapper(ManagerBasedRLEnv(cfg=env_cfg))
ppo_runner = OnPolicyRunner(env, agent_cfg.to_dict(), device=device)
ppo_runner.load(checkpoint)

# Get inference policy
policy = ppo_runner.get_inference_policy(device=device)

# Use in simulation loop
with torch.inference_mode():
    action = policy(obs)
    obs, _, _, _ = env.step(action)
```

### Interactive Keyboard Control
```python
# Define control mappings
_key_to_control = {
    "UP": torch.tensor([1.0, 0.0, 0.0, 0.0]),     # Move forward
    "DOWN": torch.tensor([0.0, 0.0, 0.0, 0.0]),   # Stop
    "LEFT": torch.tensor([1.0, 0.0, 0.0, -0.5]),  # Turn left while moving
    "RIGHT": torch.tensor([1.0, 0.0, 0.0, 0.5]),  # Turn right while moving
}

# Apply commands based on keyboard input
def _on_keyboard_event(self, event):
    if event.type == carb.input.KeyboardEventType.KEY_PRESS:
        if event.input.name in self._key_to_control:
            self.commands[self._selected_id] = self._key_to_control[event.input.name]
```

## Tutorial 3 Notes

### Tutorial: Assets - Articulation (Cart-Pole)

What we learned:
- How to spawn multiple robots using wildcard paths and transform containers
- Robot state structure (13-element root_state with position/orientation/velocity)
- Why state is split at index 7 for pose vs velocity functions
- Random force application using `torch.randn_like()` and effort targets
- Reset patterns every N simulation steps

Goal:
- Understand articulated robot spawning, state management, and random control

Key concepts:
- **Scene graph organization** - hierarchical folder-like structure for 3D objects
- **Transform containers** - invisible positioning boxes created with `prim_utils.create_prim()`
- **Wildcard spawning** - `"/World/Origin.*/Robot"` pattern to spawn at multiple locations
- **Root state structure** - 13-element tensor: `[x,y,z, qx,qy,qz,qw, vx,vy,vz, wx,wy,wz]`
- **Effort targets** - force/torque values applied to robot joints

What to run:
- Script: `scripts/tutorials/01_assets/run_articulation.py`
- Command: `./isaaclab.sh -p scripts/tutorials/01_assets/run_articulation.py`

How to adapt to your arm:
- Replace `CARTPOLE_CFG` with your `ARM_CFG`
- Use same wildcard pattern: `"/World/Origin.*/Robot"`
- Apply random forces to arm joints instead of cart-pole
- Adjust force magnitude based on your arm's joint limits

Minimal code changes for your arm:
```python
# Replace cart-pole config
arm_cfg = ARM_CFG.copy()
arm_cfg.prim_path = "/World/Origin.*/Robot" 
arm = Articulation(cfg=arm_cfg)

# Apply random joint efforts (adjust magnitude for arm)
efforts = torch.randn_like(robot.data.joint_pos) * 2.0  # Smaller forces for arm
robot.set_joint_effort_target(efforts)
```

Common errors and fixes:
- **Robots spawn at (0,0,0) instead of origins**: Forgot to add origins offset in reset
  - Fix: `root_state[:, :3] += origins`
- **Robots explode/unstable**: Forces too large for robot type
  - Fix: Reduce force multiplier from 5.0 to smaller value
- **Only one robot spawns**: Wildcard path not matching containers
  - Fix: Ensure Origin containers exist and path uses `Origin.*` pattern

Quick checks:
- Two robots spawn at different positions
- Robots reset to starting positions every 500 steps  
- Random forces cause chaotic but bounded movement
- Simulation runs smoothly without crashes

## Tutorial 4 Notes

### Tutorial: Assets - Surface Gripper (Pick-and-Place Robot)

What we learned:
- How to configure and control surface grippers on robots
- Gripper state management (Open/Closing/Closed states)
- Command mapping for gripper control (-1 to 1 range)
- Integration of grippers with articulated robots

Goal:
- Understand surface gripper mechanics and control patterns

Key concepts:
- **Surface Gripper** - specialized end-effector that can grasp objects through surface contact
- **Gripper Configuration** - parameters like max_grip_distance, force limits, retry intervals
- **Command mapping** - translating numeric commands to gripper actions (Open/Close/Idle)
- **State querying** - reading current gripper state from simulation

What to run:
- Script: `scripts/tutorials/01_assets/run_surface_gripper.py`
- Command: `./isaaclab.sh -p scripts/tutorials/01_assets/run_surface_gripper.py --device cpu`

Surface Gripper Configuration:
```python
# Create surface gripper config
surface_gripper_cfg = SurfaceGripperCfg()
surface_gripper_cfg.prim_path = "/World/Origin.*/Robot/picker_head/SurfaceGripper"
surface_gripper_cfg.max_grip_distance = 0.1      # [m] Max grasp distance
surface_gripper_cfg.shear_force_limit = 500.0    # [N] Perpendicular force limit
surface_gripper_cfg.coaxial_force_limit = 500.0  # [N] Axial force limit  
surface_gripper_cfg.retry_interval = 0.1         # [s] Grasp state duration

# Instantiate gripper
surface_gripper = SurfaceGripper(cfg=surface_gripper_cfg)
```

Gripper Control Pattern:
```python
# Generate random commands (-1 to 1)
gripper_commands = torch.rand(surface_gripper.num_instances) * 2.0 - 1.0

# Command mapping:
# -1.0 to -0.3 → Opening
# -0.3 to 0.3  → Idle  
# 0.3 to 1.0   → Closing

# Set commands and update
surface_gripper.set_grippers_command(gripper_commands)
surface_gripper.write_data_to_sim()
sim.step()
surface_gripper.update(sim_dt)
```

Gripper State Reading:
```python
# Query current state
surface_gripper_state = surface_gripper.state

# State values:
# -1 → Gripper is Open
#  0 → Gripper is Closing
#  1 → Gripper is Closed
```

How to adapt to your arm:
- Add surface gripper to your arm's end-effector
- Update gripper prim_path to match your arm's structure
- Adjust force limits based on your arm's payload requirements
- Integrate gripper commands with your arm control logic

Minimal code changes for your arm:
```python
# Add gripper configuration to your scene
gripper_cfg = SurfaceGripperCfg()
gripper_cfg.prim_path = "/World/Origin.*/Robot/end_effector/gripper"
gripper_cfg.max_grip_distance = 0.05  # Adjust for arm scale
gripper = SurfaceGripper(cfg=gripper_cfg)

# In your control loop
gripper_command = compute_gripper_command()  # Your logic here
gripper.set_grippers_command(gripper_command)
gripper.write_data_to_sim()
```

Common errors and fixes:
- **Gripper not found**: Wrong prim_path in configuration
  - Fix: Check USD file structure for correct gripper path
- **Gripper not responding**: Commands not being written to sim
  - Fix: Ensure `write_data_to_sim()` is called after setting commands
- **Force limits too low**: Objects slip from gripper
  - Fix: Increase `shear_force_limit` and `coaxial_force_limit`

Quick checks:
- Pick-and-place robots spawn with grippers attached
- Gripper commands print to terminal with mapped states
- Gripper state changes between Open/Closing/Closed
- Random commands cause visible gripper opening/closing

Integration with InteractiveScene:
```python
# For production use, register gripper in scene
scene = InteractiveScene()
scene.surface_grippers["gripper"] = surface_gripper
# Scene automatically handles write_data_to_sim() and update() calls
```

## Tutorial 5 Notes

### Tutorial: Interactive Scene vs Manual Asset Management

**Key difference explained**: 
- **Articulation** = Single robot/asset class that you manually spawn and control
- **InteractiveScene** = Container/manager that holds multiple assets and manages them collectively

What we learned:
- How to replace manual asset spawning with scene configuration classes
- Environment cloning using `ENV_REGEX_NS` for multiple environments
- Centralized scene management vs individual asset management
- Difference between interactive and non-interactive scene entities

Goal:
- Understand scene management patterns and multi-environment workflows

Key concepts:
- **InteractiveSceneCfg** - configuration class that defines entire scene structure
- **ENV_REGEX_NS** - special variable that gets replaced with `/World/envs/env_{i}` for cloning
- **AssetBaseCfg** - for non-interactive prims (lights, ground plane)
- **ArticulationCfg** - for interactive prims (robots, rigid bodies)
- **Centralized management** - scene handles all write/update operations

What to run:
- Script: `scripts/tutorials/02_scene/create_scene.py`
- Command: `./isaaclab.sh -p scripts/tutorials/02_scene/create_scene.py --num_envs 32`

Scene Configuration Pattern:
```python
@configclass
class CartpoleSceneCfg(InteractiveSceneCfg):
    """Configuration for a cart-pole scene."""
    
    # Non-interactive prims (lights, ground)
    ground = AssetBaseCfg(
        prim_path="/World/defaultGroundPlane", 
        spawn=sim_utils.GroundPlaneCfg()
    )
    
    dome_light = AssetBaseCfg(
        prim_path="/World/Light", 
        spawn=sim_utils.DomeLightCfg(intensity=3000.0, color=(0.75, 0.75, 0.75))
    )
    
    # Interactive prims (robots, etc.)
    cartpole: ArticulationCfg = CARTPOLE_CFG.replace(prim_path="{ENV_REGEX_NS}/Robot")
```

Scene Instantiation:
```python
# Create scene configuration with multiple environments
scene_cfg = CartpoleSceneCfg(num_envs=32, env_spacing=2.0)

# Create scene instance
scene = InteractiveScene(scene_cfg)

# Access entities by their config names
robot = scene["cartpole"]
```

Prim Path Patterns:
```python
# Absolute paths (single instance)
ground: prim_path="/World/defaultGroundPlane"
light:  prim_path="/World/Light"

# Relative paths with ENV_REGEX_NS (gets cloned per environment)
robot:  prim_path="{ENV_REGEX_NS}/Robot"
# Becomes: /World/envs/env_0/Robot, /World/envs/env_1/Robot, etc.
```

**Manual vs Scene Management**:

| Manual Approach | InteractiveScene |
|------------------|------------------|
| `robot.reset()` | `scene.reset()` |
| `robot.write_data_to_sim()` | `scene.write_data_to_sim()` |
| `robot.update(sim_dt)` | `scene.update(sim_dt)` |
| Spawn each asset individually | Automatic spawning from config |
| Manual environment cloning | Automatic with `num_envs` |

How to adapt to your arm:
- Replace manual spawning with scene configuration
- Define your arm in config class using ArticulationCfg  
- Use `{ENV_REGEX_NS}` in prim_path for multi-environment support
- Access arm via `scene["arm_name"]`

Minimal code changes for your arm:
```python
@configclass
class ArmSceneCfg(InteractiveSceneCfg):
    # Ground and lighting (non-interactive)
    ground = AssetBaseCfg(prim_path="/World/defaultGroundPlane", spawn=sim_utils.GroundPlaneCfg())
    light = AssetBaseCfg(prim_path="/World/Light", spawn=sim_utils.DomeLightCfg(intensity=3000.0))
    
    # Your arm (interactive)
    arm: ArticulationCfg = ARM_CFG.replace(prim_path="{ENV_REGEX_NS}/Robot")

# Create scene with multiple environments
scene_cfg = ArmSceneCfg(num_envs=4, env_spacing=3.0)
scene = InteractiveScene(scene_cfg)

# Access your arm
arm = scene["arm"]

# Use centralized scene management
scene.reset()
scene.write_data_to_sim()
sim.step()
scene.update(sim_dt)
```

Benefits over manual approach:
- **Automatic cloning** - `num_envs` creates multiple environments automatically
- **Centralized control** - one `scene.reset()` vs calling reset on each asset
- **Easier management** - all assets in one container
- **Cleaner code** - configuration-driven vs imperative spawning

Common errors and fixes:
- **Assets not spawning**: Missing `{ENV_REGEX_NS}` in prim_path for interactive assets
  - Fix: Use `prim_path="{ENV_REGEX_NS}/Robot"` for assets that should be cloned
- **Wrong config type**: Using ArticulationCfg for lights/ground
  - Fix: Use `AssetBaseCfg` for non-interactive prims, `ArticulationCfg` for robots
- **Cannot access asset**: Wrong key name in scene access
  - Fix: Use exact variable name from config class: `scene["cartpole"]`

Quick checks:
- Multiple environments spawn automatically (32 cart-poles in grid)
- Scene elements accessible via `scene["name"]` syntax
- Centralized scene.reset() affects all environments
- Environment spacing creates organized grid layout

## Per-Tutorial Notes Template

Copy this section for each tutorial and fill it:

### Tutorial: <title + link>

Goal:
- 

Key concepts:
- 

What to run:
- Script:
- Command:

How to adapt to your arm:
- 

Minimal code changes:
- 

Common errors and fixes:
- 

Quick checks:
- 

## Quick Reference

Simulation loop essentials:
- `scene.write_data_to_sim()`
- `sim.step()`
- `scene.update(sim_dt)`

Robot state:
- Read defaults: `robot.data.default_joint_pos`, `robot.data.default_joint_vel`
- Write state: `robot.write_joint_state_to_sim(...)`
- Target joints: `robot.set_joint_position_target(...)`

Multi-robot spawning:
- Create containers: `prim_utils.create_prim("/World/Origin1", "Xform", translation=pos)`
- Use wildcards: `robot_cfg.prim_path = "/World/Origin.*/Robot"`
- One Articulation object controls all instances

State management:
- Root state: `[x,y,z, qx,qy,qz,qw, vx,vy,vz, wx,wy,wz]` (13 elements)
- Split at 7: pose `[:, :7]` vs velocity `[:, 7:]`
- Joint state: `[num_robots, num_joints]` tensor

Force control:
- Random: `torch.randn_like(joint_pos) * magnitude`
- Set targets: `robot.set_joint_effort_target(efforts)`
- Apply: `robot.write_data_to_sim()`

Surface gripper control:
- Config: `SurfaceGripperCfg()` with force limits and max_grip_distance
- Commands: `gripper.set_grippers_command(commands)` with -1 to 1 range
- States: `gripper.state` returns -1 (Open), 0 (Closing), 1 (Closed)
- Update: `gripper.write_data_to_sim()` and `gripper.update(sim_dt)`

Scene management:
- Config: `@configclass` inheriting from `InteractiveSceneCfg`
- Cloning: Use `{ENV_REGEX_NS}` in prim_path for multi-environment assets
- Access: `scene["asset_name"]` using config variable names
- Control: `scene.reset()`, `scene.write_data_to_sim()`, `scene.update(sim_dt)`
