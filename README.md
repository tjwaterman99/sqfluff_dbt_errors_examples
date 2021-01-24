Basic dbt starter projec to test the functionality of sqlfluff.

Append the profiles to your dbt `profiles.yml` file.

```
cat profiles.yml >> ~/.dbt/profiles.yml
```

Install dbt and sqlfluff.

```
pip install dbt==0.18 sqlfluff==0.4.0.a3
```

Install the dbt packages.

```
dbt deps
```

Try linting the example models.

```
sqlfluff lint models
```

You should see errors the following errors when trying to lint the priject.

### Example errors

Using `union all` in a model is recorded as "unparsable."

```
== [models/example/union_all_example.sql] FAIL
L:   5 | P:  19 |  PRS | Found unparsable section: '\n union all\n select null as
                       | id'
WARNING: Parsing errors found and dialect is set to 'ansi'. Have you configured your dialect?
```

Using `dbt_utils` in a model doesn't raise an unparsable error, but it does raise what I think could be an unfixable linting error: the error _might_ be caused by the structure of the sql that gets injected from the dbt_utils package.

```
== [models/example/dbt_utils_example.sql] FAIL
L:   5 | P:  25 | L001 | Unnecessary trailing whitespace.
L:   6 | P:   5 | L003 | Indent expected and not found compared to line #5
L:   7 | P:   1 | L003 | Line under-indented compared to line #5
```

Disabling a model from inside the `dbt_project.yml` file causes a "file not found" exception.

```
sqlfluff lint models/disabled

...

RuntimeError: File models/disabled/disabled_model.sql was not found in dbt project
```