# ASM Coding Challenges

This project contains a set of assembly and C programming challenges. The tasks focus on implementing classic algorithms recursively and leveraging assembly for algorithmic challenges in network intrusion detection systems.

## Features

- **Task 1 - Parantezinator**
  Check the correctness of parentheses in a configuration rule file. The function returns 0 when the parentheses are correctly paired and 1 otherwise.

- **Task 2 - Divide et impera**
  Recursive implementations of:
  - **Quick Sort:** The function sorts an integer array in ascending order.
  - **Binary Search:** The function searches for a target element within a sorted array and returns its position (or -1 when not found).

- **Task 3 - Depth First Search (DFS)**
  A recursive DFS implementation that traverses a network topology and prints nodes as they are visited. It uses a provided `expand` function to obtain graph neighbours.

- **Bonus - x64 Assembly Map & Reduce**
  Recursive implementations of:
  - **Map:** Applies a function to each element in an array.
  - **Reduce:** Aggregates array values using a binary function.

## Building and Running the Project

You can build and execute the tasks using the provided Makefiles and scripts. Here are some examples:

```bash
# Build all tasks and run tests
./local.sh checker
```

```bash
# Run a single test for Quick Sort (e.g., test number 3)
./checker qsort 3
```

```bash
# Run a single test for Binary Search (e.g., test number 10)
./checker bsearch 10
```

## Docker Operations

The project supports Docker-based builds and testing. Common Docker commands are:

```bash
./local.sh docker build --image_name suricate/tasks --tag latest --registry gitlab.cs.pub.ro:5050 [--force_build]
./local.sh docker push --user <user> --token <token> --image_name suricate/tasks --tag latest --registry gitlab.cs.pub.ro:5050
```

These commands use the included Dockerfile to build or push a Docker image of this project.

## Implementation Details

- **Languages Used:**
  - **C:** For interfacing tests and core logic.
  - **Assembly:** For implementing the algorithmic tasks (e.g., quick sort, binary search, DFS, map, and reduce).
  - **Python & Shell:** For the automated checker and build scripts.

- **Project Structure:**
  - `assignment.md`: Contains the assignment description and detailed requirements.
  - `src/`: Source code for all tasks and bonus implementations.
  - `checker/`: Contains checker scripts to compile, execute, and evaluate the tasks.
  - `linter/`: Assembly linter scripts that automatically validate assembly coding styles.
  - `Dockerfile` and `local.sh`: For Docker-based operations and local testing.

## Example Usage

To run all tests and see the overall results:

```bash
./checker/checker.py --all
```

To run tests for the bonus tasks only:

```bash
./checker/checker.py --task b
```

To run tests for a specific task (for instance, Task 2):

```bash
./checker/checker.py --task 2
```

The final score is calculated by aggregating points from all implemented tasks and applying any deductions related to linter errors or documentation issues.