# Dev Forge package validation

- Trigger tests: `python3 -m unittest discover -s tests -v`
- Syntax: `python3 -m py_compile plugins/dev-forge-trigger/__init__.py`
- Installer shell syntax: `bash -n scripts/install.sh`
- Web-forge environment doctor: `node skills/web-forge/scripts/forge.mjs doctor`

Optional Graphify, browser, and provider-backed Hallmark checks are not part of the lightweight gate. They require their dependencies and configuration to be separately available.
