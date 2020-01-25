# Minisign Github Action

This action makes [Minisign](https://jedisct1.github.io/minisign/) available to
you in your github actions.

## Inputs

### `minisign_key`

_Optional_

Contents of this input should be a plaintext minisign key. At the start of the
run the contents are written to disk at `~/.minisign/minisign.key` (by default).

If you want to change the path this writes, set the `MINISIGN_KEY_PATH` to
another value in the environment. If you do this, make sure to remember to set
`-p` correctly in your args.

If you're going to provide a signing key via some other mechanism, you can skip
setting this. This input exists to provide a convenient mechanism to get a key
from a github repo secret onto disk.

### `password`

_Optional_

If your minisign key has a password attached, put the contents of that password
in here.

## Outputs

None

## Example usage

### Verification
```yaml
steps:
  - name: fetch minisign 0.8 release
    run: |
      wget \
        https://github.com/jedisct1/minisign/releases/download/0.8/minisign-0.8.tar.gz \
        https://github.com/jedisct1/minisign/releases/download/0.8/minisign-0.8.tar.gz.minisig
  - name: verify minisign 0.8 release
    uses: thomaso-mirodin/minisign-action@v1
    with:
      args: -Vm "minisign-0.8.tar.gz" -P "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"
```

### Signing
```yaml
steps:
    - name: Sign our test file
      uses: thomaso-mirodin/minisign-action@v1
      with:
        args: -Sm path/to/artifact
        minisign_key: ${{ secrets.minisign_key }}
        password: ${{ secrets.minisign_password }}
    - name: upload the signature
      uses: actions/upload-artifact@v1
      with:
        name: my-signature
        path: path/to/artifact.minisig
```

## Contributions / Help Wanted
I'd love to expand this to be more than a thin wrapper around the CLI but that
was good enough for me to get started so I've stopped here for now.

If you want to add features (e.g. let users pass environment variables to set
the signing and verification keys) just open an issue and I'd be happy to work
on it with you!

### Future work?
- [ ] Investigate if it is worth it to switch from using docker to JS via the
  [wasm impl](https://wapm.io/package/jedisct1/minisign) so we can spend less
  time installing c++ toolchains
  