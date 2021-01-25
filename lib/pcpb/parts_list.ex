# @part_aliases [
#   [CPU, "01"],
#   [CPUCooler, "02"],
#   [Case, "03"],
#   [GPU, "04"],
#   [Memory, "05"],
#   [PSU, "06"]
# ]

# @atom_part_aliases [
#   [:cpu, "01"],
#   [:cpu_cooler, "02"],
#   [:case, "03"],
#   [:gpu, "04"],
#   [:memory, "05"],
#   [:psu, "06"]
# ]

alias Pcpb.Parts.{CPU, CPUCooler, Case, GPU, Memory, PSU}

defmodule Pcpb.PartsList do
  @part_repos [[:cpu, CPU], [:cpu_cooler, CPU_Cooler], [:gpu, GPU], [:case, Case], [:psu, PSU], [:memory, Memory], [:case, Case]]

  def part_repos, do: @part_repos
end
