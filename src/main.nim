import os
import net
import std/wordwrap

proc domain(name: string): string =
    if name[0..8] == "gemini://":
        return name[9 ..< len(name)] 
    else:
        return name

var 
    site: string = domain(paramStr(1))
    lines: string = "abc"
    isRunning: bool = true

let 
    s = newSocket()
    c = newContext(protSSLv23, CVerifyNone)

c.wrapSocket(s)

s.connect(site, Port(1965))
s.send("gemini://" & site & "/index.gmi" & "\r\n")

while isRunning:
    lines = s.recvLine()
    if len(lines) > 0:
        if lines[0..1] == "20":
            lines = ""
        elif lines == "```":
            lines = ""
        echo lines.wrapWords(80, true)
    else:
        break

s.close()
