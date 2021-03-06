# Rishabh Jain(rj2315) & Vinamra Agrawal(va1215)
# distributed algorithms, n.dulay 2 feb 18
# coursework 2, paxos made moderately complex

defmodule Acceptor do
def start config do
  next {-1, -1}, [], config
end

defp next proposal_num, accepted, config do
  receive do
    { :p1a, leader, p } ->
      proposal_num = if p > proposal_num do
        p
      else
        proposal_num
      end
      send leader, { :p1b, self(), proposal_num, accepted }
      next proposal_num, accepted, config
    { :p2a, leader, {p, s, c} } ->
      accepted = if p == proposal_num do
        [{p, s, c} | accepted]
      else
        accepted
      end
      send leader, { :p2b, self(), proposal_num }
      next proposal_num, accepted, config
  end
end
end
