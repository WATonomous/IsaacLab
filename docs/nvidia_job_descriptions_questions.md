# Additional Isaac Sim / Isaac Lab Questions Based on the Job Description

## A. Newton Simulation Integration Questions

101. What is Newton simulation, and why is NVIDIA integrating it with Isaac Lab?

102. How would you explain the difference between PhysX and Newton at a high level?

103. Why might a robotics learning framework want to support multiple physics backends?

104. What kinds of Isaac Lab abstractions would need to change to support a new physics engine?

105. What is the risk of making Isaac Lab too tightly coupled to PhysX?

106. If a policy works in PhysX but fails in Newton, what would you investigate first?

107. How would different physics engines affect joint ordering, contact behavior, and solver stability?

108. Why is sim-to-sim transfer useful before sim-to-real transfer?

109. What is differentiable physics, and why could it matter for robot learning?

110. What are the practical limitations of a new experimental physics backend?

111. If Newton uses different quaternion conventions than an existing backend, what bugs could happen?

112. How would you design tests to verify that an environment behaves similarly under PhysX and Newton?

113. What metrics would you compare when validating PhysX vs Newton on the same task?

114. How would you debug a robot that is stable in one physics backend but unstable in another?

115. What parts of Isaac Lab should be backend-agnostic, and what parts might remain backend-specific?

---

## B. Scalable Perception-in-the-Loop RL Questions

116. What does perception-in-the-loop reinforcement learning mean?

117. How is perception-in-the-loop RL different from state-based RL?

118. Why is training with camera observations harder than training with privileged simulator state?

119. What observations would you provide to a robot policy for a drawer-opening task?

120. When would you use RGB images, depth maps, segmentation masks, or point clouds as policy inputs?

121. What are the bottlenecks when training RL policies with rendered camera observations?

122. Why does rendering become expensive when running thousands of environments?

123. How would you reduce the cost of camera-based RL training?

124. What is the tradeoff between photorealistic rendering and training speed?

125. Why might you train first with state observations and later move to visual observations?

126. What is a teacher-student setup in robot learning?

127. How would privileged observations help train a better teacher policy?

128. Why can a student policy not rely on privileged simulator-only information?

129. What kinds of visual randomization would help a visuomotor policy transfer to the real world?

130. How would you evaluate whether a perception-in-the-loop policy is using vision correctly?

131. How would you detect if a policy overfits to simulator textures or lighting?

132. What failure modes happen when depth images in simulation are too clean compared to real sensors?

133. How would you simulate camera noise, latency, dropped frames, or motion blur?

134. How would you connect a perception model, such as a depth estimator or object detector, into an Isaac Lab RL loop?

135. How would you profile whether the bottleneck is physics simulation, rendering, neural network inference, or environment reset logic?

---

## C. Learning From Demonstration and Teleoperation Questions

136. What is learning from demonstration?

137. Why is teleoperation useful for collecting demonstrations?

138. What data should be stored in a demonstration dataset?

139. Why does Isaac Lab use HDF5-style demonstration files?

140. What is the difference between collecting demonstrations and generating additional demonstrations?

141. What does Isaac Lab Mimic try to solve?

142. How would you decide whether a demonstration is high quality?

143. What makes a teleoperation interface good for robot learning?

144. How would latency affect teleoperation quality?

145. What are the tradeoffs between keyboard, SpaceMouse, hand tracking, and VR/XR teleoperation?

146. What is end-effector teleoperation?

147. What is joint-space teleoperation?

148. Why might absolute hand tracking be better for some manipulation tasks?

149. Why might relative control be more stable than absolute control?

150. How would you map human hand motion to a robot gripper or dexterous hand?

151. What is retargeting in teleoperation?

152. What problems happen when the human hand has more degrees of freedom than the robot?

153. What problems happen when the robot has more degrees of freedom than the human control input?

154. How would you collect demonstrations for a drawer-opening task?

155. How would you split a complex task into subtasks for imitation learning?

156. What is covariate shift in imitation learning?

157. What would you do if the cloned policy performs well at the start of the trajectory but fails after one small mistake?

158. How would you combine imitation learning and reinforcement learning?

159. What would you measure when comparing teleop-collected demos versus scripted demonstrations?

160. How would your Quest2 teleoperation experience transfer to Isaac Lab teleoperation workflows?

---

## D. Open-Source Isaac Lab Development Questions

161. What does it mean to contribute to an open-source robotics framework?

162. How would you approach your first bug fix in Isaac Lab?

163. How would you read and understand a large robotics codebase like Isaac Lab?

164. What would you look for before opening a pull request?

165. How would you write a good issue report for an Isaac Lab bug?

166. How would you respond to a researcher who says an Isaac Lab environment is unstable?

167. How would you reproduce a user-reported bug in a simulation framework?

168. What information would you ask for when debugging a user's Isaac Lab issue?

169. Why are minimal reproducible examples important in open-source robotics?

170. How would you balance adding a feature quickly versus keeping the framework clean?

171. How would you avoid breaking existing environments when changing a shared API?

172. What kinds of tests would you write for a new Isaac Lab environment?

173. What kinds of tests would you write for an asset importer bug?

174. How would you document a new Isaac Lab workflow for users?

175. How would you explain a breaking change to the community?

176. What makes robotics open-source harder than typical web open-source?

177. How would you handle disagreements with external researchers using Isaac Lab?

178. How would you evaluate whether a proposed feature belongs in core Isaac Lab or in an external extension?

179. What would make an Isaac Lab tutorial useful for new users?

180. How would you engage with industrial users who care more about reliability than research flexibility?

---

## E. Massive Cloud Training, Benchmarking, Profiling, and Optimization Questions

181. Why does Isaac Lab need to scale training massively in the cloud?

182. What does it mean to train thousands of environments in parallel?

183. Why is GPU simulation valuable for reinforcement learning?

184. What is the difference between scaling number of environments and scaling number of GPUs?

185. What are the bottlenecks in large-scale RL training?

186. What is GPU utilization, and why does it matter?

187. What is the danger of constantly moving tensors between CPU and GPU?

188. How would you profile an Isaac Lab training run?

189. What metrics would you track during benchmarking?

190. What is environment step time?

191. What is policy inference time?

192. What is simulation FPS?

193. What is samples-per-second, and why is it useful?

194. What would cause low GPU utilization during training?

195. Why does headless mode improve training performance?

196. Why do complex collision meshes slow down simulation?

197. Why can excessive contact pairs hurt performance?

198. How would you simplify a robot asset to improve training speed?

199. How would you decide whether to use CPU or GPU simulation?

200. What would you do if training crashes with an out-of-memory error?

201. How would you make an Isaac Lab environment cheaper to reset?

202. How would you benchmark two versions of the same environment fairly?

203. How would you know whether an optimization changed the learning behavior?

204. What is the tradeoff between simulation fidelity and training throughput?

205. How would you design a profiling report for the Isaac Lab team?

---

## F. Robot Asset Pipeline Questions

206. What is the full robot asset pipeline from URDF or MJCF to a usable Isaac Lab environment?

207. What is URDF used for?

208. What is MJCF used for?

209. Why does Isaac Sim convert robot descriptions into USD?

210. What is the difference between a visual mesh and a collision mesh?

211. Why should collision geometry often be simpler than visual geometry?

212. What are inertial properties, and why do they matter?

213. What happens if mass or inertia values are wrong?

214. What is an articulation root?

215. What is a joint drive?

216. What are stiffness and damping in a simulated joint?

217. What happens if joint stiffness is too high?

218. What happens if damping is too low?

219. How would you validate that a URDF imported correctly into Isaac Sim?

220. How would you validate that an MJCF imported correctly into Isaac Sim?

221. What would you check if a robot's joints rotate around the wrong axis?

222. What would you check if the robot collapses under gravity?

223. What would you check if the robot jitters during simulation?

224. What would you check if a gripper cannot grasp an object reliably?

225. How would you compare the simulated robot to real hardware?

226. What real-world measurements would you collect to validate physical fidelity?

227. How would you tune friction, damping, stiffness, or contact parameters?

228. What is the danger of making simulation too stable compared to the real world?

229. What makes dexterous hands especially hard to model accurately?

230. How would you build a new Isaac Lab manipulation environment around a newly imported robot?

---

## G. New Environment Authoring Questions

231. How would you author a new Isaac Lab environment from scratch?

232. What files or components would you expect in a clean Isaac Lab task implementation?

233. How would you define the scene?

234. How would you define the robot asset?

235. How would you define objects in the environment?

236. How would you define observations?

237. How would you define actions?

238. How would you define rewards?

239. How would you define terminations?

240. How would you define resets?

241. How would you define curriculum?

242. How would you define domain randomization?

243. What is the difference between a task configuration and task logic?

244. How would you debug an environment where the robot never learns?

245. How would you debug an environment where the robot exploits the reward?

246. How would you visualize observations and rewards during training?

247. How would you test that resets are randomized correctly?

248. How would you test that parallel environments are independent?

249. How would you decide whether to use manager-based or direct environment workflows?

250. How would you make your environment easy for other researchers to modify?

---

## H. Physical Fidelity and Real-World Validation Questions

251. What does physical fidelity mean in robotics simulation?

252. How do you know if a simulated robot is physically accurate?

253. What real-world experiments would you run to validate a simulated arm?

254. How would you validate joint limits?

255. How would you validate torque limits?

256. How would you validate contact behavior?

257. How would you validate friction parameters?

258. How would you validate gripper behavior?

259. How would you validate sensor behavior?

260. How would you validate latency between command and motion?

261. How would you compare simulated joint trajectories with real joint trajectories?

262. How would you compare simulated end-effector motion with real end-effector motion?

263. How would you tune a simulator based on real robot logs?

264. What data would you log from the real robot?

265. What data would you log from simulation?

266. What error metrics would you compute between sim and real?

267. Why can matching one real-world trajectory still be insufficient?

268. How would you validate across a distribution of tasks instead of one motion?

269. What are signs that your simulator is overfit to one real hardware setup?

270. How would you present physical fidelity results to the Isaac Lab team?

---

## I. Sim-to-Real, Domain Randomization, and System Identification Questions

271. What is the sim-to-real gap?

272. What causes sim-to-real failure?

273. What is domain randomization?

274. What parameters would you randomize for robot manipulation?

275. What parameters would you randomize for legged locomotion?

276. What parameters would you randomize for visual policies?

277. What is system identification?

278. How is system identification different from domain randomization?

279. When would system identification be better than domain randomization?

280. When would domain randomization be better than system identification?

281. What is dynamics randomization?

282. What is visual randomization?

283. What is sensor randomization?

284. What is actuator randomization?

285. How would you randomize latency?

286. How would you randomize friction?

287. How would you randomize mass and inertia?

288. How would you randomize lighting and textures?

289. How would you randomize camera pose?

290. How would you randomize object geometry?

291. What is policy transfer?

292. Why might a policy trained in simulation fail immediately on hardware?

293. How would you safely test a sim-trained policy on a real robot?

294. What is a staged deployment process for sim-to-real?

295. Why should you start with low-speed or constrained real-world tests?

296. How would you monitor a real robot policy for unsafe behavior?

297. What is the role of residual learning in sim-to-real?

298. What is teacher-student distillation in sim-to-real?

299. What is the difference between sim-to-sim transfer and sim-to-real transfer?

300. How would you improve a policy that works in simulation but fails on the real robot?

---

## J. Python and Deep Learning Stack Questions

301. How comfortable are you with Python for robotics software?

302. What Python libraries have you used for robot learning?

303. How have you used PyTorch?

304. What is a tensor?

305. What is automatic differentiation?

306. Why is batching important in deep learning?

307. How does batching connect to vectorized RL environments?

308. What is a neural network policy?

309. What is the difference between training and inference?

310. What does a loss function measure?

311. How is supervised learning different from reinforcement learning?

312. How is imitation learning different from reinforcement learning?

313. What is behavior cloning?

314. What are gradients?

315. What is an optimizer?

316. What is overfitting?

317. What is validation in an ML workflow?

318. What would you do if a policy trains well but fails in evaluation?

319. How would you structure clean Python code for a new Isaac Lab feature?

320. How would you debug a Python training script that silently produces bad results?

---

## K. Robotics and Simulation Workflow Questions

321. What simulators have you used before?

322. How would you compare Isaac Lab, Isaac Gym, MuJoCo, and Gazebo?

323. What is MuJoCo good at?

324. What is Isaac Sim good at?

325. What is Isaac Lab good at?

326. What is Gazebo good at?

327. Why might researchers still use MuJoCo even if Isaac Lab exists?

328. Why might industrial robotics teams care about Isaac Sim?

329. What is the difference between a robotics simulator and a robot learning framework?

330. What is the difference between visual simulation and dynamics simulation?

331. What is a physics timestep?

332. What is control frequency?

333. Why does timestep choice affect stability?

334. What is the difference between position control, velocity control, and torque control?

335. What is inverse kinematics?

336. What is a Jacobian?

337. Why are contacts difficult in simulation?

338. Why are deformable objects difficult in simulation?

339. Why is dexterous manipulation difficult?

340. How would you explain your robotics simulation experience without overselling it?

---

## L. Questions They May Ask Because You Are Not an MS or PhD Student

341. This role asks for MS or PhD students. Why should we consider you as an undergrad?

342. What research-level experience do you have?

343. How have you shown you can learn graduate-level robotics topics?

344. What papers have you read related to robot learning?

345. How do you approach unfamiliar research code?

346. How would you ramp up on a topic like differentiable physics?

347. How would you ramp up on a topic like visuomotor policy learning?

348. How would you ramp up on a topic like sim-to-real transfer?

349. What is the hardest robotics concept you have taught yourself?

350. Why do you think your project experience can compensate for not being in grad school yet?

---

# Most Important Questions From This Add-On

If I only have limited time, I should prioritize these:

1. What is the difference between Isaac Sim and Isaac Lab?

2. What is Newton simulation, and why is NVIDIA integrating it with Isaac Lab?

3. What does perception-in-the-loop RL mean?

4. Why is camera-based RL harder than state-based RL?

5. What is learning from demonstration?

6. How does teleoperation help collect demonstration data?

7. What is Isaac Lab Mimic?

8. How would you collect demonstrations for a drawer-opening task?

9. How would you scale Isaac Lab training in the cloud?

10. What metrics would you track when benchmarking Isaac Lab training?

11. Why does headless mode improve performance?

12. Why do collision meshes affect simulation performance?

13. What is the URDF-to-USD asset pipeline?

14. How would you validate an imported robot asset?

15. What does physical fidelity mean?

16. What is the sim-to-real gap?

17. What is domain randomization?

18. What is system identification?

19. How would you safely transfer a policy from simulation to a real robot?

20. This role asks for MS or PhD students. Why should we consider you as an undergrad?
