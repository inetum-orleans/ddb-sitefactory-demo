# ddb-sitefactory-demo
Demo of building a site factory repository with ddb

The branch main contains common code for each site. Each site is in a separate branch, e.g. `site1`, `site2`, etc.

Thanks to ddb, you can easily split your project between branches without conflicts.

## Getting started

1. Install [a docker devbox](https://github.com/inetum-orleans/docker-devbox)
2. Clone the repository
3. Choose your branch, e.g. `git switch site1`
4. Inside the repository, run `ddb configure`
5. `cd .` or `$(ddb activate)` to activate the devbox environment
6. Put your database dump inside `.docker/postgres/dumps/`
7. Run `docker compose up -d`
8. Open your browser at the site's address (look for `Host(` in your generated docker-compose.yml)

## Switching projects

To switch to another project:

1. `git switch site2` (or any other branch)
2. Run `ddb configure` again to update the configuration
3. Run `cd .` or `$(ddb activate)` to re-activate the new environment
4. If you have a different database dump for this project, replace the one in `.docker/postgres/dumps/` (first startup only)
5. Run `docker compose up -d`
6. Open your browser at the new site's address

This procedure allows you to easily switch between different site configurations without conflicts, as each site has its own branch with specific settings and code, but it has the drawback that you need to switch branches to change sites, which means you cannot run multiple sites at the same time.

You can use `git worktree` to have multiple branches checked out in different directories, allowing you to run multiple sites simultaneously. For example:
```bash
git worktree add ../site1 site1
git worktree add ../site2 site2
```

This will create two directories, `../site1` and `../site2`, each with its own branch checked out. You can then run `ddb configure` in each directory and start the Docker containers independently.