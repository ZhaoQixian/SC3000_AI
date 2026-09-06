<div align="center">

# 🤖 SC3000 Artificial Intelligence — Coursework Portfolio

**Reinforcement Learning on CartPole & Logic Programming in Prolog**

[![Course](https://img.shields.io/badge/NTU--CCDS-SC3000_AI-blue)](#)
[![Python](https://img.shields.io/badge/Python-3.x-3776AB?logo=python&logoColor=white)](#)
[![PyTorch](https://img.shields.io/badge/PyTorch-%3E%3D1.9-EE4C2C?logo=pytorch&logoColor=white)](#)
[![Prolog](https://img.shields.io/badge/SWI--Prolog-Logic%20Programming-BC424B?logo=prolog&logoColor=white)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

This repository contains my coursework for **SC3000 Artificial Intelligence** (College of Computing and Data Science, Nanyang Technological University), covering two pillars of AI:

| # | Project | Domain | Highlights |
|---|---------|--------|------------|
| 1 | [Balancing a Pole on a Cart](cartpole_RL/) | Reinforcement Learning | Deep Q-Network & Monte Carlo agents that **solve CartPole-v1** — perfect 500/500 average reward over 100 evaluation episodes |
| 2 | [Prolog Reasoning](Project-2/) | Knowledge Representation | First-order logic translation, proof tracing, and royal succession rules modelled in **SWI-Prolog** |

---

## 🧠 Assignment 1 — Reinforcement Learning: Balancing a Pole on a Cart

The classic **CartPole-v1** control problem: train an agent to keep a pole balanced upright on a moving cart for as long as possible (max 500 steps per episode). Open notebook: [`cartpole_RL/assignment1.ipynb`](cartpole_RL/assignment1.ipynb).

### What was built

- **Deep Q-Network (DQN) agent** — a 3-layer MLP (4 → 128 → 128 → 2) with Xavier initialisation, trained with epsilon-greedy exploration, **experience replay**, and a target for Q-value bootstrapping (γ = 0.99, lr = 5e-4, batch = 128).
- **Systematic evaluation** — 10-episode and 100-episode test runs with success-rate reporting against the standard reward ≥ 195 benchmark.
- **Fine-tuning experiments** — ablations over learning rate schedules, network architectures, and experience replay settings, with the best configuration re-trained and re-evaluated.
- **Monte Carlo control** — a first-visit Monte Carlo agent using state discretisation, trained over 15,000 episodes (standalone notebook: [`cartpole_RL/monte_carlo.ipynb`](cartpole_RL/monte_carlo.ipynb)).

### Key results

| Model | Evaluation | Result |
|-------|-----------|--------|
| **DQL agent** | 100 test episodes | **Avg reward 500.00 (maximum)** — 100% success rate |
| DQL — training | 500 max episodes | Converged & early-stopped at episode 190 with a perfect 500.0 run |
| Fine-tuned DQL variants | 100 test episodes | Up to 359.48 avg reward, 100% success rate |
| Monte Carlo control | 100+ test episodes | Avg cumulative reward ≈ 231 |

### 🎬 Agent demos

Each clip is a real evaluation episode rendered by the trained agent:

| Deep Q-Learning agent | Fine-tuned agent | Monte Carlo agent |
|:---:|:---:|:---:|
| <video src="cartpole_RL/video/rl-video-episode-0.mp4" controls muted width="280"></video> | <video src="cartpole_RL/video/fine-tuned-episode-0.mp4" controls muted width="280"></video> | <video src="cartpole_RL/video/monte_carlo_implementation.mp4" controls muted width="280"></video> |

### Trained models included

- [`dql_cartpole.pth`](cartpole_RL/dql_cartpole.pth) — trained DQN weights
- [`dql_cartpole_finetuned.pth`](cartpole_RL/dql_cartpole_finetuned.pth) — fine-tuned DQN weights
- [`monte_carlo_robust_model.pkl`](cartpole_RL/monte_carlo_robust_model.pkl) — saved Monte Carlo policy

### ▶️ Running Assignment 1

```bash
pip install -r cartpole_RL/dependencies.txt   # gym, torch, matplotlib, moviepy, ...
jupyter notebook cartpole_RL/assignment1.ipynb
```

---

## 🧩 Assignment 2 — Logic Programming in Prolog

Knowledge representation and reasoning exercises implemented in **SWI-Prolog**, with the full written report (including proof traces) in [`Project-2/ZQX_LZL_MR_Assignment2.pdf`](Project-2/ZQX_LZL_MR_Assignment2.pdf).

### Question 1 — First-Order Logic & Unethical Behaviour

Translates a smart-phone-industry scenario ("Did Stevey act unethically?") from natural language into **first-order logic**, encodes it as Prolog clauses, and proves `unethical(stevey)` with a resolution trace. See [`qn_1_1.pl`](Project-2/qn_1_1.pl).

### Question 2 — Royal Succession Rules

Models the British line of succession for Queen Elizabeth's four children under **two regimes**:

- **Old rule** — males inherit first (by birth order), then females ([Method 1: `born_before/2`](Project-2/qn_2_1.pl), plus a [refined variant with the new rule](Project-2/qn_2_2.pl))
- **New rule (absolute primogeniture)** — succession follows birth order regardless of gender ([Method 2](Project-2/qn_2_2_method2.pl): numeric `birth_order/2` with `findall`/`keysort` ordering and a dynamic `dead/1` predicate to exclude deceased heirs)

```prolog
?- [qn_2_2_method2].
?- old_succession_rule(queen_elizabeth).
Old succession order: [prince_charles,prince_andrew,prince_edward,princess_ann]
```

### ▶️ Running Assignment 2

Requires [SWI-Prolog](https://www.swi-prolog.org/):

```bash
swipl Project-2/qn_1_1.pl
?- unethical(stevey).
```

---

## 🗂 Repository Structure

```
SC3000_AI/
├── cartpole_RL/                       # Assignment 1 — Reinforcement Learning
│   ├── assignment1.ipynb              #   DQL agent: training, evaluation, rendering, fine-tuning
│   ├── monte_carlo.ipynb              #   Standalone Monte Carlo control implementation
│   ├── dependencies.txt               #   Python dependencies
│   ├── dql_cartpole.pth               #   Trained DQL model
│   ├── dql_cartpole_finetuned.pth     #   Fine-tuned DQL model
│   ├── monte_carlo_robust_model.pkl   #   Saved Monte Carlo policy
│   └── video/                         #   Rendered evaluation episodes (.mp4)
└── Project-2/                         # Assignment 2 — Prolog
    ├── qn_1_1.pl                      #   Qn 1: FOL translation + unethical-boss proof
    ├── qn_2_1.pl                      #   Qn 2 (Method 1): succession via born_before/2
    ├── qn_2_2.pl                      #   Qn 2: old rule variant + new succession rule
    ├── qn_2_2_method2.pl              #   Qn 2 (Method 2): numeric birth order + findall/keysort
    └── ZQX_LZL_MR_Assignment2.pdf     #   Full written report with proof traces
```

## 👥 Authors

- **Zhao Qixian**
- **Lim Zu Liang**
- **Mehta Rishika**

## 📄 License

Released under the [MIT License](LICENSE).
