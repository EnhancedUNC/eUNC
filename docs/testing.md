# eUNC Testing Notes

eUNC is a client-side capability benchmark. A PASS means the specific behavioral
check completed successfully; it is not proof that an executor is impossible to
spoof. Client-side code can be modified or intercepted by the environment being
measured.

## Result meanings

- PASS: the test's expected behavior was observed.
- FAILED: the check ran and did not meet its expected behavior.
- UNKNOWN: the test could not safely or reliably determine behavior.

Some network, hook, readonly-state, and script-inspection tests are intentionally
UNKNOWN unless a safe, explicit test target is available. The benchmark avoids
sending unsolicited network traffic or modifying game-owned state.

## Debug settings

```lua
getgenv().eUNCDebug = {
    ["printcheckpoints"] = false,
    ["delaybetweentests"] = 0,
    ["printtesttimetaken"] = false,
}
```

`delaybetweentests` is clamped between 0 and 5 seconds.
