import os
import net

proc domain(name: string): string =
    if name[0..8] == "gemini://":
        return name[9 ..< len(name)] 
    else:
        return name

var 
    s = newSocket()
    c = newContext(protSSLv23, CVerifyNone)
    site: string = domain(paramStr(1))
    lines = "abc"

c.wrapSocket(s)

s.connect(site, Port(1965))
s.send("gemini://" & site & "/index.gmi" & "\r\n")

while lines != "":
    lines = s.recvLine()
    stdout.writeLine(lines)

s.close()