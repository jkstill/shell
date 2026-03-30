
Question: how best to return a value from a bash function that can be used in tests to indicate success or failure?

Returning 0 or 1 is sometimes used.

At other times the exit code of commands in the function is used to indicate success or failure.

Still others use true or false to indicate success or failure.


Test Examples:

my func parameters-here || echo "Function failed"
if my func parameters-here; then
  echo "Function succeeded"
else
  echo "Function failed"
fi

In bash, the best way to indicate success or failure from a function is to use the exit status. 

By convention, an exit status of 0 indicates success, while any non-zero value indicates failure. This allows you to easily check the result of the function in your tests.

Here's an example of how to define a function that returns an exit status, and how to use it in tests:

```bash#!/bin/bash
my_function() {
  # Perform some operations
  if [ some_condition ]; then
    return 0  # Success
  else
    return 1  # Failure
  fi
}
# Test the function
if my_function; then
  echo "Function succeeded"
else
  echo "Function failed"
fi
```

# Alternatively, you can use the exit status directly in a command

my_function || echo "Function failed"

my_function && echo "Function succeeded" || echo "Function failed"

What about true and false?In bash, `true` and `false` are built-in commands that return exit statuses of 0 and 1, respectively. 

You can use them in your functions to indicate success or failure. For example:

```bash
my_function() {
  # Perform some operations
  if [ some_condition ]; then
    true  # Success
  else
    false  # Failure
  fi
}
```
However, using `return 0` and `return 1` is more explicit and is generally preferred for clarity when defining functions. It clearly indicates that you are returning an exit status from the function, whereas `true` and `false` are more commonly used in command contexts rather than within functions.

    
