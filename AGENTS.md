# Configuration change documentation

Keep user-facing configuration documentation in `doc/`. This folder is local
and ignored by Git. Keep the root `README.md` empty.

Whenever you change configuration, update the relevant documentation in `doc/`
and append an entry to `doc/CHANGELOG.md`. Include the date, files changed, what
changed, why, and how to use or reload the change. For plugins, include their
purpose and any setup steps. For bindings and aliases, include the exact keys
or command and what they do. Never include credentials or secrets.

Preserve existing documentation. If `doc/` is missing on another checkout,
create it before documenting new changes.
