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

### Search jots by title or tag
syntax:
```bash
jot <single-query>
```
ex:
```bash
jot coding
```

### Search jots by body text
syntax:
```bash
jot -b <query>
```
ex:
```bash
jot -b "this is a substring in a jot's body text"
```

## Notes
Jots are currently saved as markdown in the jots/ directory in this project.  The location of this should be configurable - possibly by utilizing `jot-store.dat`.