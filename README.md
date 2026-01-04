# Minisign Github Action

This action makes [Minisign](https://jedisct1.github.io/minisign/) available to
you in your github actions.

## Inputs

### `minisign_key`

_Optional_

Contents of this input should be a plaintext minisign key. At the start of the
run the contents are written to disk at `~/.minisign/minisign.key` (by default).

You can also provide a signing key via some other mechanism. This input exists
to provide a convenient mechanism to get a key from a github repo secret onto
disk.

If you want to change the path where this writes, you can set the environment
variable `MINISIGN_KEY_PATH` to another value via your action's `env` field. If
you do this, make sure to remember to set `-p` correctly in your args.


### `password`

_Optional_

If your minisign key has a password attached, put the contents of that password
in here.

## Outputs

None

## Example Usage

### Verification
```yaml
steps:
  - name: Fetch "third-party" artifact
    run: |
      wget \
        https://github.com/jedisct1/minisign/releases/download/0.12/minisign-0.12.tar.gz \
        https://github.com/jedisct1/minisign/releases/download/0.12/minisign-0.12.tar.gz.minisig
  - name: Verify artifact's integrity with their published key
    uses: thomasdesr/minisign-action@v1
    with:
        args: -Vm "minisign-0.12.tar.gz" -P "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"
```

### Signing
```yaml
steps:
    - name: Sign our test file
      uses: thomasdesr/minisign-action@v1
      with:
        args: -Sm path/to/artifact
        minisign_key: ${{ secrets.minisign_key }}
        password: ${{ secrets.minisign_password }}
    - name: Upload the signature
      uses: actions/upload-artifact@v1
      with:
        name: my-signature
        path: path/to/artifact.minisig
```

## Contributions / Help Wanted
I feel like maybe this should be more than a thin wrapper around the CLI but it
has been good enough for me solve my immediate needs so I've stopped here for
now.

If you want to add features just open an issue and I'd be happy to work on it
with you!

### Future work?
- [ ] Investigate if it is worth it to switch from using docker to JS via the
  [wasm impl](https://wapm.io/package/jedisct1/minisign) so we can spend less
  time installing c++ toolchains.
- [ ] Maybe publish a copy of this container to a registry somewhere so we can
  swap compile for download times?
