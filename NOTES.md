# NOTES

Apparently this will suppress the warnings that the `vim` object is not defined - create
a file called `.luarc.json` at the top level with these contents:

```json
{
  "diagnostics": {
    "globals": ["vim"]
  }
}
```


But I am not seeing those warnings without that file, so just storing this
bit of knowledge until it may be needed.

