# Search Space Taxonomy

Start with high-impact parameters, then widen only when evidence suggests the bottleneck is elsewhere.

## Shared DRL Parameters

| Group | Examples | Scale |
|---|---|---|
| Optimizer | learning rate, weight decay, gradient clipping | log or linear |
| Discounting | gamma, lambda, n-step horizon | linear/categorical |
| Exploration | entropy coefficient, action noise, epsilon schedule, log std | log/linear |
| Batch/update | rollout length, batch size, minibatch size, update epochs | categorical/int |
| Network | hidden size, layers, activation, layer norm, recurrent units | categorical |
| Normalization | reward scale, observation normalization, advantage normalization | categorical/linear |
| Evaluation | validation scenarios, seeds, deterministic vs stochastic policy | categorical |

## PPO

Tune first:

- `learning_rate`
- `gamma`
- `gae_lambda`
- `clip_ratio`
- `target_kl`
- `entropy_coef` or entropy schedule
- `value_coef`
- `rollout_steps` or `rollout_episodes_per_update`
- `minibatch_size` or `mini_batch_episodes`
- `update_epochs`
- `max_grad_norm`
- `initial_log_std` for continuous control

Common constraints:

- Minibatch should not exceed rollout batch.
- Very high `update_epochs` plus small rollout can overfit samples.
- `target_kl` and `clip_ratio` jointly control policy step size.

## SAC

Tune first:

- Actor, critic, and alpha learning rates.
- `gamma`, `tau`, batch size, replay size.
- Target entropy or entropy auto-tuning settings.
- Update-to-data ratio and warmup steps.

Watch for entropy collapse, critic divergence, and replay buffer under-diversity.

## TD3/DDPG

Tune first:

- Actor and critic learning rates.
- `tau`, `policy_delay`, target update frequency.
- Exploration noise, target policy noise, noise clipping.
- Batch size, replay size, warmup steps.

Watch for brittle policies caused by too little exploration or critic overestimation.

## DQN Family

Tune first:

- Learning rate, batch size, replay size.
- Epsilon schedule: start, end, decay length.
- Target network update interval.
- `gamma`, n-step return, prioritized replay parameters.

Watch for unstable Q-values and performance spikes that disappear after exploration decay.

## Recurrent RL

Tune when partial observability or sequence memory matters:

- Hidden size and number of recurrent layers.
- Sequence length and truncated BPTT length.
- Burn-in length.
- Whether to reset hidden states at episode boundaries.
- Recurrent dropout or layer norm if present.

Do not compare recurrent and feed-forward policies without equalizing evaluation protocol and sequence handling.

## Multi-Agent RL

Tune additionally:

- Shared vs independent policies.
- Centralized critic settings.
- Communication or attention dimensions.
- Agent sampling balance.
- Population or opponent update schedules.

Report whether reward is individual, team, social welfare, or another aggregate.

## Freeze Or Exclude Parameters

Freeze parameters that are outside the target method, define the experimental condition, are purely environment constants, or create hidden algorithm changes. Record excluded parameters and the reason.

