# Ring

## Installation
mix deps.get

## Usage
1) `iex -S mix`
2) Create a list of process ids. `pids = Ring.create_p(num)`
3) Link the newly spawned processes. `Ring.link_p(pids)`
4) Inspect the Process Info to determine if they are in fact linked. `pids |> Enum.map(fn pid -> "#{inspect pid}: #{inspect Process.info(pid, :links)}" end)`
5) Pick a random process to CRASH! `pids |> Enum.shuffle |> Enum.at(0) |> send(:crash)` 
6) Prove the linked processes have crashed. `pids |> Enum.map(fn pid -> Process.alive?(pid) end)`
