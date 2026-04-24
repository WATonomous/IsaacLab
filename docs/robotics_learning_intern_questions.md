# 100 Isaac Sim and Isaac Lab Interview Questions

## Context

These questions are designed for an Isaac Sim / Isaac Lab recruiter screen, technical recruiter screen, or early hiring-manager interview.

They cover:

- Isaac Sim fundamentals
- Isaac Lab fundamentals
- Reinforcement learning
- Imitation learning
- Teleoperation
- Asset import pipelines
- URDF, MJCF, and USD
- ROS2 integration
- Sim-to-real
- Domain randomization
- Newton physics
- Scaling and optimization
- Open-source development
- Questions tailored to my resume experience

---

## 1. Recruiter and Motivation Questions

1. Walk me through your background and how it connects to Isaac Lab.

2. Why are you interested in NVIDIA’s Isaac Lab team specifically?

3. What do you think Isaac Lab is used for?

4. What is the difference between Isaac Sim and Isaac Lab?

5. Why do robotics teams need simulation instead of only testing on real robots?

6. What part of the job description made you feel most aligned?

7. What part of the job description do you feel least experienced in?

8. Tell me about a robotics project where you had to learn a tool quickly.

9. What makes you interested in robot learning rather than traditional robotics software?

10. What would you want to work on first if you joined the Isaac Lab team?

---

## 2. Isaac Sim Fundamentals

11. Explain Isaac Sim to someone who has used Gazebo but not Isaac Sim.

12. What does it mean that Isaac Sim is built on Omniverse?

13. What is USD, and why does it matter in Isaac Sim?

14. Why is physically based rendering useful for robotics simulation?

15. What are the main advantages of Isaac Sim over Gazebo?

16. What are the disadvantages or pain points of Isaac Sim?

17. What is a prim in USD?

18. What is a stage in Isaac Sim?

19. How would you debug a robot asset that appears in Isaac Sim but does not move correctly?

20. How would you decide whether a simulation result is trustworthy?

---

## 3. Isaac Lab Framework Questions

21. What is Isaac Lab?

22. Why does Isaac Lab exist separately from Isaac Sim?

23. What is a task environment in Isaac Lab?

24. What are observations, actions, rewards, and terminations in an Isaac Lab RL environment?

25. What is the difference between a manager-based environment and a direct workflow environment?

26. When would you choose a manager-based workflow?

27. When would you choose a direct workflow?

28. What does `gymnasium.make()` do in the Isaac Lab workflow?

29. What does vectorized simulation mean?

30. Why is vectorization important for robot learning?

---

## 4. Environment Design Questions

31. Walk me through how you would create a new drawer-opening task in Isaac Lab.

32. What belongs in the scene setup of an Isaac Lab environment?

33. What belongs in the observation function?

34. What belongs in the reward function?

35. What belongs in the termination function?

36. How would you reset thousands of environments efficiently?

37. How would you randomize initial object positions?

38. How would you define success for a manipulation task?

39. How would you prevent reward hacking in a robot learning task?

40. How would you test whether your reward function is actually encouraging the behavior you want?

---

## 5. Reinforcement Learning Questions

41. What is PPO?

42. Why is PPO commonly used in Isaac Lab robot learning examples?

43. What is the difference between policy learning and motion planning?

44. What does the policy output in a robot control task?

45. What are common action spaces for robot arms?

46. What are common observation spaces for robot arms?

47. What is the difference between joint-space control and end-effector-space control?

48. Why can dense rewards make training easier?

49. Why can sparse rewards be harder but sometimes more realistic?

50. How would you know if a PPO training run is failing?

---

## 6. Imitation Learning and Teleoperation Questions

51. What is imitation learning?

52. What is learning from demonstration?

53. How does teleoperation help collect demonstration data?

54. What kind of data would you save during a teleoperation demo?

55. How would you evaluate whether demonstration data is good quality?

56. What are the weaknesses of imitation learning?

57. What is covariate shift in imitation learning?

58. How would you improve a policy that imitates well at first but fails when slightly off-distribution?

59. How would you compare teleoperation-based data collection with scripted expert demonstrations?

60. How would your Quest2 teleoperation experience transfer to Isaac Lab Mimic or XR teleoperation?

---

## 7. Asset Pipeline, URDF, MJCF, and USD Questions

61. What is URDF?

62. What is MJCF?

63. Why does Isaac Sim convert robot assets into USD?

64. What problems can happen when importing a URDF into Isaac Sim?

65. What are collision meshes, and why do they matter?

66. What are visual meshes, and how are they different from collision meshes?

67. What are inertial properties in a robot model?

68. What happens if mass or inertia values are wrong?

69. How would you validate that a URDF-to-USD conversion worked correctly?

70. What would you check if a robot explodes, jitters, or falls apart in simulation?

---

## 8. Physics, Sim-to-Real, and Newton Questions

71. What is the sim-to-real gap?

72. What causes sim-to-real failure in manipulation tasks?

73. What is domain randomization?

74. What parameters would you randomize for a drawer-opening task?

75. What is system identification?

76. How does system identification differ from domain randomization?

77. Why is contact-rich manipulation hard to simulate?

78. What is the difference between rigid-body and deformable simulation?

79. Why is Newton physics relevant to Isaac Lab?

80. Why might differentiable physics be useful for robot learning?

---

## 9. ROS2 and Robotics Integration Questions

81. How does Isaac Sim integrate with ROS2?

82. What is the ROS2 bridge?

83. What ROS2 topics would you expect from a simulated robot?

84. What is `/tf`, and why is it important?

85. How would you connect a real ROS2 controller to a simulated robot in Isaac Sim?

86. What is the difference between sim time and wall time?

87. Why does clock synchronization matter in simulation?

88. What are common issues when bridging Isaac Sim with ROS2?

89. How would you debug a ROS2 topic that is publishing but not moving the robot?

90. How would you use Isaac Sim to test a ROS2 perception stack?

---

## 10. Scaling, Optimization, and Open-Source Development Questions

91. Why does Isaac Lab care about running many environments in parallel?

92. What does GPU-accelerated simulation mean?

93. Why is avoiding CPU-GPU data transfer important for RL training?

94. How would you profile a slow Isaac Lab training job?

95. What metrics would you track when benchmarking simulation performance?

96. How would you make a robot-learning environment faster?

97. What does headless simulation mean, and why is it useful?

98. How would you contribute to an open-source robotics project like Isaac Lab?

99. How would you handle a bug report from a researcher using Isaac Lab?

100. What would you do in your first two weeks to ramp up on the Isaac Lab codebase?

---

# Highest Priority Questions to Prepare First

These are the most likely questions for a recruiter or early technical screen:

1. Walk me through your background and how it connects to Isaac Lab.

2. Why are you interested in NVIDIA’s Isaac Lab team specifically?

3. What do you think Isaac Lab is used for?

4. What is the difference between Isaac Sim and Isaac Lab?

5. Why do robotics teams need simulation instead of only testing on real robots?

21. What is Isaac Lab?

22. Why does Isaac Lab exist separately from Isaac Sim?

31. Walk me through how you would create a new drawer-opening task in Isaac Lab.

41. What is PPO?

51. What is imitation learning?

61. What is URDF?

71. What is the sim-to-real gap?

73. What is domain randomization?

81. How does Isaac Sim integrate with ROS2?

91. Why does Isaac Lab care about running many environments in parallel?

98. How would you contribute to an open-source robotics project like Isaac Lab?

100. What would you do in your first two weeks to ramp up on the Isaac Lab codebase?

---

# Personal Resume-Based Questions They Might Ask

Because my resume mentions Isaac Sim, Isaac Lab, teleoperation, ROS2, PPO, URDF-to-USD, MuJoCo, and TensorRT, I should also prepare these:

1. You say you developed a Quest2 teleop pipeline. What exactly was streamed from the headset to the robot?

2. How did rosbridge fit into your Isaac Sim teleoperation pipeline?

3. What coordinate frames were involved in your teleop setup?

4. How did you map human/controller motion to robot joint commands?

5. What latency issues did you run into with teleoperation?

6. You say you collected 120 demonstrations. What data did each demo contain?

7. How did you decide whether a demonstration was good enough to train on?

8. What is ACT, and why did you use it for the SO-100 arm?

9. What failed when fine-tuning the ACT policy?

10. How would you scale from 120 demonstrations to a stronger imitation-learning dataset?

11. You converted a custom arm from URDF to USD. What broke during conversion?

12. How did you validate the imported USD asset?

13. What did the drawer-opening environment contain?

14. What were the observations in your drawer-opening task?

15. What were the actions in your drawer-opening task?

16. What reward terms did you use for drawer opening?

17. How did you terminate successful and failed episodes?

18. What domain randomization would improve your drawer-opening task?

19. How did PPO perform on your custom arm?

20. What would you change if you rebuilt the task today?

21. You mention a MuJoCo solver for IK. How did that connect with Isaac Lab?

22. What is inverse kinematics?

23. Why is IK hard for a 21-DOF hand?

24. What does it mean to converge to 0.1 mm tolerance?

25. How would you explain the difference between IK and RL to a recruiter?

26. You mention TensorRT speedup. What was the original bottleneck?

27. Why does depth-estimation latency matter in robotics?

28. How would you integrate perception into a robot-learning environment?

29. How would you test whether a learned policy transfers to the real SO-100 arm?

30. What was the hardest debugging issue you faced in Isaac Sim or Isaac Lab?

---

# Questions I Should Ask Them

1. What part of Isaac Lab is the team currently investing in most heavily: asset pipelines, RL environments, imitation learning, Newton integration, or scaling?

2. How much of the internship would involve open-source Isaac Lab development versus internal NVIDIA tooling?

3. What does a successful intern project usually look like on the Isaac Lab team?

4. How does the team validate physical fidelity between Isaac Lab simulations and real robot hardware?

5. What kinds of robots or benchmark tasks are most important to the team right now?

6. How is Newton expected to change the Isaac Lab workflow?

7. What are the biggest pain points researchers report when using Isaac Lab?

8. How does the team think about balancing ease of use with low-level performance?

9. What level of RL experience do you expect interns to have when they start?

10. What would you recommend I study before joining the team?
