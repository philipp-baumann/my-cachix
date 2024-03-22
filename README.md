# Set up and build the cache

This action repo was started with what is explained here on
[nix.dev](https://nix.dev/tutorials/nixos/continuous-integration-github-actions#github-actions).

If you fork this repo and want to push to a custom repo, you will need to 
 
1. Set up your own cache on [https://www.cachix.org/](https://www.cachix.org/)
2. Adjust `.github/workflows/cachex-rstats.yml` to use your own cache via name
3. Generate the `CACHIX_AUTH_TOKEN` via `Settings` button at
   `https://app.cachix.org/cache/<name-of-your-cache>`
4. Copy and add the generated `CACHIX_AUTH_TOKEN` as Secret under the same name
   for your fork

There are different (additional) ways to push artefacts to a personal cachix
store, like [my test one](https://app.cachix.org/cache/philipp-baumann). See the
[official cachix docs for more about it](https://docs.cachix.org/getting-started#pushing-binaries-with-cachix).

# Use the cache

To use the cache, install it locally.

```sh
nix-env -iA cachix -f https://cachix.org/api/v1/install
```

You can automatically write `$HOME/.config/nix/nix.conf` like so.

However, currently, you need a `x86_64-linux` system to use the cache, since
the action runs on runners with this architecture.

```sh
cachix use philipp-baumann
# echoes:
# Configured https://philipp-baumann.cachix.org binary cache in /Users/philipp/.config/nix/nix.conf
```

If you don't want to use that cache anymore, simply disable with

```sh
cachix remove philipp-baumann
```

Then, test building the `default.nix` based on this CI-gerated cache.

```sh
nix-build
# should do something like this (hashes will change, since below might not be
# updated) >
# these 6 paths will be fetched (39.52 MiB download, 71.31 MiB unpacked):
#   /nix/store/mz9bml88bx3yv3mvgj6m777z5qdib4pb-R-4.3.2
#   /nix/store/m1ca3rcqjdafwwjfbnl3mk5lwlz4gcwc-R-4.3.2-tex
#   /nix/store/cs41wvvf98zsgw7vbpfabj5f8d2y0ihz-nix-2.18.2
#   /nix/store/7qsff6v68iwdlz5amx05hgqga3gcgb3p-nix-2.18.2-man
#   /nix/store/5w976r6aa8mapm9bvssisiy565lz44ql-nix-shell
#   /nix/store/940iyq59nbs4dz288vglfz94b6i1gb81-r-data.table-1.14.10
# copying path '/nix/store/m1ca3rcqjdafwwjfbnl3mk5lwlz4gcwc-R-4.3.2-tex' from 'https://cache.nixos.org'...
# copying path '/nix/store/7qsff6v68iwdlz5amx05hgqga3gcgb3p-nix-2.18.2-man' from 'https://cache.nixos.org'...
# copying path '/nix/store/mz9bml88bx3yv3mvgj6m777z5qdib4pb-R-4.3.2' from 'https://cache.nixos.org'...
# copying path '/nix/store/cs41wvvf98zsgw7vbpfabj5f8d2y0ihz-nix-2.18.2' from 'https://cache.nixos.org'...
# copying path '/nix/store/940iyq59nbs4dz288vglfz94b6i1gb81-r-data.table-1.14.10' from 'https://cache.nixos.org'...
# copying path '/nix/store/5w976r6aa8mapm9bvssisiy565lz44ql-nix-shell' from 'https://philipp-baumann.cachix.org'...
# /nix/store/5w976r6aa8mapm9bvssisiy565lz44ql-nix-shel
```
