--[[

  Simple Corona event delegation.
  "R"/"L" = Runtime/Local
  "F"/"T" = Function/Table
  `.peak` allows you to access the last data state of any channel

--]]

local memo = {}
local state = {}

function memo.publish(ev, payload)
  Runtime:dispatchEvent({name = ev, data = payload})
  state[ev] = data
end

function memo.subscribeRF(ev, fn) Runtime:addEventListener(ev, fn) end
function memo.subscribeRT(ev, tbl, fn) tbl[ev] = fn; Runtime:addEventListener(ev, tbl) end
function memo.subscribeLF(ev, tbl, fn) tbl:addEventListener(ev, fn) end
function memo.subscribeLT(ev, tbl, fn) tbl[ev] = fn; tbl:addEventListener(ev) end

function memo.unsubscribeRF(ev, fn) Runtime:removeEventListener(ev, fn) end
function memo.unsubscribeRT(ev, tbl) Runtime:removeEventListener(ev, tbl) end
function memo.unsubscribeLF(ev, tbl, fn) tbl:removeEventListener(ev, fn) end
function memo.unsubscribeLT(ev, tbl) tbl:removeEventListener(ev) end

function memo.peak(ev)
  return state[ev]
end

return memo
