--[[

  Simple Corona event delegation.
  "R"/"L" = Runtime/Local
  "F"/"T" = Function/Table
  `.peak` allows you to access the last data state of any channel

--]]

local memo = {}
local state = {}

function memo.pub(ev, payload)
  Runtime:dispatchEvent({name = ev, data = payload})
  state[ev] = data
end

function memo.subRF(ev, fn) Runtime:addEventListener(ev, fn) end
function memo.subRT(ev, tbl, fn) tbl[ev] = fn; Runtime:addEventListener(ev, tbl) end
function memo.subLF(ev, tbl, fn) tbl:addEventListener(ev, fn) end
function memo.subLT(ev, tbl, fn) tbl[ev] = fn; tbl:addEventListener(ev) end

function memo.unsubRF(ev, fn) Runtime:removeEventListener(ev, fn) end
function memo.unsubRT(ev, tbl) Runtime:removeEventListener(ev, tbl) end
function memo.unsubLF(ev, tbl, fn) tbl:removeEventListener(ev, fn) end
function memo.unsubLT(ev, tbl) tbl:removeEventListener(ev) end

function memo.peak(ev)
  return state[ev]
end

return memo
