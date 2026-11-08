<p align="center">
  <img src="https://raw.githubusercontent.com/EnhancedUNC/eUNC/main/assets/banner.png" alt="eUNC - No spoof, just proof." width="600">
</p>

<p align="center">
  <br>
  <strong>Enhanced UNC Benchmark</strong>
  <br>
  <em>No spoof, just proof.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/github/repo-size/EnhancedUNC/eUNC?style=flat-square&color=50C878&label=Repository%20Size">
  <img src="https://img.shields.io/github/languages/code-size/EnhancedUNC/eUNC?style=flat-square&color=50C878&label=Code%20Size">
  <img src="https://img.shields.io/github/license/EnhancedUNC/eUNC?style=flat-square&color=50C878">
  <img src="https://img.shields.io/github/last-commit/EnhancedUNC/eUNC?style=flat-square&color=50C878&label=Last%20Commit">
</p>

---

## About

**eUNC (Enhanced UNC)** is an open-source Roblox executor capability benchmark designed to test, verify, and report executor functionality.

Rather than simply checking whether an API exists, eUNC aims to verify whether individual functions behave as expected through dedicated functional tests.

All results are displayed directly in the executor console, providing a straightforward overview of supported capabilities.

## Features

- Individual capability tests
- Functional API verification
- Console-based reporting
- Pass, fail, and unknown classifications
- Overall compatibility scoring
- Organized test categories
- Executor identification

*Features are planned and subject to change during development.*

## Test Results

eUNC uses three primary result indicators:

| Indicator | Result | Description |
|:---:|---|---|
| ✅ | PASS | The test completed successfully. |
| ❌ | NOT PASSED | The test did not pass its verification. |
| ⏺️ | UNKNOWN | The result could not be determined. |

**Important:** A failed test does not necessarily mean an executor is broken. It simply means the test did not pass.

## Test Categories

Planned testing categories include:

- Cryptography
- Debug Library
- Closures
- Drawing API
- Filesystem
- Metatables
- Environment
- Instance Utilities
- Script Utilities
- HTTP Requests
- WebSockets
- Executor Identification

## Example Output

```text
[eUNC] Enhanced UNC Benchmark

Executor: ExampleExecutor

✅ crypt.base64.encode
✅ crypt.base64.decode
✅ hookmetamethod
❌ filesystem.readfile
⏺️ debug.getconstant

--------------------------------
eUNC Results
--------------------------------

✅ Passed: 125
❌ Not Passed: 35
⏺️ Unknown: 20

Total Tests: 180
Score: 69.44%

--------------------------------
No spoof, just proof.
--------------------------------
```

*Example output only. Values are illustrative.*

## Development

eUNC is currently under development. Test coverage, scoring, and implementation details may change as the project evolves.

## License

This project is licensed under the [MIT License](LICENSE).

---

<p align="center">
  <strong>eUNC — No spoof, just proof.</strong>
  <br>
  <sub>Enhanced UNC Benchmark</sub>
</p>
