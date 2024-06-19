# Setting Up a Project for SCSS Compilation Using Gulp

This guide will help you set up a project to compile SCSS files using Gulp and a Bash script on both Windows and Linux operating systems.

## Requirements

- Node.js and npm
- Gulp
- Sass

## Step 1: Install Node.js and npm

If you haven't installed Node.js and npm yet, visit the [official Node.js website](https://nodejs.org/) and install the latest stable version. After installation, verify that everything is installed correctly:

```bash
node --version
npm --version
```

## Step 2: Install Gulp and Required Plugins
Install Gulp globally if you haven't already:

```npm install -g gulp-cli```

Create a package.json file in the root directory of your project if it's not already created:

```npm init -y```

Install Gulp and the required plugins locally:
```npm install --save-dev gulp gulp-shell```


## Step 3: Install Sass
Ensure Sass is installed globally by running the following command:

```npm install -g sass```

Verify Sass installation:
```sass --version```

If Sass is already installed globally, you can skip this step.


## Step 4: Create a Bash Script for SCSS Compilation

Create a compile-scss.sh file in the root directory of your project and copy the following script into it:

```
#!/bin/bash

# Check if sass is installed
if ! command -v sass &> /dev/null; then
    echo "sass command could not be found. Please install sass."
    exit 1
fi

# Define input and output directories
INPUT_DIR="src/scss"
OUTPUT_DIR="dist/css"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find all SCSS files in the input directory and compile them into the output directory
find "$INPUT_DIR" -name "*.scss" -not -name "_*.scss" | while read -r FILE; do
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "${FILE%.scss}.css")"
  sass "$FILE" "$OUTPUT_FILE"
done


```

## Step 5: Configure Gulp to Execute the Bash Script

Create a gulpfile.js in the root directory of your project and copy the following code into it:

```
const gulp = require('gulp'); // Importing the Gulp module
const shell = require('gulp-shell'); // Importing gulp-shell module for executing Shell commands

// Task for compiling SCSS using a Bash script
gulp.task('compile-scss', () => {
  return gulp.src('compile-scss.sh', { read: false }) // Using gulp.src to pass a Shell command from compile-scss.sh
    .pipe(shell(['./compile-scss.sh'], { // Executing the Bash script ./compile-scss.sh
      verbose: true, // Output additional information
      ignoreErrors: false // Do not ignore errors
    }));
});

// Task for watching changes in SCSS files and triggering compilation
gulp.task('watch-scss', () => {
  gulp.watch('src/scss/**/*.scss', gulp.series('compile-scss')); // Watching all SCSS files in src/scss/ directory and subdirectories
});

// Default task to compile SCSS and start watching for changes
gulp.task('default', gulp.series('compile-scss', 'watch-scss'));


```
Executing the Bash script, run in terminal ```./compile-scss.sh```

Folder structure:

```
project-root/
├── src/
│   └── scss/
│       └── (your SCSS files)
├── dist/
│   └── css/
│       └── (compiled CSS will be output here)
├── compile-scss.sh
├── gulpfile.js
├── package.json
└── index.md
```
In this structure:

- **src/scss/**: Directory where your SCSS files are located.
- **dist/css/**: Directory where compiled CSS files will be output.
- **compile-scss.sh**: Bash script for compiling SCSS files.
- **gulpfile.js**: Configuration file for Gulp where tasks for compilation and watching changes are defined.
- **package.json**: File describing your project and dependencies, including Gulp.
- **index.md**: Instruction guide for setting up the project for SCSS compilation.

This structure demonstrates the organization of your project, allowing efficient use of Gulp for automating the SCSS compilation process.


## Step 6: Compile SCSS and Watch for Changes

Now you're ready to compile your SCSS files and watch for changes. Run in terminal "gulp" to automatically compile SCSS:

```gulp```

This will execute the default task defined in gulpfile.js, which compiles your SCSS files once and starts watching for changes to automatically recompile them.

This guide provides a detailed explanation of each step to set up your project for SCSS compilation using Gulp and Bash. I hope this meets your expectations!