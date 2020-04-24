# T-50 

This container builds [T50](https://gitlab.com/fredericopissarra/t50), the mixed packet injector tool. 

## To run and use t50, you must pass a capability or run the container privileged (which is not the best practice):

```bash
$ docker run -it --rm --cap-add SYS_NICE l30bola/t50:v5.8.7
```

Or, running as a privileged container (again, not recommended):

```bash
$ docker run -it --rm --privileged l30bola/t50:v5.8.7
```
