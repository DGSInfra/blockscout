defmodule Explorer.Chain.Import.Stage.BlockReferencing do
  @moduledoc """
  Imports any tables that reference `t:Explorer.Chain.Block.t/0` and that were
  imported by `Explorer.Chain.Import.Stage.BlockRelated`.
  """

  alias Explorer.Chain.Import.{Runner, Stage}

  @behaviour Stage

  @impl Stage
  def runners do
    [
      Runner.Transaction.Forks,
      Runner.Logs,
      Runner.Tokens,
      Runner.TokenInstances,
      Runner.TransactionActions,
      Runner.Withdrawals,
      Runner.SignedAuthorizations
    ]
  end

  @impl Stage
  def all_runners,
    do: runners()

  @impl Stage
  def multis(runner_to_changes_list, options) do
    {final_multi, final_remaining_runner_to_changes_list} =
      Stage.single_multi(runners(), runner_to_changes_list, options)

    {[final_multi], final_remaining_runner_to_changes_list}
  end
end
