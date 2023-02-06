# jott
## A command-line note taking app built with Ada!

### setup
- install [Alire](https://alire.ada.dev/docs/#getting-started)
- pull repo
- `alr build`
### Create a jott
syntax:
```bash
jott <title> <tag1,tag2,tagN> <"body text">
```
ex:
```bash
jott new-title coding,random "lorem ipsum"
```
```bash
jott some-title examples "
This is a
multiline jott\!"
```
### List your jotts
```
jott
```

### Search jotts by title or tag
syntax:
```bash
jott <single-query>
```
or:
```bash
jott -t <single-query>
```
ex:
```bash
jott coding
```
```bash
jott -t coding
```
### Search jots by body text
syntax:
```bash
jott -b <query>
```
ex:
```bash
jott -b "this is a substring in a jott's body text"
```
You can also perform strict searches where a match only occurs if the first param matches a substring in the jott's title or tags and the second param matches a substring in the body. The order of flags doesn't matter.

syntax:
```bash
jott -tb <title or tag search> <body search>
```
ex: 
```bash
jott -tb html "class=\"custom-class\""
```

## Flags
- `-t`
	- title/tag search
- `-b`
	- body search
- `-i`
	- case insensitive search
- `-c`
	- add character count column to output

## Notes
Jotts are currently saved as markdown in the jotts/ directory in this project.  The location of this should be configurable - possibly by utilizing `jott-store.dat`.

## Todos
- add help command

## Useful Bash Commands
- get the `nth` jott path from a search result
  ```bash
  jott <some-query> | sed -n '2 p'
  ```
- get the last jott path from a search result
  ```bash
  jott <some-query> | sed -n '$p'
  ```
- print the contents of results
  ```bash
  jott <some-query> | xargs cat
  ```
