# jot
## A command-line note taking app built with Ada!

### setup
- install [Alire](https://alire.ada.dev/docs/#getting-started)
- pull repo
- `alr build`
### Create a jot
syntax:
```bash
jot <title> <tag1,tag2,tagN> <"body text">
```
ex:
```bash
jot new-title coding,random "lorem ipsum"
```
```bash
jot some-title examples "
This is a
multiline jot\!"
```
### List your jots
```
jot
```

### Search your jots (single arg only)
syntax:
```bash
jot <single-query>
```
ex:
```bash
jot coding
```

## Notes
Jots are currently saved as markdown in the jots/ directory in this project.  The location of this should be configurable - possibly by utilizing `jot-store.dat`.