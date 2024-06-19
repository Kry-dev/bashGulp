const gulp = require('gulp');
const shell = require('gulp-shell');

gulp.task('compile-scss', () => {
  return gulp.src('compile-scss.sh', { read: false })
    .pipe(shell(['./compile-scss.sh'], {
      verbose: true, // Додайте цю опцію для виведення додаткової інформації
      ignoreErrors: false // Переконайтеся, що помилки не ігноруються
    }));
});

gulp.task('watch-scss', () => {
  gulp.watch('src/scss/**/*.scss', gulp.series('compile-scss'));
});

gulp.task('default', gulp.series('compile-scss', 'watch-scss'));
